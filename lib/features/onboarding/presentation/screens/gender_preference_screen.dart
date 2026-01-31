import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../routing/app_router.dart';
import '../../../../utils/constants/assets.dart';
import '../widgets/onboarding_template.dart';

part 'gender_preference_screen.g.dart';

// State provider for gender preference (0: Male, 1: Female, 2: Others, 3: Prefer not to say)
@riverpod
class SelectedGenderPreference extends _$SelectedGenderPreference {
  @override
  int build() => 3;

  void select(int value) => state = value;
}

class GenderPreferenceScreen extends ConsumerStatefulWidget {
  const GenderPreferenceScreen({super.key});

  @override
  ConsumerState<GenderPreferenceScreen> createState() =>
      _GenderPreferenceScreenState();
}

class _GenderPreferenceScreenState
    extends ConsumerState<GenderPreferenceScreen> {
  @override
  Widget build(BuildContext context) {
    final selGender = ref.watch(selectedGenderPreferenceProvider);

    return OnboardingTemplate(
      currentStep: 5,
      totalSteps: 5, // 5 steps in UI
      title: 'Tell us your preference',
      subtitle: 'Choose whose profiles you’d\nlike us to recommend',
      nextButtonText: 'Continue',
      onNext: () {
        // Navigate to Home or next step
        context.goNamed(AppRouter.home.name);
      },
      child: Center(
        child: GenderOptionSelector(
          selectedIndex: selGender,
          onChanged: (idx) =>
              ref.read(selectedGenderPreferenceProvider.notifier).select(idx),
        ),
      ),
    );
  }
}

class GenderOptionSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const GenderOptionSelector({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  static const List<GenderOptionData> options = [
    GenderOptionData(
      label: 'Male',
      asset: Assets.onboardingGenderMale,
      color: Color(0xFFA3DF50),
      rotation: 0.06,
      dx: -15,
      dy: -10,
    ),
    GenderOptionData(
      label: 'Female',
      asset: Assets.onboardingGenderFemale,
      color: Color(0xFFF3B8EC),
      rotation: -0.09,
      dx: 8,
      dy: -18,
    ),
    GenderOptionData(
      label: 'Others',
      asset: Assets.onboardingGenderOthers,
      color: Color(0xFF8ED9FE),
      rotation: 0.09,
      dx: -18,
      dy: 8,
    ),
    GenderOptionData(
      label: 'Prefer not\nto say',
      asset: 'assets/onboarding/prefernot.png', // Needs asset check
      color: Color(0xFFFBE36A),
      rotation: -0.03,
      dx: 9,
      dy: 16,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          // 2x2 Grid
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [0, 1].map((i) => _genderCard(context, i)).toList(),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [2, 3].map((i) => _genderCard(context, i)).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _genderCard(BuildContext context, int i) {
    final selected = selectedIndex == i;
    final data = options[i];

    return Transform.translate(
      offset: Offset(data.dx, data.dy),
      child: Transform.rotate(
        angle: data.rotation,
        child: GestureDetector(
          onTap: () => onChanged(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 95,
            height: 118,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: selected ? const Color(0xFF98D81E) : Colors.transparent,
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
                // Face or custom PNG here
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
                        data.asset,
                        width: 54,
                        height: 54,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.person, size: 40),
                      ),
                    ),
                  ),
                ),
                // Tick or unselected icon
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
                        color: const Color(0xFF98D81E),
                        width: 1,
                      ),
                    ),
                    child: selected
                        ? const Center(
                            child: Icon(
                              Icons.circle,
                              size: 6,
                              color: Color(0xFF98D81E),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
                // Option label
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Text(
                      data.label,
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

class GenderOptionData {
  final String label;
  final String asset;
  final Color color;
  final double rotation;
  final double dx, dy;
  const GenderOptionData({
    required this.label,
    required this.asset,
    required this.color,
    required this.rotation,
    required this.dx,
    required this.dy,
  });
}
