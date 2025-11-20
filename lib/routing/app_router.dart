import 'package:buddy_app/features/auth/application/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:buddy_app/features/example/presentation/api_call_1_screen.dart';
import 'package:buddy_app/features/auth/presentation/screens/welcome_screen.dart';
import 'package:buddy_app/features/auth/presentation/screens/login_options_screen.dart';
import 'package:buddy_app/features/auth/presentation/screens/login_email_screen.dart';
import 'package:buddy_app/features/auth/presentation/screens/login_phone_screen.dart';
import 'package:buddy_app/features/auth/presentation/screens/register_screen.dart';
import 'package:buddy_app/features/home/presentation/screens/home_screen.dart';
import 'package:buddy_app/features/onboarding/presentation/screens/onboarding_filler_screen.dart';
import 'package:buddy_app/features/onboarding/presentation/screens/onboarding_step1_screen.dart';
import 'package:buddy_app/features/onboarding/presentation/screens/onboarding_step2_screen.dart';
import 'package:buddy_app/features/onboarding/presentation/screens/onboarding_step3_screen.dart';
import 'package:buddy_app/features/onboarding/presentation/screens/onboarding_step4_screen.dart';
import 'package:buddy_app/utils/widgets/not_found_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_router_service.dart';
import 'config/config_repo.dart';

part 'app_router.g.dart';

enum AppRouter {
  someScreen,
  someScreen1,
  noNetPage,
  apiCall1Screen,
  welcome,
  loginOptions,
  loginEmail,
  loginPhone,
  register,
  home,
  onboarding,
  onboardingFiller,
  onboardingStep1,
  onboardingStep2,
  onboardingStep3,
  onboardingStep4,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  // Watch auth state for changes
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/${AppRouter.welcome.name}',
    // Add refresh listner for auth state changes
    refreshListenable: ValueNotifier(authState),
    redirect: (context, state) {
      // Using state.uri.path instead of state.location (go_router 10.0.0+)
      final currentLocation = state.uri.path;
      final isAuthRoute =
          currentLocation.contains('login') ||
          currentLocation.contains('register') ||
          currentLocation.contains('welcome');

      final isAuthenticated = authState.status == AuthStatus.authenticated;

      // Redirect to welcome if not authenticated and trying to access protected route
      if (!isAuthenticated && !isAuthRoute) {
        return '/${AppRouter.welcome.name}';
      }

      // Redirect to home if authenticated and trying to access auth routes
      if (isAuthenticated && isAuthRoute) {
        return '/${AppRouter.home.name}';
      }

      // Custom config based redirect logic
      if (ref.read(configRepoProvider).currentResult != null) {
        String redirectLocation = ref
            .read(appRouterServiceProvider)
            .locationCheck(
              locationsToCheck: [
                LocationLockedModel(
                  pathName: AppRouter.someScreen.name,
                  isLocked:
                      ref.read(configRepoProvider).currentResult!.data ?? false,
                ),
                LocationLockedModel(
                  pathName: AppRouter.someScreen.name,
                  isLocked:
                      ref.read(configRepoProvider).currentResult!.data ?? false,
                ),
                LocationLockedModel(
                  pathName: AppRouter.someScreen.name,
                  isLocked:
                      ref.read(configRepoProvider).currentResult!.data ?? false,
                ),
                LocationLockedModel(
                  pathName: AppRouter.someScreen.name,
                  isLocked:
                      ref.read(configRepoProvider).currentResult!.data ?? false,
                ),
                LocationLockedModel(
                  pathName: AppRouter.someScreen.name,
                  isLocked:
                      ref.read(configRepoProvider).currentResult!.data ?? false,
                ),
              ],
              location: currentLocation,
            );

        if (redirectLocation == '/' || redirectLocation == '') {
          // Don't return default if we are already somewhere valid
          return null;
          // return '/${AppRouter.someScreen.name}';
        }
        return redirectLocation;
      }
      return null;
    },
    debugLogDiagnostics: false,
    routes: [
      // Auth routes
      GoRoute(
        path: '/${AppRouter.welcome.name}',
        name: AppRouter.welcome.name,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const WelcomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: '/${AppRouter.loginOptions.name}',
        name: AppRouter.loginOptions.name,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const LoginOptionsScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: '/${AppRouter.loginEmail.name}',
        name: AppRouter.loginEmail.name,
        builder: (context, state) {
          return const LoginEmailScreen();
        },
      ),
      GoRoute(
        path: '/${AppRouter.loginPhone.name}',
        name: AppRouter.loginPhone.name,
        builder: (context, state) {
          return const LoginPhoneScreen();
        },
      ),
      GoRoute(
        path: '/${AppRouter.register.name}',
        name: AppRouter.register.name,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: '/${AppRouter.home.name}',
        name: AppRouter.home.name,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      // Home redirect for /home path
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      // Onboarding routes
      GoRoute(
        path: '/onboarding',
        name: AppRouter.onboarding.name,
        builder: (context, state) {
          return const OnboardingFillerScreen();
        },
        routes: [
          GoRoute(
            path: 'filler',
            name: AppRouter.onboardingFiller.name,
            builder: (context, state) {
              return const OnboardingFillerScreen();
            },
          ),
          GoRoute(
            path: 'step1',
            name: AppRouter.onboardingStep1.name,
            builder: (context, state) {
              return const OnboardingStep1Screen();
            },
          ),
          GoRoute(
            path: 'step2',
            name: AppRouter.onboardingStep2.name,
            builder: (context, state) {
              return const OnboardingStep2Screen();
            },
          ),
          GoRoute(
            path: 'step3',
            name: AppRouter.onboardingStep3.name,
            builder: (context, state) {
              return const OnboardingStep3Screen();
            },
          ),
          GoRoute(
            path: 'step4',
            name: AppRouter.onboardingStep4.name,
            builder: (context, state) {
              return const OnboardingStep4Screen();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/${AppRouter.noNetPage.name}',
        name: AppRouter.noNetPage.name,
        builder: (context, state) {
          return const NotFoundScreen();
        },
      ),
      GoRoute(
        path: '/${AppRouter.someScreen.name}',
        name: AppRouter.someScreen.name,
        builder: (context, state) {
          return const ApiCall1Screen();
        },
        routes: [
          GoRoute(
            path: AppRouter.someScreen1.name,
            name: AppRouter.someScreen1.name,
            builder: (context, state) {
              return const ApiCall1Screen();
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return const NotFoundScreen();
    },
  );
}
