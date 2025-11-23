import 'package:buddy_app/features/onboarding/presentation/widgets/onboarding_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/app_router.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/api/core/api_state.dart';
import '../../../../utils/constants/assets.dart';
import '../../application/repositories/submit_step_repo.dart';

/// Onboarding Step 4: Profile Photo
/// Collects: Profile photo (base64 encoded)
class OnboardingStep4Screen extends ConsumerStatefulWidget {
  const OnboardingStep4Screen({super.key});

  @override
  ConsumerState<OnboardingStep4Screen> createState() =>
      _OnboardingStep4ScreenState();
}

class _OnboardingStep4ScreenState extends ConsumerState<OnboardingStep4Screen> {
  String? _selectedImagePath;
  int _selectedAvatarIndex = 0;
  bool _isLoading = false;

  // List of avatar assets
  final List<String> _avatarAssets = [
    Assets.onboardingAvatar1,
    Assets.onboardingAvatar2,
    Assets.onboardingAvatar3,
    Assets.onboardingAvatar4,
    Assets.onboardingAvatar5,
  ];

  void _simulateCameraCapture() {
    // In a real app, this would use image_picker to capture from camera
    setState(() {
      _selectedImagePath = 'camera_photo';
    });
  }

  void _simulateGalleryPick() {
    // In a real app, this would use image_picker to pick from gallery
    setState(() {
      _selectedImagePath = 'gallery_photo';
    });
  }

  String _createMockBase64Image() {
    // Create a mock base64 string for demo purposes
    // In production, this would be the actual image bytes
    final mockImageData =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==';
    return 'data:image/png;base64,$mockImageData';
  }

  void _handleNext() async {
    if (_selectedImagePath == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select or take a photo')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final base64Image = _createMockBase64Image();

      final repo = ref.read(submitStepRepoProvider);
      repo.requestParams.setStepData(4, {'profile_photo': base64Image});

      await repo.execute();

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (repo.state == APIState.success) {
        // Navigate to next step
        context.goNamed(AppRouter.step5.name);
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
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error processing image: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingTemplate(
      currentStep: 4,
      totalSteps: 4,
      title: 'Almost There',
      subtitle: "We're an inclusive community and\neveryone is welcome!",
      onNext: _handleNext,
      isNextLoading: _isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 4),
          Text(
            'Add your profile picture so\npeople can find you',
            textAlign: TextAlign.center,
            style: AppTextStyles.questionText,
          ),
          const SizedBox(height: 24),
          // Avatar circle display
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: _selectedImagePath != null
                  ? Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF6D1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryYellow,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: AppColors.primaryYellow,
                      ),
                    )
                  : Image.asset(
                      _avatarAssets[_selectedAvatarIndex],
                      fit: BoxFit.fitWidth,
                      errorBuilder: (_, __, ___) => Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF6D1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryYellow,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: AppColors.primaryYellow,
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          // Avatar selector
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              return Padding(
                padding: EdgeInsets.only(right: i == 4 ? 0 : 8),
                child: GestureDetector(
                  onTap: () => setState(() {
                    _selectedAvatarIndex = i;
                    _selectedImagePath = null;
                  }),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _selectedAvatarIndex == i
                            ? Color(0xFFFFB9FF)
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        _avatarAssets[i],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Icon(Icons.person, size: 20, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Gallery button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _simulateGalleryPick,
                  icon: Image.asset(
                    Assets.onboardingGallery,
                    scale: 4,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.photo_library, size: 20),
                  ),
                  label: Text(
                    'Select from device',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      fontFamily: 'Rethink Sans',
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                    backgroundColor: WidgetStateProperty.all(Color(0x4DFFB9FF)),
                    side: WidgetStateProperty.all(
                      BorderSide(color: Color(0xFFFFB9FF), width: 1.5),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Camera button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _simulateCameraCapture,
                  icon: Image.asset(
                    Assets.onboardingCamera,
                    scale: 4,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.camera_alt, size: 20),
                  ),
                  label: Text(
                    'Take photo',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      fontFamily: 'Rethink Sans',
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                    backgroundColor: WidgetStateProperty.all(Color(0x4DFFB9FF)),
                    side: WidgetStateProperty.all(
                      BorderSide(color: Color(0xFFFFB9FF), width: 1.5),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
