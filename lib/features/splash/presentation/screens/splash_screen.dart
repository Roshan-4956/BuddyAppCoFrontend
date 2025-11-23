import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../theme/app_colors.dart';

/// Splash screen shown during initial app load
/// Checks authentication status and automatically redirects
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Buddy Logo
            Image.asset(
              'assets/buddyLogoTitle.png',
              width: screenWidth * 0.5,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.people,
                size: 80,
                color: AppColors.primaryYellow,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            // Loading indicator
            const SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
            SizedBox(height: screenHeight * 0.02),
            // Loading text
            Text(
              'Loading...',
              style: TextStyle(
                fontFamily: 'Rethink Sans',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
