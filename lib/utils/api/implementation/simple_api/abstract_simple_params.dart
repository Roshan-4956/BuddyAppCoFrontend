/// Abstract interface for API parameter handling
///
/// Defines the contract for managing various aspects of an HTTP request including:
/// - Headers
/// - Body (encoded and unencoded)
/// - Files
/// - URL formatting
abstract class AbstractSimpleParameters {
  /// Returns the headers to be sent with the request
  Map<String, String> getHeaders();

  /// Returns the request body encoded as a string (typically JSON)
  String getBodyEncoded();

  /// Returns the raw unencoded request body
  Map<String, dynamic> getBodyUnencoded();

  /// Returns a map of files to be uploaded
  Map<String, String> getFiles();

  /// Formats the base URL with any additional parameters
  String getFormattedUrl(String raw);

  /// Optional URL override
  String? get overriddenUrl;

  /// Resets all parameters to their default state
  void reset();
}
