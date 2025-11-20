import 'global_settings.dart';

/// Manages URL configurations for the application's API endpoints.
///
/// Provides constants and utilities for handling both production and test
/// server URLs, including resource and API server endpoints.
class URLs {
  /// Base URL for the main resource server
  static const String _mainResourceServerUrl =
      'https://buddy-backend.built.systems';

  /// Base URL for the test resource server
  static const String _testResourceServerUrl = 'http://172.17.103.95:8000';

  /// API version path
  static const String _apiVersion = '/api/v1';

  /// Main API server endpoint, derived from the main resource server
  static const String _mainApiServerUrl = '$_mainResourceServerUrl$_apiVersion';

  /// Test API server endpoint, derived from the test resource server
  static const String _testApiServerUrl = '$_testResourceServerUrl$_apiVersion';

  /// Current active server URL based on production/test environment
  static const String serverUrl = !GlobalSettings.useProductionServer
      ? _testApiServerUrl
      : _mainApiServerUrl;

  /// Current active resource URL based on production/test environment
  static const String resourceUrl = GlobalSettings.useProductionServer
      ? _testApiServerUrl
      : _mainApiServerUrl;

  /// Completes a partial URL path by prepending the active server URL.
  ///
  /// [local] is the partial URL path to be completed.
  /// Returns the full URL as a String.
  static String complete(String local) {
    return '$serverUrl/$local';
  }
}
