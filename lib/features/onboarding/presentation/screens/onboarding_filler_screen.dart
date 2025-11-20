import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../utils/constants/assets.dart';

/// Filler screen shown before onboarding flow begins
/// Displays "Let's get started" with decorative elements
class OnboardingFillerScreen extends StatefulWidget {
  const OnboardingFillerScreen({super.key});

  @override
  State<OnboardingFillerScreen> createState() => _OnboardingFillerScreenState();
}

class _OnboardingFillerScreenState extends State<OnboardingFillerScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-advance to first onboarding step after 2 seconds
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        // TODO: Navigate to first onboarding step
        // context.go('/onboarding/profile');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFADDCFF), // Light blue background
      body: GestureDetector(
        onTap: () {
          // Allow tap to skip waiting
          // TODO: Navigate to first onboarding step
          // context.go('/onboarding/profile');
        },
        child: Stack(
          children: [
            // Circle outlines (background decorations)
            Positioned(
              left: 32.23,
              top: 342,
              width: 326,
              height: 326,
              child: SvgPicture.asset(
                Assets.onboardingCircleOutline1,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: -78.25,
              top: 231.22,
              width: 428,
              height: 428,
              child: Transform.rotate(
                angle: 19.678 * 3.14159 / 180, // Convert to radians
                child: SvgPicture.asset(
                  Assets.onboardingCircleOutline2,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              left: -162,
              top: 146,
              width: 542,
              height: 542,
              child: Transform.rotate(
                angle: 24.008 * 3.14159 / 180,
                child: SvgPicture.asset(
                  Assets.onboardingCircleOutline3,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Decorative stars scattered around
            _buildStar(
              top: size.height * 0.5367,
              right: size.width * 0.0828,
              asset: Assets.onboardingStarBlueSmall,
              rotation: 23.888,
            ),
            _buildStar(
              top: size.height * 0.501,
              left: size.width * 0.0585,
              asset: Assets.onboardingStarBlueSmall,
              rotation: 23.888,
            ),
            _buildStar(
              top: size.height * 0.6804,
              left: size.width * 0.6656,
              asset: Assets.onboardingStarPink1,
              rotation: 331.776,
            ),
            _buildStar(
              top: size.height * 0.8306,
              right: size.width * 0.0823,
              asset: Assets.onboardingStarYellow1,
              rotation: 279.665,
            ),
            _buildStar(
              top: size.height * 0.222,
              left: size.width * 0.628,
              asset: Assets.onboardingStarYellow2,
              rotation: 312.574,
            ),
            _buildStar(
              top: size.height * 0.1409,
              left: size.width * 0.0712,
              asset: Assets.onboardingStarBlue1,
              rotation: 279.665,
            ),
            _buildStar(
              top: size.height * 0.6998,
              right: size.width * 0.0519,
              asset: Assets.onboardingStarYellow3,
              rotation: 271.246,
              size: 42.862,
            ),
            _buildStar(
              top: size.height * 0.2996,
              left: size.width * 0.1756,
              asset: Assets.onboardingStarPink2,
              rotation: 285,
              size: 28.904,
            ),
            _buildStar(
              top: size.height * 0.0793,
              left: size.width * 0.8039,
              asset: Assets.onboardingStarPink3,
              rotation: 255,
              size: 28.904,
            ),
            _buildStar(
              top: size.height * 0.9365,
              left: size.width * 0.1221,
              asset: Assets.onboardingStarPurple1,
              rotation: 255,
              size: 28.904,
            ),
            _buildStar(
              top: size.height * 0.1081,
              right: size.width * 0.083,
              asset: Assets.onboardingStarBlue2,
              rotation: 270.103,
              size: 11.624,
            ),
            _buildStar(
              top: size.height * 0.9654,
              left: size.width * 0.2012,
              asset: Assets.onboardingStarPink4,
              rotation: 270.103,
              size: 11.624,
            ),
            _buildStar(
              top: size.height * 0.3343,
              right: size.width * 0.1256,
              asset: Assets.onboardingStarBlue2,
              rotation: 270.103,
              size: 11.624,
            ),

            // Center text
            Center(
              child: Text(
                'Let\'s get\nstarted',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Rethink Sans',
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.07,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStar({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required String asset,
    required double rotation,
    double size = 14,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Transform.rotate(
        angle: rotation * 3.14159 / 180, // Convert degrees to radians
        child: SvgPicture.asset(asset, width: size, height: size),
      ),
    );
  }
}
