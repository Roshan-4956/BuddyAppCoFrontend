import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/constants/assets.dart';
import '../../../../routing/app_router.dart';

/// Welcome screen - First screen shown to new users
/// Features the Buddy illustration, app description, and Get Started button
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool _acceptedTerms = false;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive layout
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Top spacing for logo
          SizedBox(height: screenHeight * 0.1),

          // Buddy logo
          Center(
            child: Hero(
              tag: 'buddy-logo',
              child: SvgPicture.asset(
                Assets.buddyIconWithText,
                height: screenHeight * 0.05, // Responsive height
                fit: BoxFit.contain,
              ),
            ),
          ),

          const Spacer(),

          // Illustration and Pink Card Stack
          SizedBox(
            height:
                (screenHeight * 0.35) +
                (screenHeight * 0.35) -
                20, // Card height + Illustration height - overlap
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                // Pink Card Container
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Hero(
                    tag: 'pink-card-container',
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        height: screenHeight * 0.35,
                        decoration: BoxDecoration(
                          color: AppColors.primaryPink,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: [
                            // Spacing for the illustration overlap
                            SizedBox(height: screenHeight * 0.1),
                            // Title - "Welcome to Buddy"
                            Text(
                              'Welcome to Buddy',
                              style: AppTextStyles.headlineMedium.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            // Description
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: SizedBox(
                                width: 240,
                                child: Text(
                                  'Find buddies, become a buddy, and belong to communities',
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                    height: 1.13,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            const Spacer(),

                            // Get Started button
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  if (_acceptedTerms) {
                                    context.pushNamed(
                                      AppRouter.loginOptions.name,
                                    );
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: _acceptedTerms
                                        ? AppColors.primaryDark
                                        : AppColors.buttonInactive,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Get started',
                                        style: AppTextStyles.buttonLarge
                                            .copyWith(
                                              color: AppColors.primaryPink,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.primaryPink,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Terms and conditions checkbox
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _acceptedTerms = !_acceptedTerms;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Checkbox
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: _acceptedTerms
                                            ? AppColors.textPrimary
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: AppColors.textTertiary,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: _acceptedTerms
                                          ? const Icon(
                                              Icons.check,
                                              size: 12,
                                              color: AppColors.white,
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 8),
                                    // Terms text
                                    Text(
                                      'You agree to the terms and conditions of our app',
                                      style: AppTextStyles.labelMedium.copyWith(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Main illustration - On top of the card
                Positioned(
                  bottom:
                      (screenHeight * 0.35) -
                      20, // Sit on top of card with 20px overlap
                  right: -16,
                  child: IgnorePointer(
                    child: SvgPicture.asset(
                      Assets.welcomeIllustrationBuddy,
                      fit: BoxFit.contain,
                      height: screenHeight * 0.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom spacing
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
