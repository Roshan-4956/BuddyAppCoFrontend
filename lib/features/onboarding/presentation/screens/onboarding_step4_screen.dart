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

/// Onboarding Step 4: Interests Selection
/// Collects: 3-10 interest selections
class OnboardingStep4Screen extends ConsumerStatefulWidget {
  const OnboardingStep4Screen({super.key});

  @override
  ConsumerState<OnboardingStep4Screen> createState() =>
      _OnboardingStep4ScreenState();
}

class _OnboardingStep4ScreenState extends ConsumerState<OnboardingStep4Screen> {
  final Set<int> _selectedInterestIds = {};
  bool _isLoading = false;

  void _toggleInterest(int interestId) {
    setState(() {
      if (_selectedInterestIds.contains(interestId)) {
        _selectedInterestIds.remove(interestId);
      } else {
        if (_selectedInterestIds.length < 10) {
          _selectedInterestIds.add(interestId);
        }
      }
    });
  }

  void _handleContinue() async {
    if (_selectedInterestIds.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select at least 3 interests')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final repo = ref.read(submitStepRepoProvider);
    repo.requestParams.setStepData(4, {
      'interest_ids': _selectedInterestIds.toList(),
    });

    await repo.execute();

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (repo.state == APIState.success) {
      // Check if onboarding is complete
      final response = repo.latestValidResult;
      if (response != null) {
        // Navigate to home
        context.go('/home');
      }
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
    final interestsRepo = ref.watch(interestsRepoProvider);

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
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  // Back button
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: SvgPicture.asset(
                        Assets.onboardingBackArrow,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  // Buddy logo
                  SvgPicture.asset(
                    Assets.buddyIconWithText,
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(height: 24),
                  // Title
                  Text(
                    'Select your interests',
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Subtitle
                  Text(
                    'Pick up to 3 things you love most',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                  SizedBox(height: 24),
                  // Progress indicators
                  Row(
                    children: [
                      _buildProgressBar(true),
                      SizedBox(width: 12),
                      _buildProgressBar(true),
                      SizedBox(width: 12),
                      _buildProgressBar(true),
                      SizedBox(width: 12),
                      _buildProgressBar(true),
                    ],
                  ),
                  SizedBox(height: 24),
                  // Interests list
                  interestsRepo.latestValidResult != null
                      ? _buildInterestsList(
                          interestsRepo.latestValidResult!.interests,
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                  SizedBox(height: 24),
                  // Selection counter
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _selectedInterestIds.length >= 3
                          ? Color(0xFFE8F5E9)
                          : Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _selectedInterestIds.length >= 3
                            ? Color(0xFF4CAF50)
                            : AppColors.error,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _selectedInterestIds.length >= 3
                          ? '${_selectedInterestIds.length} interests selected'
                          : 'Select at least ${3 - _selectedInterestIds.length} more interest${3 - _selectedInterestIds.length != 1 ? 's' : ''}',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: _selectedInterestIds.length >= 3
                            ? Color(0xFF2E7D32)
                            : AppColors.error,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  // Continue button
                  CustomButton(
                    text: 'Continue',
                    onPressed: _handleContinue,
                    isLoading: _isLoading,
                    backgroundColor: AppColors.primaryDark,
                    textColor: AppColors.primaryPink,
                    width: double.infinity,
                  ),
                  SizedBox(height: 12),
                  // Error message if not enough interests
                  if (_selectedInterestIds.length < 3)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'You must select at least 3 interests',
                        style: AppTextStyles.error,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  SizedBox(height: 20),
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

  Widget _buildInterestsList(List interests) {
    return Wrap(
      spacing: 8,
      runSpacing: 12,
      children: interests.map((interest) {
        final isSelected = _selectedInterestIds.contains(interest.interestId);
        final isDisabled = _selectedInterestIds.length >= 10 && !isSelected;

        return GestureDetector(
          onTap: isDisabled ? null : () => _toggleInterest(interest.interestId),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryBlue.withValues(alpha: 0.2)
                  : AppColors.primaryPink.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryBlue
                    : AppColors.borderLight,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (interest.iconUrl != null)
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.backgroundLight,
                      ),
                      child: Center(
                        child: Text(
                          _getEmojiForInterest(interest.name),
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                Text(
                  interest.name,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: isDisabled
                        ? AppColors.textTertiary
                        : AppColors.primaryDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isSelected)
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.check_circle,
                      size: 16,
                      color: AppColors.primaryBlue,
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  String _getEmojiForInterest(String interestName) {
    final emojiMap = {
      'Technology': '💻',
      'Sports': '⚽',
      'Travel': '✈️',
      'Music': '🎵',
      'Art': '🎨',
      'Reading': '📚',
      'Gaming': '🎮',
      'Cooking': '🍳',
      'Photography': '📸',
      'Fashion': '👗',
      'Books & Literature': '📖',
      'Food & Culinary Arts': '🍽️',
      'Health & Wellness': '💪',
      'Adventure & Outdoor': '🏔️',
      'Pop Culture & Entertainment': '🎭',
    };

    for (final key in emojiMap.keys) {
      if (interestName.toLowerCase().contains(key.toLowerCase())) {
        return emojiMap[key]!;
      }
    }

    return '✨';
  }
}
