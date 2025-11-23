import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/application/providers/auth_providers.dart';
import 'app_router.dart';
import 'app_router_service.dart';
import 'config/config_repo.dart';

/// Notifier that listens to auth state changes and triggers router refreshes.
/// It also contains the central redirect logic to keep the router provider clean.
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    // Listen to auth provider changes and notify listeners (the router)
    _ref.listen<AuthState>(authProvider, (previous, next) {
      notifyListeners();
    });
  }

  /// Central redirect logic
  String? redirect(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authProvider);
    final path = state.uri.path;

    final isAuthenticated = authState.status == AuthStatus.authenticated;
    final isLoading =
        authState.status == AuthStatus.initial ||
        authState.status == AuthStatus.loading;
    final needsOnboarding = authState.onboardingRequired ?? false;

    final isSplashPath = path == '/splash';
    final isWelcomePath = path == '/welcome';
    final isAuthPath = path.startsWith('/auth');
    final isOnboardingPath = path.startsWith('/onboarding');

    // --- 0. Loading / Initial State ---
    // Show splash screen while checking auth status
    if (isLoading) {
      // If not already on splash, redirect to splash
      if (!isSplashPath) return '/splash';
      // If on splash, stay there
      return null;
    }

    // --- 1. Auth Check Complete - Redirect from Splash ---
    if (isSplashPath) {
      // Auth check is done, redirect based on status
      if (isAuthenticated) {
        // Authenticated - check onboarding status
        return needsOnboarding ? '/onboarding' : '/home';
      } else {
        // Not authenticated - go to welcome
        return '/welcome';
      }
    }

    // --- 2. Unauthenticated Flow ---
    if (!isAuthenticated) {
      // Allowed paths for unauthenticated users
      if (isWelcomePath || isAuthPath) return null;

      // Redirect everything else to Welcome
      return '/welcome';
    }

    // --- 3. Authenticated Flow ---
    if (isAuthenticated) {
      // 3a. Needs Onboarding
      if (needsOnboarding) {
        // If already inside the onboarding flow, allow it.
        if (isOnboardingPath) return null;

        // Otherwise, force start at onboarding filler
        return '/onboarding';
      }

      // 3b. Onboarding Complete
      // Lock out of auth/welcome/onboarding pages
      if (isWelcomePath || isAuthPath || isOnboardingPath) {
        return '/home';
      }
    }

    // --- 3. Feature Flags / Remote Config ---
    // Accessing other providers via ref is safe here
    if (_ref.read(configRepoProvider).currentResult != null) {
      String redirectLocation = _ref
          .read(appRouterServiceProvider)
          .locationCheck(
            locationsToCheck: [
              LocationLockedModel(
                pathName: AppRouter.someScreen.name,
                isLocked:
                    _ref.read(configRepoProvider).currentResult!.data ?? false,
              ),
            ],
            location: path,
          );

      if (redirectLocation.isNotEmpty && redirectLocation != '/') {
        return redirectLocation;
      }
    }

    return null;
  }
}

/// Provider for the RouterNotifier
final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});
