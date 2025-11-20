import 'api_state.dart';

/// Interface for objects that manage API state and data.
/// Provides convenient getters for UI consumption.
abstract class ApiStateHolder<T> {
  /// The current state of the API operation
  APIState get state;

  /// Allow setting state externally (e.g. for resetting)
  set state(APIState state);

  /// The current data/result, if available
  T? get data;

  // ===========================================================================
  // Convenience Getters
  // ===========================================================================

  /// Returns true if the operation is currently in progress (loading).
  bool get isLoading => state.isOngoing;

  /// Returns true if the operation completed successfully.
  bool get isSuccess => state.isSuccess;

  /// Returns true if the operation failed.
  bool get hasError => state.hasError;

  /// Returns true if there is a network/connectivity error.
  bool get isNetworkError => state.hasInternetError;

  /// Returns true if there is a server error (4xx, 5xx).
  bool get isServerError => state.hasServerError;

  /// Returns true if the operation failed due to 401 Unauthorized.
  bool get isUnauthorized => state.hasUnauthorizedError;

  /// Returns true if the operation is loading but we have data from a previous call
  /// (useful for "pull-to-refresh" or background update UI).
  bool get isRefreshing => isLoading && data != null;

  /// Returns true if the operation failed but we have data to show
  /// (useful for showing snackbar error while keeping list visible).
  bool get hasErrorWithData => hasError && data != null;

  /// Returns true if we have no data and are not loading (initial or empty error).
  bool get isEmpty => data == null && !isLoading;
}
