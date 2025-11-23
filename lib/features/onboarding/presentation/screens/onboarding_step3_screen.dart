import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/app_router.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/api/core/api_state.dart';
import '../../../../utils/constants/assets.dart';
import '../../application/repositories/static_repo.dart';
import '../../application/repositories/submit_step_repo.dart';
import '../widgets/onboarding_template.dart';

/// Onboarding Step 3: Gender Selection
/// Collects: Gender
class OnboardingStep3Screen extends ConsumerStatefulWidget {
  const OnboardingStep3Screen({super.key});

  @override
  ConsumerState<OnboardingStep3Screen> createState() =>
      _OnboardingStep3ScreenState();
}

class _OnboardingStep3ScreenState extends ConsumerState<OnboardingStep3Screen> {
  int? _selectedGenderId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gendersRepoProvider).execute();
    });
  }

  void _handleNext() async {
    if (_selectedGenderId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select a gender')));
      return;
    }

    setState(() => _isLoading = true);

    final repo = ref.read(submitStepRepoProvider);
    repo.requestParams.setStepData(3, {'gender_id': _selectedGenderId});

    await repo.execute();

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (repo.state == APIState.success) {
      // Navigate to next step
      context.goNamed(AppRouter.step4.name);
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
    final gendersRepo = ref.watch(gendersRepoProvider);

    return OnboardingTemplate(
      currentStep: 3,
      totalSteps: 4,
      title: "What's your gender?",
      subtitle: "We're an inclusive community and\\neveryone is welcome!",
      onNext: _handleNext,
      isNextLoading: _isLoading,
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            'To give you a better experience\\nlet us know your gender',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Rethink Sans',
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildGenderSection(gendersRepo),
        ],
      ),
    );
  }

  Widget _buildGenderSection(dynamic gendersRepo) {
    if (gendersRepo.state.hasError) {
      return Center(
        child: Column(
          children: [
            Text('Failed to load genders', style: AppTextStyles.error),
            TextButton(
              onPressed: () => gendersRepo.execute(),
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (gendersRepo.latestValidResult == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final genders = gendersRepo.latestValidResult!.genders;

    // Build 2x2 grid similar to old genderPreference1.dart
    return Center(
      child: GenderOptionSelector(
        genders: genders,
        selectedGenderId: _selectedGenderId,
        onChanged: (id) {
          setState(() {
            _selectedGenderId = id;
          });
        },
      ),
    );
  }
}

class GenderOptionSelector extends StatelessWidget {
  final List genders;
  final int? selectedGenderId;
  final ValueChanged<int> onChanged;

  const GenderOptionSelector({
    super.key,
    required this.genders,
    required this.selectedGenderId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Define layout structure - we want up to 4 items in 2x2 grid
    final List<List<int>> rows = [];

    if (genders.length >= 2) {
      rows.add([0, 1]); // First row: 2 items
    } else if (genders.length == 1) {
      rows.add([0]); // First row: 1 item
    }

    if (genders.length >= 4) {
      rows.add([2, 3]); // Second row: 2 items
    } else if (genders.length == 3) {
      rows.add([2]); // Second row: 1 item
    }

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0x33F6D307), // light yellow bg like old design
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        child: Column(
          children: rows.map((rowIndexes) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: rowIndexes.map((i) {
                  if (i >= genders.length) return SizedBox.shrink();
                  return _genderCard(context, i);
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _genderCard(BuildContext context, int index) {
    final gender = genders[index];
    final isSelected = selectedGenderId == gender.genderId;

    // Get the appropriate icon asset
    String genderAsset;
    switch (gender.name.toLowerCase()) {
      case 'male':
        genderAsset = Assets.onboardingGenderMale;
        break;
      case 'female':
        genderAsset = Assets.onboardingGenderFemale;
        break;
      case 'others':
        genderAsset = Assets.onboardingGenderOthers;
        break;
      default:
        // For "prefer not to say" or any other option
        genderAsset = 'assets/onboarding/prefernot.png';
    }

    // Rotation and offset values for playful design
    final rotations = [0.06, -0.09, 0.09, -0.03];
    final dxOffsets = [-15.0, 8.0, -18.0, 9.0];
    final dyOffsets = [-10.0, -18.0, 8.0, 16.0];

    final rotation = index < rotations.length ? rotations[index] : 0.0;
    final dx = index < dxOffsets.length ? dxOffsets[index] : 0.0;
    final dy = index < dyOffsets.length ? dyOffsets[index] : 0.0;

    return Transform.translate(
      offset: Offset(dx, dy),
      child: Transform.rotate(
        angle: rotation,
        child: GestureDetector(
          onTap: () => onChanged(gender.genderId),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 95,
            height: 118,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFFFEDC5D) // Yellow border like old design
                    : Colors.transparent,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Gender icon
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        genderAsset,
                        width: 54,
                        height: 54,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.person, size: 40),
                      ),
                    ),
                  ),
                ),
                // Selection indicator
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(
                          0xFFFEDC5D,
                        ), // Yellow like old design
                        width: 1,
                      ),
                    ),
                    child: isSelected
                        ? const Center(
                            child: Icon(
                              Icons.circle,
                              size: 6,
                              color: Color(
                                0xFFFEDC5D,
                              ), // Yellow like old design
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
                // Gender label
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Text(
                      gender.name,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontFamily: 'Rethink Sans',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
