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
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            // Buddy Logo
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Center(
                child: SvgPicture.asset(
                  Assets.buddyIconWithText,
                  height: 40, // Adjust based on actual asset size
                ),
              ),
            ),

            // Back Arrow
            Positioned(
              top: 60,
              left: 20,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: SvgPicture.asset(
                  Assets.iconBackArrow,
                  width: 24,
                  height: 24,
                ),
              ),
            ),

            // Login options container with Illustrations
            Positioned(
              bottom: 30,
              left: 16,
              right: 16,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  // Pink Card with Hero animation
                  Hero(
                    tag: 'pink-card-container',
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        // Fixed height removed to prevent overflow on smaller screens or larger fonts
                        // height: 325, 
                        decoration: BoxDecoration(
                          color: AppColors.primaryPink,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            24,
                            70,
                            24,
                            20,
                          ), // Top padding for overlap, reduced for content fit
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
                                  height: 55,
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
                                  height: 55,
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

                  // Illustration 1 (Luggage - Left)
                  Positioned(
                    top: -280,
                    left: -40, // Adjust to peek out from left
                    child: SvgPicture.asset(
                      Assets.loginIllustration1,
                      height: 370, // Approximate height from aspect ratio
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Illustration 2 (Character - Right)
                  // Character sits on top of the pink box with bottom touching the card top
                  Positioned(
                    top:
                        0, // Adjusted for reduced top padding (205 - 14 = 191)
                    right: 10, // Slightly offset to the right
                    child: SvgPicture.asset(
                      Assets.loginIllustration2,
                      // Use intrinsic size (212x205)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
