import 'dart:convert';

import '../../utils/api/core/api_response.dart';
import 'logger.dart';

/// Utility class for JSON parsing and model factory operations.
/// Provides helper methods to convert JSON strings into model objects and lists.
class FactoryUtils {
  /// Creates a function that converts a JSON string to a model instance
  /// [T] - The model type to create
  /// [factory] - Factory function that creates model from JSON map
  /// [subtag] - Optional JSON key to extract before parsing.
  ///            If 'data' is passed, it extracts 'data' field from envelope.
  static T Function(String) modelFromString<T>(
    T Function(Map<String, dynamic>) factory, {
    String? subtag,
  }) {
    return (rawStr) {
      try {
        var decoded = jsonDecode(rawStr);

        // Handle generic ApiResponse structure if needed, or simple subtag
        if (subtag != null) {
          // If response is wrapped in an envelope (common pattern), verify access
          if (decoded is Map<String, dynamic> && decoded.containsKey(subtag)) {
            var data = decoded[subtag];

            // If 'data' is null but required, it might be a void/null response or error
            if (data == null) {
              // If the API was successful but data is null, we might need to handle it.
              // For now, assume factory can handle empty map or check context.
              // But usually factory(null) is invalid.
              // Let's check if T is nullable or if factory handles it.
              // If standard response says success but data is null, what to return?
              // Usually factories take Map<String, dynamic>.
              throw Exception('Response field "$subtag" is null.');
            }
            return factory(data);
          } else if (decoded is Map<String, dynamic> &&
              !decoded.containsKey(subtag)) {
            // Fallback: maybe the response IS the data (no envelope)
            // or error structure.
            throw Exception('Response missing expected key "$subtag".');
          }
        }

        return factory(decoded);
      } catch (e) {
        // Logging is handled by AbstractAPI's error handler/toast logic usually.
        // But parsing error is critical.
        debugLog('Model Parsing Error (FactoryUtils)', e.toString());
        rethrow;
      }
    };
  }

  /// Creates a function that converts a JSON string to a list of model instances
  /// [T] - The model type to create
  /// [factory] - Factory function that creates model from JSON map
  /// [perElementSubtag] - Optional JSON key to extract for each list element
  /// [entireDataSubTag] - Optional JSON key to extract the entire list
  static List<T> Function(String) listFromString<T>(
    T Function(Map<String, dynamic>) factory, {
    String? perElementSubtag,
    String? entireDataSubTag,
  }) {
    return (str) {
      try {
        List<T> res = [];
        var decoded = jsonDecode(str);

        var listData = (entireDataSubTag == null
            ? decoded
            : decoded[entireDataSubTag]);

        if (listData == null) {
          // List is empty or null
          return [];
        }

        var list = listData as List<dynamic>;

        for (var element in list) {
          if (perElementSubtag == null) {
            res.add(factory(element));
          } else {
            res.add(factory(element[perElementSubtag]));
          }
        }

        return res;
      } catch (e) {
        debugLog('Model Parsing Error (FactoryUtils)', e.toString());
        throw Exception('${T.toString()} Model Parsing Failed: $e');
      }
    };
  }

  /// specialized factory for standardized ApiResponse
  static ApiResponse<T> Function(String) apiResponseFromString<T>(
    T Function(Map<String, dynamic>) dataFactory,
  ) {
    return (rawStr) {
      final decoded = jsonDecode(rawStr) as Map<String, dynamic>;
      return ApiResponse.fromJson(
        decoded,
        (json) => dataFactory(json as Map<String, dynamic>),
      );
    };
  }
}
