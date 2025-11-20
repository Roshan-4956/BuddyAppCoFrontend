import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/social_login_button.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../routing/app_router.dart';
import '../../../../utils/constants/assets.dart';

/// Login options screen with phone, email, and social login options
class LoginOptionsScreen extends ConsumerWidget {
  const LoginOptionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Header Section (Logo + Back Arrow)
          SizedBox(
            height: screenHeight * 0.15,
            width: double.infinity,
            child: Stack(
              children: [
                // Back Arrow
                Positioned(
                  top: screenHeight * 0.07,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: SvgPicture.asset(
                      Assets.iconBackArrow,
                      width: screenWidth * 0.06, // Responsive width
                      height: screenWidth * 0.06, // Responsive height
                    ),
                  ),
                ),

                // Buddy Logo
                Positioned(
                  top: screenHeight * 0.1,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Hero(
                      tag: 'buddy-logo',
                      child: SvgPicture.asset(
                        Assets.buddyIconWithText,
                        height: screenHeight * 0.05, // Responsive height
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Bottom Section (Card + Illustrations)
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              // Pink Card (Bottom Layer)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Hero(
                  tag: 'pink-card-container',
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryPink,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          24,
                          screenHeight * 0.08,
                          24,
                          screenHeight * 0.02,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Title
                              Text(
                                'Sign in',
                                style: AppTextStyles.headlineMedium.copyWith(
                                  color: AppColors.textPrimary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Continue with phone button
                              SizedBox(
                                width: double.infinity,
                                child: CustomButton(
                                  text: 'Continue with Phone',
                                  onPressed: () => context.goNamed(
                                    AppRouter.loginPhone.name,
                                  ),
                                  backgroundColor: AppColors.primaryDark,
                                  textColor: AppColors.primaryPink,
                                  height: screenHeight * 0.06,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Continue with email button
                              SizedBox(
                                width: double.infinity,
                                child: CustomButton(
                                  text: 'Continue with Email',
                                  onPressed: () => context.goNamed(
                                    AppRouter.loginEmail.name,
                                  ),
                                  isOutlined: false,
                                  backgroundColor: Colors.white,
                                  textColor: AppColors.textPrimary,
                                  height: screenHeight * 0.06,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Social login buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: SocialLoginButton(
                                      assetPath: Assets.loginApple,
                                      onPressed: () {
                                        // TODO: Implement Apple sign in
                                        context.go('/greenSplash');
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: SocialLoginButton(
                                      assetPath: Assets.loginGoogle,
                                      onPressed: () {
                                        // TODO: Implement Google sign in
                                        context.go('/greenSplash');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // Footer Text
                              GestureDetector(
                                onTap: () {
                                  // Navigate to login flow if different
                                },
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontFamily: 'Rethink Sans',
                                      fontSize: 12,
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: const [
                                      TextSpan(text: 'Already a user ? '),
                                      TextSpan(
                                        text: 'Log In',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
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
                ),
              ),

              // Illustrations (Top Layer)
              Positioned(
                top:
                    -(screenWidth *
                        0.55), // Position bottom of container at top of card
                left: 0,
                right: 0,
                height: screenWidth * 0.55,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Illustration 1 (Luggage - Left)
                    Positioned(
                      bottom: -50, // Align with top of card
                      left: 0,
                      child: IgnorePointer(
                        child: SvgPicture.asset(
                          Assets.loginIllustration1,
                          height: screenHeight * 0.35,
                          fit: BoxFit.contain,
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                    ),

                    // Illustration 2 (Character - Right)
                    Positioned(
                      bottom: -1, // Slight overlap to ensure no gap
                      right: 16,
                      child: SvgPicture.asset(
                        Assets.loginIllustration2,
                        height: screenHeight * 0.25,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomRight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Bottom spacing
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
