import 'package:flutter/material.dart';
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
import 'package:buddy_app/features/onboarding/presentation/screens/onboarding_step5_screen.dart';
import 'package:buddy_app/features/onboarding/presentation/screens/gender_preference_screen.dart';
import 'package:buddy_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:buddy_app/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:buddy_app/features/chat/presentation/screens/chat_thread_screen.dart';
import 'package:buddy_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:buddy_app/utils/widgets/not_found_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:buddy_app/utils/logging/go_router_observer.dart';
import 'package:buddy_app/features/example/presentation/api_call_1_screen.dart';
import 'router_notifier.dart';

part 'app_router.g.dart';

enum AppRouter {
  splash,
  welcome,
  auth,
  authOptions,
  authEmail,
  authPhone,
  home,
  chatList,
  chatThread,
  onboardingFiller,
  step1,
  step2,
  step3,
  step4,
  step5,
  genderPreference,
  profile,
  noNetPage,
  someScreen,
  someScreen1,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final routerNotifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    observers: [GoRouterObserver()],
    debugLogDiagnostics: true,
    refreshListenable: routerNotifier,
    redirect: routerNotifier.redirect,
    routes: [
      // --- Splash ---
      GoRoute(
        path: '/splash',
        name: AppRouter.splash.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SplashScreen()),
      ),

      // --- Welcome ---
      GoRoute(
        path: '/welcome',
        name: AppRouter.welcome.name,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const WelcomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // --- Auth ---
      GoRoute(
        path: '/auth',
        name: AppRouter.auth.name,
        redirect: (context, state) {
          if (state.uri.path == '/auth') {
            return '/auth/options';
          }
          return null;
        },
        routes: [
          GoRoute(
            path: 'options',
            name: AppRouter.authOptions.name,
            pageBuilder: (context, state) => CustomTransitionPage(
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
            ),
            routes: [
              GoRoute(
                path: 'email',
                name: AppRouter.authEmail.name,
                pageBuilder: (context, state) {
                  final type = state.uri.queryParameters['type'];
                  final child = type == 'signup'
                      ? const RegisterScreen()
                      : const LoginEmailScreen();
                  return CustomTransitionPage(
                    child: child,
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
                path: 'phone',
                name: AppRouter.authPhone.name,
                pageBuilder: (context, state) => CustomTransitionPage(
                  child: const LoginPhoneScreen(),
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
                ),
              ),
            ],
          ),
        ],
      ),

      // --- Onboarding ---
      GoRoute(
        path: '/onboarding',
        name: AppRouter.onboardingFiller.name,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const OnboardingFillerScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // Redirect /onBoarding (legacy) to step 1
      GoRoute(
        path: '/onBoarding',
        redirect: (context, state) => '/onboarding/step1',
      ),

      // Explicit Steps
      GoRoute(
        path: '/onboarding/step1',
        name: AppRouter.step1.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: OnboardingStep1Screen()),
      ),
      GoRoute(
        path: '/onboarding/step2',
        name: AppRouter.step2.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: OnboardingStep2Screen()),
      ),
      GoRoute(
        path: '/onboarding/step3',
        name: AppRouter.step3.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: OnboardingStep3Screen()),
      ),
      GoRoute(
        path: '/onboarding/step4',
        name: AppRouter.step4.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: OnboardingStep4Screen()),
      ),
      GoRoute(
        path: '/onboarding/step5',
        name: AppRouter.step5.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: OnboardingStep5Screen()),
      ),

      // --- Profile ---
      GoRoute(
        path: '/profile',
        name: AppRouter.profile.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: ProfileScreen()),
      ),

      // Gender Preference (Step 5 / Extra)
      GoRoute(
        path: '/genderPreference',
        name: AppRouter.genderPreference.name,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const GenderPreferenceScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // --- Home ---
      GoRoute(
        path: '/home',
        name: AppRouter.home.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: HomeScreen()),
      ),

      // --- Chats ---
      GoRoute(
        path: '/chats',
        name: AppRouter.chatList.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: ChatListScreen()),
      ),
      GoRoute(
        path: '/chats/:chatId',
        name: AppRouter.chatThread.name,
        pageBuilder: (context, state) {
          final chatId = state.pathParameters['chatId'] ?? '';
          return NoTransitionPage(child: ChatThreadScreen(chatId: chatId));
        },
      ),

      // --- Other / Examples ---
      GoRoute(
        path: '/someScreen',
        name: AppRouter.someScreen.name,
        builder: (context, state) => const ApiCall1Screen(),
        routes: [
          GoRoute(
            path: 'someScreen1',
            name: AppRouter.someScreen1.name,
            builder: (context, state) => const ApiCall1Screen(),
          ),
        ],
      ),
      GoRoute(
        path: '/noNetPage',
        name: AppRouter.noNetPage.name,
        builder: (context, state) => const NotFoundScreen(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
