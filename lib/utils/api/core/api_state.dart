/// Classifies the types of errors that can occur during API operations.
enum ErrorType {
  none,
  networkError,
  serverError, // 4xx, 5xx
  unauthorized, // 401
  modelParseError,
  unknown,
}

/// High-level status of the API request.
enum APIStatus { initial, loading, success, error }

/// Comprehensive state management class for API requests.
/// Replaces the old complex enum with a clean, property-based approach.
class APIState {
  final APIStatus status;
  final ErrorType errorType;
  final bool hasData;
  final String? errorMessage; // Optional message for context

  const APIState._({
    required this.status,
    this.errorType = ErrorType.none,
    this.hasData = false,
    this.errorMessage,
  });

  // ===========================================================================
  // Factory Constructors (The "Clean" API)
  // ===========================================================================

  static const initial = APIState._(status: APIStatus.initial);

  static const success = APIState._(status: APIStatus.success, hasData: true);
  static const successWithData = success; // Alias

  /// Loading state, optionally preserving old data
  factory APIState.loading({bool hasData = false}) {
    return APIState._(status: APIStatus.loading, hasData: hasData);
  }

  /// Error state with specific type and optional data preservation
  factory APIState.error({
    required ErrorType type,
    bool hasData = false,
    String? message,
  }) {
    return APIState._(
      status: APIStatus.error,
      errorType: type,
      hasData: hasData,
      errorMessage: message,
    );
  }

  // ===========================================================================
  // Getters & Helpers
  // ===========================================================================

  bool get isInitial => status == APIStatus.initial;
  bool get isOngoing => status == APIStatus.loading;
  bool get isSuccess => status == APIStatus.success;
  bool get hasError => status == APIStatus.error;

  bool get hasInternetError => errorType == ErrorType.networkError;
  bool get hasServerError => errorType == ErrorType.serverError;
  bool get hasUnauthorizedError => errorType == ErrorType.unauthorized;
  bool get hasParseError => errorType == ErrorType.modelParseError;

  /// Legacy helper for compatibility or specific logic
  ErrorType get error => errorType;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is APIState &&
        other.status == status &&
        other.errorType == errorType &&
        other.hasData == hasData &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => Object.hash(status, errorType, hasData, errorMessage);

  @override
  String toString() =>
      'APIState(status: $status, error: $errorType, hasData: $hasData)';
}
