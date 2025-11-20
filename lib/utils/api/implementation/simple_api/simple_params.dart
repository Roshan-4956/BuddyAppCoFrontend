import 'dart:convert';

import 'package:flutter/material.dart';

import 'abstract_simple_params.dart';

/// A concrete implementation of API parameters that provides a simple key-value based
/// approach for handling HTTP request configuration.
///
/// Features:
/// * Header management
/// * Request body (both encoded and raw)
/// * Query parameter handling
/// * File upload support
/// * URL formatting with pagination support
///
/// Example:
/// ```dart
/// final params = SimpleParameters();
/// params.headers['Authorization'] = 'Bearer token';
/// params.body['name'] = 'John';
/// params.queryParams['page'] = '1';
/// ```
class SimpleParameters extends AbstractSimpleParameters {
  @protected
  Map<String, String> headers = {};
  @protected
  Map<String, dynamic> body = {};
  @protected
  Map<String, String> queryParams = {};
  @protected
  Map<String, String> files = {};
  //  @protected
  //  String? suburl;
  @protected
  String? paginatedOverriddenUrl;

  /// Returns the body data JSON encoded as a string
  @override
  String getBodyEncoded() {
    return jsonEncode(body);
  }

  /// Returns a copy of the current headers
  @override
  Map<String, String> getHeaders() {
    return <String, String>{}..addAll(headers);
  }

  /// Formats the URL with query parameters if present
  ///
  /// If [paginatedOverriddenUrl] is set, returns that instead.
  @override
  String getFormattedUrl(String raw) {
    if (paginatedOverriddenUrl != null) {
      return paginatedOverriddenUrl!;
    }

    if (queryParams.isNotEmpty) {
      String res = '$raw?';
      queryParams.forEach((key, value) {
        res += '$key=$value&';
      });

      return res;
    } else {
      return raw;
    }
  }

  @override
  String? get overriddenUrl => null;

  @override
  void reset() {
    headers = {};
    body = {};
    queryParams = {};
    paginatedOverriddenUrl = null;
  }

  @override
  Map<String, dynamic> getBodyUnencoded() {
    return body;
  }

  @override
  Map<String, String> getFiles() {
    return files;
  }
}
