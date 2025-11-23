import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../routing/app_router.dart';
import '../../../../theme/app_text_styles.dart';
import '../widgets/animated_star.dart';

class OnboardingFillerScreen extends StatefulWidget {
  const OnboardingFillerScreen({super.key});

  @override
  State<OnboardingFillerScreen> createState() => _OnboardingFillerScreenState();
}

class _OnboardingFillerScreenState extends State<OnboardingFillerScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Auto-advance after 5 seconds
    _timer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        _navigateToNextScreen();
      }
    });
  }

  void _navigateToNextScreen() {
    _timer?.cancel();
    if (mounted) {
      context.goNamed(AppRouter.step1.name);
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
        onTap: _navigateToNextScreen,
        behavior: HitTestBehavior.opaque,
        child: Stack(
        children: [
          // --- Background Blobs ---
          // Positioning approximated from Figma relative layout

          // Large top-left blob (Blob 2/3 area)
          Positioned(
            top: -100,
            left: -150,
            child: Container(
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
            child:
                Text(
                      'Let’s get started',
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
          ),
        ],
      ),
        ),
      ),
    );
  }
}
