/// Generic response model for all API responses
/// Wraps the success status, message, and optional data
class ApiResponse<T> {
  final bool isSuccess;
  final String message;
  final T? data;

  const ApiResponse({
    required this.isSuccess,
    required this.message,
    this.data,
  });

  /// Creates an ApiResponse from a JSON map and a data factory
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json)? fromJsonT,
  ) {
    return ApiResponse(
      isSuccess: json['is_success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
    );
  }

  /// Converts the ApiResponse back to JSON
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'is_success': isSuccess,
      'message': message,
      'data': data != null ? toJsonT(data as T) : null,
    };
  }
}
