import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/api/core/api_state.dart';
import '../../../../utils/constants/assets.dart';
import '../../application/repositories/submit_step_repo.dart';

/// Onboarding Step 3: Profile Photo
/// Collects: Profile photo (base64 encoded)
class OnboardingStep3Screen extends ConsumerStatefulWidget {
  const OnboardingStep3Screen({super.key});

  @override
  ConsumerState<OnboardingStep3Screen> createState() =>
      _OnboardingStep3ScreenState();
}

class _OnboardingStep3ScreenState extends ConsumerState<OnboardingStep3Screen> {
  String? _selectedImagePath;
  String? _selectedImageName;
  bool _isLoading = false;

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Photo Source'),
        content: Text('Choose where to pick the photo from'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _simulateCameraCapture();
            },
            child: Text('Take Photo'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _simulateGalleryPick();
            },
            child: Text('Choose from Gallery'),
          ),
        ],
      ),
    );
  }

  void _simulateCameraCapture() {
    // In a real app, this would use image_picker to capture from camera
    setState(() {
      _selectedImagePath = 'camera_photo';
      _selectedImageName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
    });
  }

  void _simulateGalleryPick() {
    // In a real app, this would use image_picker to pick from gallery
    setState(() {
      _selectedImagePath = 'gallery_photo';
      _selectedImageName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
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
      repo.requestParams.setStepData(3, {'profile_photo': base64Image});

      await repo.execute();

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (repo.state == APIState.success) {
        // Navigate to next step
        context.go('/onboarding/step4');
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
                  // Title
                  Text(
                    "You're all set!",
                    style: AppTextStyles.displayMedium.copyWith(
                      color: AppColors.primaryDark,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Subtitle
                  Text(
                    'Add your profile picture so people can find you',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                  SizedBox(height: 40),
                  // Progress indicators
                  Row(
                    children: [
                      _buildProgressBar(true),
                      SizedBox(width: 12),
                      _buildProgressBar(true),
                      SizedBox(width: 12),
                      _buildProgressBar(true),
                      SizedBox(width: 12),
                      _buildProgressBar(false),
                    ],
                  ),
                  SizedBox(height: 40),
                  // Form container
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x2D000000),
                          blurRadius: 20.1,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Photo preview or placeholder
                        GestureDetector(
                          onTap: _showImageSourceDialog,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Color(0xFFFEF6D1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.primaryYellow,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              size: 48,
                              color: AppColors.primaryYellow,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // File indicator
                        if (_selectedImageName != null)
                          Column(
                            children: [
                              Text(
                                _selectedImageName!,
                                style: AppTextStyles.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Tap to change',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.textTertiary,
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Gallery button
                            Expanded(
                              child: GestureDetector(
                                onTap: _simulateGalleryPick,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primaryBlue,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image_outlined,
                                        size: 16,
                                        color: AppColors.primaryBlue,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Select from device',
                                        style: AppTextStyles.labelSmall
                                            .copyWith(
                                              color: AppColors.primaryBlue,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            // Camera button
                            Expanded(
                              child: GestureDetector(
                                onTap: _simulateCameraCapture,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primaryBlue,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        size: 16,
                                        color: AppColors.primaryBlue,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Take photo',
                                        style: AppTextStyles.labelSmall
                                            .copyWith(
                                              color: AppColors.primaryBlue,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                        // Next button
                        CustomButton(
                          text: 'Next',
                          onPressed: _handleNext,
                          isLoading: _isLoading,
                          backgroundColor: AppColors.primaryDark,
                          textColor: AppColors.primaryPink,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
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
}
