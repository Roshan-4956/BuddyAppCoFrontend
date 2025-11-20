import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../../../../features/auth/application/services/token_storage_service.dart';
import '../../../../utils/logger.dart';
import '../../providers/api_error_providers.dart';
import '../simple_api/abstract_simple_params.dart';
import '../simple_api/simple_api.dart';

/// A Riverpod-aware implementation of SimpleAPI that integrates with Flutter's
/// Riverpod state management library.
///
/// Features:
/// * Automatic state notifications to Riverpod
/// * Common header management
/// * Authentication state handling
/// * Version and user agent management
///
/// Example:
/// ```dart
/// @riverpod
/// RiverpodAPI<MyModel, MyParams> myApi(MyApiRef ref) {
///   return RiverpodAPI(
///     completeUrl: 'https://api.example.com',
///     factory: MyModel.fromJson,
///     method: HTTPMethod.get,
///     params: MyParams(),
///     ref: ref,
///   );
/// }
/// ```
class RiverpodAPI<MODEL, PARAM extends AbstractSimpleParameters>
    extends SimpleAPI<MODEL, PARAM> {
  final Ref ref;

  final bool requiresAuth;

  RiverpodAPI({
    required super.completeUrl,
    required super.factory,
    required super.method,
    required super.params,
    required this.ref,
    super.resetParamsOnExecute = false,
    this.requiresAuth = true,
    super.showToastOnError = true,
  }) : super(
         changeListener: () {
           ref.notifyListeners();
         },
       );

  @override
  void onUnauthorized() {
    super.onUnauthorized();
    final handler = ref.read(unauthorizedErrorProvider);
    if (handler != null) {
      debugLog(
        DebugTags.apiError,
        'Unauthorized 401 detected. Calling handler.',
      );
      handler(ref);
    }
  }

  @override
  Future<BaseRequest> generateRequest() async {
    var req = (await super.generateRequest());
    req.headers.addAll(await generateCommonHeaders());
    return req;
  }

  Future<Map<String, String>> generateCommonHeaders() async {
    Map<String, String> headers = {
      'USER-AGENT': 'mobile',
      'APP-VERSION': '2.0.0',
    };

    if (requiresAuth) {
      try {
        final tokenService = ref.read(tokenStorageServiceProvider);
        final token = await tokenService.getAccessToken();

        if (token != null && token.isNotEmpty) {
          headers['Authorization'] = 'Bearer $token';
        } else {
          debugLog(debugTag, 'Login Required: Auth token not found.');
          throw Exception('Auth token not found.');
        }
      } catch (e) {
        debugLog(debugTag, 'Error getting auth token: $e');
        rethrow;
      }
    }

    return headers;
  }
}
