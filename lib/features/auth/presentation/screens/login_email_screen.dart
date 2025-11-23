import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../../../common/widgets/buddy_app_bar.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../../common/widgets/error_message.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../routing/app_router.dart';
import '../../application/providers/auth_providers.dart';
import '../state/auth_form_signals.dart';

/// Email login screen with email and password fields
class LoginEmailScreen extends ConsumerStatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  ConsumerState<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends ConsumerState<LoginEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    resetAuthForms();
    _emailController.addListener(() {
      emailSignal.value = _emailController.text;
    });
    _passwordController.addListener(() {
      passwordSignal.value = _passwordController.text;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (validateEmailForm()) {
      final response = await ref
          .read(authProvider.notifier)
          .loginWithEmail(emailSignal.value, passwordSignal.value);

      if (!mounted) return;

      if (response != null) {
        // Router will automatically redirect based on auth state
        if (response.onboardingRequired) {
          context.goNamed(AppRouter.onboardingFiller.name);
        } else {
          context.goNamed(AppRouter.home.name);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Watch signals
    final emailError = emailErrorSignal.watch(context);
    final passwordError = passwordErrorSignal.watch(context);

    final isLoading = authState.status == AuthStatus.loading;
    final showEmailError = isEmailDirty.watch(context) && emailError != null;
    final showPasswordError =
        isPasswordDirty.watch(context) && passwordError != null;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const BuddyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.04),
              Text(
                'Let\'s get started',
                style: AppTextStyles.displayLarge.copyWith(
                  color: colorScheme.onSurface,
                  fontSize: 28,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Enter your email address and password',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textTertiary,
                  height: 1.4,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              CustomTextField(
                controller: _emailController,
                label: 'Email Address',
                hintText: 'name@example.com',
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => isEmailDirty.value = true,
              ),

              if (showEmailError) ...[
                SizedBox(height: screenHeight * 0.007),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ErrorMessage(
                    message: emailError,
                    icon: Icon(
                      Icons.error_outline,
                      size: 16,
                      color: colorScheme.error,
                    ),
                  ),
                ),
              ],

              SizedBox(height: screenHeight * 0.03),

              CustomTextField(
                controller: _passwordController,
                label: 'Password',
                hintText: 'Enter your password',
                obscureText: true,
                keyboardType: TextInputType.text,
                onChanged: (value) => isPasswordDirty.value = true,
              ),

              if (showPasswordError) ...[
                SizedBox(height: screenHeight * 0.007),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ErrorMessage(
                    message: passwordError,
                    icon: Icon(
                      Icons.error_outline,
                      size: 16,
                      color: colorScheme.error,
                    ),
                  ),
                ),
              ],

              SizedBox(height: screenHeight * 0.045),

              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Login',
                  onPressed: isLoading ? () {} : _onSubmit,
                  isLoading: isLoading,
                  height: screenHeight * 0.06,
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              GestureDetector(
                onTap: () => context.goNamed(
                  AppRouter.authEmail.name,
                  queryParameters: {'type': 'signup'},
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: theme.brightness == Brightness.light
                          ? AppColors.textSecondary
                          : AppColors.textTertiary,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.025),
            ],
          ),
        ),
      ),
    );
  }
}
