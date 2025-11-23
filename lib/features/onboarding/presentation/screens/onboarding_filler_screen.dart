import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../routing/app_router.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/logger.dart';
import '../../application/repositories/onboarding_progress_repo.dart';
import '../widgets/animated_star.dart';

class OnboardingFillerScreen extends ConsumerStatefulWidget {
  const OnboardingFillerScreen({super.key});

  @override
  ConsumerState<OnboardingFillerScreen> createState() =>
      _OnboardingFillerScreenState();
}

class _OnboardingFillerScreenState
    extends ConsumerState<OnboardingFillerScreen> {
  Timer? _timer;
  bool _hasNavigated = false;
  String _statusMessage = 'Initializing...';

  @override
  void initState() {
    super.initState();
    // Fetch onboarding progress and navigate after a short delay to ensure UI is stable
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _fetchProgressAndNavigate();
      }
    });
  }

  Future<void> _fetchProgressAndNavigate() async {
    setState(() {
      _statusMessage = 'Fetching progress...';
    });

    try {
      debugLog(
        DebugTags.auth,
        'OnboardingFiller: Starting progress fetch sequence',
      );

      // Fetch onboarding progress
      final repo = ref.read(onboardingProgressRepoProvider);

      debugLog(DebugTags.auth, 'OnboardingFiller: Executing repo request...');
      await repo.execute();
      debugLog(DebugTags.auth, 'OnboardingFiller: Repo request completed');

      if (!mounted || _hasNavigated) {
        debugLog(
          DebugTags.auth,
          'OnboardingFiller: Widget unmounted or already navigated',
        );
        return;
      }

      if (repo.state.isSuccess && repo.latestValidResult != null) {
        final progress = repo.latestValidResult!;
        debugLog(
          DebugTags.auth,
          'OnboardingFiller: Progress fetched: step ${progress.currentStep.stepNumber}',
        );

        // If onboarding is complete, redirect to home
        if (progress.isComplete) {
          debugLog(
            DebugTags.auth,
            'OnboardingFiller: Onboarding complete, redirecting to home',
          );
          _navigateToRoute(AppRouter.home.name);
          return;
        }

        // Navigate to the current step
        final stepNumber = progress.currentStep.stepNumber;
        _navigateToStep(stepNumber);
      } else if (repo.state.hasError) {
        // On error, default to step 1
        errorLog(
          DebugTags.auth,
          'OnboardingFiller: Failed to fetch progress. Error: ${repo.state.errorMessage}',
        );
        setState(() {
          _statusMessage =
              'Error: ${repo.state.errorMessage}. Defaulting to Step 1...';
        });
        // Add a small delay so user can see the error if needed, or just navigate
        await Future.delayed(const Duration(seconds: 2));
        _navigateToStep(1);
      } else {
        // No valid result, default to step 1
        debugLog(
          DebugTags.auth,
          'OnboardingFiller: No progress found (State: ${repo.state}), defaulting to step 1',
        );
        _navigateToStep(1);
      }
    } catch (e, stack) {
      errorLog(
        DebugTags.auth,
        'OnboardingFiller: Critical error fetching progress: $e',
      );
      debugLog(DebugTags.auth, stack);
      setState(() {
        _statusMessage = 'Critical Error. Defaulting to Step 1...';
      });
      await Future.delayed(const Duration(seconds: 2));
      // On exception, default to step 1
      if (mounted && !_hasNavigated) {
        _navigateToStep(1);
      }
    }
  }

  void _navigateToStep(int stepNumber) {
    // Map step number to route name
    final routeName = _getRouteNameForStep(stepNumber);
    _navigateToRoute(routeName);
  }

  String _getRouteNameForStep(int stepNumber) {
    switch (stepNumber) {
      case 1:
        return AppRouter.step1.name;
      case 2:
        return AppRouter.step2.name;
      case 3:
        return AppRouter.step3.name;
      case 4:
        return AppRouter.step4.name;
      case 5:
        return AppRouter.step5.name;
      default:
        debugLog(
          DebugTags.auth,
          'Unknown step number: $stepNumber, defaulting to step 1',
        );
        return AppRouter.step1.name;
    }
  }

  void _navigateToRoute(String routeName) {
    _timer?.cancel();
    if (mounted && !_hasNavigated) {
      _hasNavigated = true;
      debugLog(DebugTags.auth, 'Navigating to: $routeName');
      context.goNamed(routeName);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Colors from Figma
    const bgColor = Color(0xFFADDCFF);
    const starBlue = Color(0xFF64BDFF);
    const starPink = Color(0xFFFFB9FF);
    const starYellow = Color(0xFFF6D307);
    const starPurple = Color(0xFF8D8DFF);

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: bgColor,
        body: GestureDetector(
          onTap: () {
            // Prevent manual navigation while loading
          },
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              // --- Background Blobs ---
              // Positioning approximated from Figma relative layout

              // Large top-left blob (Blob 2/3 area)
              Positioned(
                top: -100,
                left: -150,
                child:
                    Container(
                          width: 542,
                          height: 542,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        )
                        .animate()
                        .scale(
                          duration: 4.seconds,
                          begin: const Offset(0.95, 0.95),
                          end: const Offset(1.05, 1.05),
                          curve: Curves.easeInOut,
                        )
                        .then()
                        .scale(
                          duration: 4.seconds,
                          begin: const Offset(1.05, 1.05),
                          end: const Offset(0.95, 0.95),
                          curve: Curves.easeInOut,
                        ),
              ),

              // Mid-left blob
              Positioned(
                top: 200,
                left: -80,
                child: Container(
                  width: 428,
                  height: 428,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
              ),

              // Lower blob
              Positioned(
                top: 340,
                left: 30,
                child: Container(
                  width: 326,
                  height: 326,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
              ),

              // --- Stars ---
              // Using AnimatedStar widget with Figma colors and approx positions

              // Top Right - Blue
              const AnimatedStar(
                size: 14,
                color: starBlue,
                top: 120,
                right: 40,
                rotation: 23,
                delay: Duration(milliseconds: 100),
              ),

              // Top Left - Blue
              const AnimatedStar(
                size: 14,
                color: starBlue,
                top: 180,
                left: 30,
                rotation: 23,
                delay: Duration(milliseconds: 200),
              ),

              // Middle Right - Pink
              const AnimatedStar(
                size: 24,
                color: starPink,
                top: 250,
                right: 80,
                rotation: -28, // 331 deg
                delay: Duration(milliseconds: 300),
              ),

              // Bottom Left - Yellow
              const AnimatedStar(
                size: 24,
                color: starYellow,
                bottom: 200,
                left: 60,
                rotation: -48, // 312 deg
                delay: Duration(milliseconds: 400),
              ),

              // Top Far Right - Yellow
              const AnimatedStar(
                size: 24,
                color: starYellow,
                top: 100,
                right: 20,
                rotation: -80, // 279 deg
                delay: Duration(milliseconds: 500),
              ),

              // Bottom Center - Blue
              const AnimatedStar(
                size: 24,
                color: starBlue,
                bottom: 150,
                right: 100,
                rotation: -80,
                delay: Duration(milliseconds: 600),
              ),

              // Bottom Right - Yellow (Large)
              const AnimatedStar(
                size: 42,
                color: starYellow,
                bottom: 80,
                right: 30,
                rotation: -88,
                delay: Duration(milliseconds: 0),
              ),

              // Top Center/Left - Pink
              const AnimatedStar(
                size: 28,
                color: starPink,
                top: 300,
                left: 100,
                rotation: -75,
                delay: Duration(milliseconds: 700),
              ),

              // Very Top Left - Pink
              const AnimatedStar(
                size: 28,
                color: starPink,
                top: 60,
                left: 20,
                rotation: -105,
                delay: Duration(milliseconds: 800),
              ),

              // Top Right Corner - Purple
              const AnimatedStar(
                size: 28,
                color: starPurple,
                top: 40,
                right: 10,
                rotation: -105,
                delay: Duration(milliseconds: 250),
              ),

              // Small Purple Stars (scattered)
              const AnimatedStar(
                size: 12,
                color: starPurple,
                bottom: 60,
                left: 40,
                rotation: -90,
                delay: Duration(milliseconds: 550),
              ),
              const AnimatedStar(
                size: 12,
                color: starPink,
                top: 50,
                right: 120,
                rotation: -90,
                delay: Duration(milliseconds: 150),
              ),

              // --- Central Text ---
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                          "Let's get started",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.displayLarge.copyWith(
                            fontFamily: 'Rethink Sans',
                            fontWeight: FontWeight.w800, // ExtraBold
                            fontSize: 32,
                            color: Colors.white,
                            height: 1.07,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                        .slideY(
                          begin: 0.3,
                          end: 0,
                          duration: 800.ms,
                          curve: Curves.easeOut,
                        ),
                    const SizedBox(height: 16),
                    // Debug Status Text
                    Text(
                      _statusMessage,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
