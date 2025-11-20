import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../utils/logger.dart';
import '../models/auth_models.dart';
import '../repositories/auth_repos.dart';
import '../services/token_storage_service.dart';

part 'auth_providers.g.dart';

// ==============================================================================
// Auth State & Notifier
// ==============================================================================

/// Auth state enum
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

/// Auth state class
class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final String? userId;
  final bool? onboardingRequired;

  const AuthState({
    required this.status,
    this.errorMessage,
    this.userId,
    this.onboardingRequired,
  });

  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);
  factory AuthState.loading() => const AuthState(status: AuthStatus.loading);
  factory AuthState.authenticated(
    String userId, {
    bool onboardingRequired = false,
  }) => AuthState(
    status: AuthStatus.authenticated,
    userId: userId,
    onboardingRequired: onboardingRequired,
  );
  factory AuthState.unauthenticated() =>
      const AuthState(status: AuthStatus.unauthenticated);
  factory AuthState.error(String message) =>
      AuthState(status: AuthStatus.error, errorMessage: message);
}

/// Auth state notifier - Manages the global authentication state
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() => AuthState.initial();

  /// Check authentication status on startup
  Future<void> checkAuthStatus() async {
    debugLog(DebugTags.auth, 'Checking auth status...');
    state = AuthState.loading();

    try {
      final tokenService = ref.read(tokenStorageServiceProvider);
      final isAuthenticated = await tokenService.isAuthenticated();

      if (!isAuthenticated) {
        debugLog(
          DebugTags.auth,
          'No valid token found. User is unauthenticated.',
        );
        state = AuthState.unauthenticated();
        return;
      }

      debugLog(DebugTags.auth, 'Token found. Verifying with server...');

      // Token exists, verify with server by getting current user
      final repo = ref.read(currentUserRepoProvider);
      await repo.execute();

      if (repo.state.isSuccess) {
        final user = repo.latestValidResult;
        if (user != null) {
          debugLog(DebugTags.auth, 'User verified: ${user.userId}');
          final userId = await tokenService.getUserId();
          state = AuthState.authenticated(
            userId ?? user.userId,
            onboardingRequired: !user.isOnboardingComplete,
          );
          return;
        }
      } else if (repo.state.hasError) {
        // If API call fails, check if it's a network issue or an auth issue (401)
        if (repo.state.hasInternetError) {
          debugLog(DebugTags.auth, 'Network error during auth check.');
          state = AuthState.error('Network connection error. Retrying...');
          return;
        } else if (repo.isUnauthorized) {
          debugLog(DebugTags.auth, 'Session expired (401). Clearing tokens.');
          await tokenService.clearTokens();
          state = AuthState.unauthenticated();
          return;
        } else {
          debugLog(
            DebugTags.auth,
            'Auth verification failed with server error. Retaining tokens.',
          );
          // Do not clear tokens on 500s or other errors, allow retry
          state = AuthState.error(
            'Server error. Please check connection or try again.',
          );
          return;
        }
      }

      debugLog(
        DebugTags.auth,
        'Auth verification failed (Unknown state). Clearing tokens.',
      );
      await tokenService.clearTokens();
      state = AuthState.unauthenticated();
    } catch (e, stack) {
      errorLog(DebugTags.auth, 'Auth check exception: $e');
      debugLog(DebugTags.auth, stack);

      if (e.toString().toLowerCase().contains('network') ||
          e.toString().toLowerCase().contains('connection')) {
        state = AuthState.error('Network error. Please check connection.');
      } else {
        await ref.read(tokenStorageServiceProvider).clearTokens();
        state = AuthState.unauthenticated();
      }
    }
  }

  /// Register with email and password
  Future<AuthResponseModel?> registerWithEmail(
    String email,
    String password,
  ) async {
    debugLog(DebugTags.auth, 'Attempting registration for: $email');
    state = AuthState.loading();
    try {
      final repo = ref.read(registerRepoProvider);
      repo.requestParams.setCredentials(email, password);
      await repo.execute();

      if (repo.state.isSuccess) {
        final response = repo.latestValidResult;
        if (response != null) {
          debugLog(
            DebugTags.auth,
            'Registration successful. User ID: ${response.userId}',
          );
          await ref
              .read(tokenStorageServiceProvider)
              .storeTokens(
                accessToken: response.accessToken,
                refreshToken: response.refreshToken,
                userId: response.userId,
              );
          state = AuthState.authenticated(
            response.userId,
            onboardingRequired: response.onboardingRequired,
          );
          return response;
        }
      } else if (repo.state.hasError) {
        final errorMessage = repo.state.hasInternetError
            ? 'Network error. Please check your connection.'
            : 'Registration failed. Please try again.';
        errorLog(DebugTags.auth, 'Registration failed: $errorMessage');
        state = AuthState.error(errorMessage);
        return null;
      }
    } catch (e, stack) {
      errorLog(DebugTags.auth, 'Registration exception: $e');
      debugLog(DebugTags.auth, stack);
      state = AuthState.error(e.toString());
      return null;
    }
    return null;
  }

  /// Login with email and password
  Future<AuthResponseModel?> loginWithEmail(
    String email,
    String password,
  ) async {
    debugLog(DebugTags.auth, 'Attempting login for: $email');
    state = AuthState.loading();
    try {
      final repo = ref.read(loginRepoProvider);
      repo.requestParams.setEmailLogin(email, password);
      await repo.execute();

      if (repo.state.isSuccess) {
        final response = repo.latestValidResult;
        if (response != null) {
          debugLog(
            DebugTags.auth,
            'Login successful. User ID: ${response.userId}',
          );
          await ref
              .read(tokenStorageServiceProvider)
              .storeTokens(
                accessToken: response.accessToken,
                refreshToken: response.refreshToken,
                userId: response.userId,
              );
          state = AuthState.authenticated(
            response.userId,
            onboardingRequired: response.onboardingRequired,
          );
          return response;
        }
      } else if (repo.state.hasError) {
        final errorMessage = repo.state.hasInternetError
            ? 'Network error. Please check your connection.'
            : 'Login failed. Please check your credentials.';
        errorLog(DebugTags.auth, 'Login failed: $errorMessage');
        state = AuthState.error(errorMessage);
        return null;
      }
    } catch (e, stack) {
      errorLog(DebugTags.auth, 'Login exception: $e');
      debugLog(DebugTags.auth, stack);
      state = AuthState.error(e.toString());
      return null;
    }
    return null;
  }

  /// Sign out
  Future<void> signOut() async {
    debugLog(DebugTags.auth, 'Signing out...');
    try {
      await ref.read(tokenStorageServiceProvider).clearTokens();
      state = AuthState.unauthenticated();
      debugLog(DebugTags.auth, 'Sign out successful.');
    } catch (e, stack) {
      errorLog(DebugTags.auth, 'Sign out error: $e');
      debugLog(DebugTags.auth, stack);
      state = AuthState.error(e.toString());
    }
  }

  /// Reset state
  void reset() {
    debugLog(DebugTags.auth, 'Resetting auth state.');
    state = AuthState.initial();
  }
}

// ==============================================================================
// Auth Middleware / Startup Check
// ==============================================================================

/// Provider that checks authentication state on app startup
@Riverpod(keepAlive: true)
Future<bool> authCheck(Ref ref) async {
  debugLog(DebugTags.authMiddleware, 'Starting auth check...');
  await ref.read(authProvider.notifier).checkAuthStatus();
  final authState = ref.read(authProvider);
  debugLog(
    DebugTags.authMiddleware,
    'Auth check completed. Status: ${authState.status}',
  );
  return authState.status == AuthStatus.authenticated;
}
