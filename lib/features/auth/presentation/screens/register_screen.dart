import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../../common/widgets/error_message.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/constants/assets.dart';
import '../../../../routing/app_router.dart';
import '../../application/providers/auth_providers.dart';
import '../state/auth_form_signals.dart';

/// Account creation / Register screen with email and password
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
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
          .registerWithEmail(emailSignal.value, passwordSignal.value);

      if (!mounted) return;

      if (response != null) {
        if (response.onboardingRequired) {
          context.goNamed(AppRouter.onboardingStep1.name);
        } else {
          context.goNamed(AppRouter.home.name);
        }
      }
      // Errors handled via global state/toasts
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authProvider);
    final isLoading = authState.status == AuthStatus.loading;

    // Watch signals
    final emailError = emailErrorSignal.watch(context);
    final passwordError = passwordErrorSignal.watch(context);
    final showEmailError = isEmailDirty.watch(context) && emailError != null;
    final showPasswordError =
        isPasswordDirty.watch(context) && passwordError != null;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              Assets.iconBackArrow,
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(
                AppColors.textNeutral60,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        title: SvgPicture.asset(
          Assets.buddyIconWithText,
          height: 40,
          colorFilter: ColorFilter.mode(
            theme.brightness == Brightness.light
                ? AppColors.textPrimary
                : AppColors.textOnDark,
            BlendMode.srcIn,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              Text(
                'Create Account',
                style: AppTextStyles.displayLarge.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontSize: 28,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              Text(
                'Set up your account to get started',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textTertiary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),

              CustomTextField(
                controller: _emailController,
                label: 'Email Address',
                hintText: 'name@example.com',
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => isEmailDirty.value = true,
              ),

              if (showEmailError) ...[
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ErrorMessage(
                    message: emailError,
                    icon: Icon(
                      Icons.error_outline,
                      size: 16,
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              CustomTextField(
                controller: _passwordController,
                label: 'Password',
                hintText: 'Enter your password',
                obscureText: true,
                keyboardType: TextInputType.text,
                onChanged: (value) => isPasswordDirty.value = true,
              ),

              if (showPasswordError) ...[
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ErrorMessage(
                    message: passwordError,
                    icon: Icon(
                      Icons.error_outline,
                      size: 16,
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 36),

              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Create Account',
                  onPressed: isLoading ? () {} : _onSubmit,
                  isLoading: isLoading,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
