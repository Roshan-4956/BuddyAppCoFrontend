import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../global_settings.dart';
import '../../logger.dart';
import 'api_state.dart';
import 'api_state_holder.dart';
import 'either.dart';
import 'http_client_singleton.dart';

/// Base class for implementing API clients with built-in state management and error handling.
///
/// This class provides a robust foundation for making HTTP requests with:
/// * Automatic state management (loading, success, error states)
/// * Concurrent request handling
/// * Timeout management
/// * Response parsing
/// * Error recovery with previous valid results
abstract class AbstractAPI<
  RESULT_MODEL,
  REQUEST_PARAM,
  REQUEST_TYPE extends http.BaseRequest,
  RESPONSE_TYPE extends http.BaseResponse
>
    extends ApiStateHolder<RESULT_MODEL> {
  String get debugTag => '[API]: (${RESULT_MODEL.toString()})';
  String get errorTag => '[API ERROR]: (${RESULT_MODEL.toString()})';

  bool get resetWhileRefreshing => true;
  bool get allowConcurrentRequests => false;

  final String completeUrl;
  final String httpMethod;
  final RESULT_MODEL Function(String) factory;
  final int? timeoutSeconds;

  RESULT_MODEL? _currentResult;
  RESULT_MODEL? _latestValidResult;
  DateTime? _lastSuccessfulCallTime;
  DateTime? get lastSuccessfulCallTime => _lastSuccessfulCallTime;
  REQUEST_PARAM get requestParams;

  APIState _currentState = APIState.initial;

  RESULT_MODEL? get currentResult => _currentResult;

  /// Returns the latest valid result if available, either from current or previous success.
  RESULT_MODEL? get latestValidResult => _currentResult ?? _latestValidResult;

  @override
  RESULT_MODEL? get data => latestValidResult;

  @override
  APIState get state => _currentState;

  @override
  set state(APIState val) {
    _changeDataAndState(
      _currentResult,
      _latestValidResult,
      val,
      notifyIfSameState: true,
    );
  }

  final void Function()? onConcurrentRequestRejectListener;
  final void Function()? changeListener;
  final bool showToastOnError;

  AbstractAPI({
    required this.completeUrl,
    required this.factory,
    required this.httpMethod,
    this.timeoutSeconds = GlobalSettings.defaultTimeoutSecs,
    this.onConcurrentRequestRejectListener,
    this.changeListener,
    this.showToastOnError = true,
  }) : super();

  /// Generates an HTTP request with the current parameters
  Future<REQUEST_TYPE> generateRequest();

  /// Sends the HTTP request and returns the raw response
  Future<RESPONSE_TYPE> sendActual() async {
    if (RESPONSE_TYPE == http.Response) {
      var req = await generateRequest();
      debugLog(debugTag, '${req.method} ${req.url}');
      Future<http.StreamedResponse> sentReq;

      if (timeoutSeconds != null) {
        sentReq = HttpClientSingleton.instance
            .send(req)
            .timeout(Duration(seconds: timeoutSeconds!));
      } else {
        sentReq = HttpClientSingleton.instance.send(req);
      }
      return (await http.Response.fromStream(await sentReq)) as RESPONSE_TYPE;
    } else {
      throw UnimplementedError(
        'sendActual must be implemented for custom response types',
      );
    }
  }

  /// Parses the raw response into the result model type
  RESULT_MODEL parse(RESPONSE_TYPE response) {
    if (response is http.Response) {
      debugLog(
        debugTag,
        'Response Body: ${response.body}',
      ); // Log response body
      return factory(response.body);
    } else {
      throw UnimplementedError(
        'parse is not implemnted for ${response.runtimeType}',
      );
    }
  }

  void _callOnChangeListener() {
    changeListener?.call();
  }

  void _changeDataAndState(
    RESULT_MODEL? current,
    RESULT_MODEL? latestValid,
    APIState newState, {
    bool notifyIfSameState = true,
  }) {
    if (newState.isSuccess) {
      _lastSuccessfulCallTime = DateTime.now();
    }

    _currentResult = current;
    _latestValidResult = latestValid;

    bool stateChanged = newState != _currentState;
    _currentState = newState;

    if (stateChanged || notifyIfSameState) {
      _callOnChangeListener();
    }
  }

  @mustCallSuper
  void clear() {
    _changeDataAndState(null, null, APIState.initial);
  }

  /// Called when the API returns a 401 Unauthorized status.
  void onUnauthorized() {}

  /// Executes the API request with full error handling and state management
  Future<void> execute() async {
    if (allowConcurrentRequests && state.isOngoing) {
      onConcurrentRequestRejectListener?.call();
      return;
    }

    _startLoading();

    try {
      var res = await sendActual().toEither();
      res.fold(
        (response) => _handleResponse(response),
        (error) => _handleFailure(error),
      );
    } catch (e, stack) {
      debugLog(DebugTags.apiError, 'Critical API Exception: $e');
      debugLog(DebugTags.apiError, stack);
      _handleFailure(e);
    }
  }

  void _startLoading() {
    final bool hasData = _latestValidResult != null;
    if (resetWhileRefreshing) {
      _changeDataAndState(
        null,
        _latestValidResult,
        APIState.loading(hasData: hasData),
      );
    } else {
      _changeDataAndState(null, null, APIState.loading(hasData: false));
    }
  }

  void _handleResponse(RESPONSE_TYPE response) {
    debugLog(
      DebugTags.apiSuccess,
      'API $completeUrl completed. Status: ${response.statusCode}',
    );

    // Optional: Check for business logic failure flag in 200 OK response
    _checkBusinessLogicError(response);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        var parsed = parse(response);
        debugLog(debugTag, 'Parse Successful');
        _changeDataAndState(parsed, parsed, APIState.success);
      } catch (e) {
        debugLog(DebugTags.apiError, 'Model Parsing Failed: $e');
        _handleFailure(e, type: ErrorType.modelParseError);
      }
    } else {
      debugLog(
        DebugTags.apiError,
        'Server Error ${response.statusCode} for $completeUrl',
      );

      if (response.statusCode == 401) {
        onUnauthorized();
      }

      _logErrorDetails(response);

      _changeDataAndState(
        null,
        _latestValidResult,
        APIState.error(
          type: response.statusCode == 401
              ? ErrorType.unauthorized
              : ErrorType.serverError,
          hasData: _latestValidResult != null,
          message: 'Server Error: ${response.statusCode}',
        ),
      );
    }
  }

  void _checkBusinessLogicError(RESPONSE_TYPE response) {
    if (showToastOnError && response is http.Response) {
      try {
        final bodyMap = jsonDecode(response.body);
        if (bodyMap is Map<String, dynamic>) {
          if (bodyMap['is_success'] == false) {
            final msg =
                bodyMap['message'] ?? bodyMap['detail'] ?? 'Operation failed';
            userLog(msg, debugTag: DebugTags.apiError);
          }
        }
      } catch (_) {}
    }
  }

  void _logErrorDetails(RESPONSE_TYPE response) {
    if (showToastOnError && response is http.Response) {
      try {
        final bodyMap = jsonDecode(response.body);
        if (bodyMap is Map<String, dynamic>) {
          final msg =
              bodyMap['detail'] ?? bodyMap['message'] ?? 'Request failed';
          if (msg is List) {
            userLog(msg.join(', '), debugTag: DebugTags.apiError);
          } else {
            userLog(msg.toString(), debugTag: DebugTags.apiError);
          }
        }
      } catch (_) {
        // Fallback or ignore
      }
    }
  }

  void _handleFailure(Object? error, {ErrorType? type}) {
    debugLog(DebugTags.apiError, 'API Execution Failed: $error');

    final finalType =
        type ??
        ((error is SocketException || error is TimeoutException)
            ? ErrorType.networkError
            : ErrorType.unknown);

    if (showToastOnError && finalType == ErrorType.networkError) {
      userLog(
        'Connection failed. Please check your internet.',
        debugTag: DebugTags.apiError,
      );
    }

    _changeDataAndState(
      null,
      _latestValidResult,
      APIState.error(
        type: finalType,
        hasData: _latestValidResult != null,
        message: error.toString(),
      ),
    );
  }
}
