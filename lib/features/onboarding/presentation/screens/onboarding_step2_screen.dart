import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/api/core/api_state.dart';
import '../../../../utils/constants/assets.dart';
import '../../application/repositories/static_repo.dart';
import '../../application/repositories/submit_step_repo.dart';

/// Onboarding Step 2: Professional Information
/// Collects: Occupation and Gender
class OnboardingStep2Screen extends ConsumerStatefulWidget {
  const OnboardingStep2Screen({super.key});

  @override
  ConsumerState<OnboardingStep2Screen> createState() =>
      _OnboardingStep2ScreenState();
}

class _OnboardingStep2ScreenState extends ConsumerState<OnboardingStep2Screen> {
  int? _selectedOccupationId;
  int? _selectedGenderId;
  bool _isLoading = false;

  void _handleNext() async {
    if (_selectedOccupationId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select an occupation')));
      return;
    }

    if (_selectedGenderId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select a gender')));
      return;
    }

    setState(() => _isLoading = true);

    final repo = ref.read(submitStepRepoProvider);
    repo.requestParams.setStepData(2, {
      'occupation_id': _selectedOccupationId,
      'gender_id': _selectedGenderId,
    });

    await repo.execute();

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (repo.state == APIState.success) {
      // Navigate to next step
      context.go('/onboarding/step3');
    } else if (repo.state.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            repo.state.hasInternetError
                ? 'Network error. Please check your connection.'
                : 'Failed to submit. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final occupationsRepo = ref.watch(occupationsRepoProvider);
    final gendersRepo = ref.watch(gendersRepoProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          // Background light blue filled circle
          Positioned(
            top: -200,
            right: -150,
            child: SvgPicture.asset(
              Assets.onboardingStep2BackgroundCircleBlue,
              width: 700,
              height: 700,
              fit: BoxFit.contain,
            ),
          ),
          // Main content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Back button
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SvgPicture.asset(
                        Assets.onboardingBackArrow,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  // Title
                  Text(
                    'Tell us more',
                    style: AppTextStyles.displayMedium.copyWith(
                      color: AppColors.primaryDark,
                      fontSize: 28,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  Text(
                    'Help us personalize your experience',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textTertiary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Progress indicators
                  Row(
                    children: [
                      _buildProgressBar(true),
                      const SizedBox(width: 8),
                      _buildProgressBar(true),
                      const SizedBox(width: 8),
                      _buildProgressBar(false),
                      const SizedBox(width: 8),
                      _buildProgressBar(false),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Form container
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x0F000000),
                          blurRadius: 12,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section title
                        Text(
                          'What\'s your occupation?',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.primaryDark,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Occupations
                        occupationsRepo.latestValidResult != null
                            ? _buildOccupationsList(
                                occupationsRepo.latestValidResult!.occupations,
                              )
                            : const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: CircularProgressIndicator(),
                              ),
                        const SizedBox(height: 28),
                        // Divider
                        Container(
                          height: 1,
                          color: AppColors.textTertiary.withValues(alpha: 0.1),
                        ),
                        const SizedBox(height: 28),
                        // Gender section title
                        Text(
                          'What\'s your gender?',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.primaryDark,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Genders
                        gendersRepo.latestValidResult != null
                            ? _buildGendersList(
                                gendersRepo.latestValidResult!.genders,
                              )
                            : const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: CircularProgressIndicator(),
                              ),
                        const SizedBox(height: 28),
                        // Next button
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: 'Next',
                            onPressed: _handleNext,
                            isLoading: _isLoading,
                            backgroundColor: AppColors.primaryDark,
                            textColor: AppColors.primaryPink,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(bool isActive) {
    return Expanded(
      child: Container(
        height: 4,
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF505050) : Color(0x73505050),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildOccupationsList(List occupations) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: occupations.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final occupation = occupations[index];
        final isSelected = _selectedOccupationId == occupation.occupationId;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedOccupationId = occupation.occupationId;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF64BDFF).withValues(alpha: 0.4)
                  : const Color(0xFF64BDFF).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(24),
              border: isSelected
                  ? Border.all(color: AppColors.primaryBlue, width: 2)
                  : null,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Radio button
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryBlue
                          : AppColors.textTertiary,
                      width: 2,
                    ),
                    color: isSelected ? AppColors.primaryBlue : Colors.white,
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 12),
                // Label
                Expanded(
                  child: Text(
                    occupation.name,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGendersList(List genders) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: genders.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final gender = genders[index];
        final isSelected = _selectedGenderId == gender.genderId;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedGenderId = gender.genderId;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFF6DDE1).withValues(alpha: 0.5)
                  : const Color(0xFFF6DDE1).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(24),
              border: isSelected
                  ? Border.all(color: AppColors.primaryPink, width: 2)
                  : null,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Radio button
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryPink
                          : AppColors.textTertiary,
                      width: 2,
                    ),
                    color: isSelected ? AppColors.primaryPink : Colors.white,
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 12),
                // Label
                Expanded(
                  child: Text(
                    gender.name,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
