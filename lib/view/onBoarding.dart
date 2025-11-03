import 'package:buddy_app/Widgets/occupationWidget.dart';
import 'package:buddy_app/Widgets/profilePhotoSelector.dart';
import 'package:buddy_app/Widgets/registrationFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

import '../Widgets/genderWidget.dart';

// Providers
final stepIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
final selectedStateProvider = StateProvider.autoDispose<String>((ref) => '');
final selectedCityProvider = StateProvider.autoDispose<String>((ref) => '');
final occupationIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
final selectedGenderProvider = StateProvider<int>((ref) => 3);

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final List<String> stepColors = [
    "assets/onboarding/step_1.png",
    "assets/onboarding/step_2.png",
    "assets/onboarding/step_3.png",
    "assets/onboarding/step_4.png",
  ];

  final List<String> stepTitles = [
    "Let's get to know you :)",
    "Getting closer!",
    "Almost There",
    "You're all set!",
  ];

  final List<String> stepSubtitles = [
    "Just a few basics and we'll set things\nup for you",
    "These details will help us curate the\nbest experience for you",
    "We're an inclusive community and\neveryone is welcome!",
    "Hope you have a great time inside :)",
  ];
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _dobController = TextEditingController();

  void onBackPressed() {
    final step = ref.read(stepIndexProvider);

    if (step == 0) {
      context.pop(); // Go to the previous screen or close onboarding
    } else {
      ref.read(stepIndexProvider.notifier).state = step - 1;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dobController.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      setState(() {}); // to update on optional UI if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = ref.watch(stepIndexProvider);
    final selectedState = ref.watch(selectedStateProvider);
    final selectedCity = ref.watch(selectedCityProvider);
    final selectedIndex = ref.watch(occupationIndexProvider);
    final selectedGender = ref.watch(selectedGenderProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image.asset(stepColors[step], scale: 4),
            ),
          ),
          if (step != 0)
            Positioned(
              top: 70,
              left: 20,
              child: GestureDetector(
                child: Image.asset("assets/backArrowWhite.png", scale: 4),
                onTap: () => onBackPressed(),
              ),
            ),

          Positioned(
            top: MediaQuery.of(context).size.height / 7,
            left: 30,
            right: 30,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    stepTitles[step],
                    style: TextStyle(
                      fontFamily: "Rethink Sans",
                      fontSize: 36,
                      fontVariations: [
                        FontVariation(
                          'wght',
                          1000,
                        ), // Set weight to 1000 if supported
                      ],
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  Text(
                    stepSubtitles[step],
                    style: TextStyle(
                      fontFamily: "Rethink Sans",
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w600, // Set weight to 1000 if supported
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3,
            left: 30,
            right: 30,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: (MediaQuery.of(context).size.width) - 30,
                height: (2 * (MediaQuery.of(context).size.height / 3)) - 37.5,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(
                        0.5,
                      ), // Shadow color with opacity
                      spreadRadius: 2, // How much the shadow spreads
                      blurRadius: 5, // Softness of the shadow
                      offset: Offset(0, 3), // Position of the shadow (x, y)
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        stepBar(4, step + 1),
                        if (step == 0)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: RegistrationFormFields(
                              fullNameController: _fullNameController,
                              dobController: _dobController,
                              addressController: _addressController,
                              selectedState: selectedState,
                              selectedCity: selectedCity,
                              onSelectDate: _selectDate,
                              onStateChanged: (val) {
                                ref.read(selectedStateProvider.notifier).state =
                                    val ?? "";
                                // City must be reset if state changes
                                ref.read(selectedCityProvider.notifier).state =
                                    "";
                              },
                              onCityChanged: (val) {
                                ref.read(selectedCityProvider.notifier).state =
                                    val ?? "";
                              },
                            ),
                          ),
                        if (step == 1)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: OccupationSelection(
                              selectedIndex: selectedIndex,
                              onChanged: (idx) =>
                                  ref
                                          .read(
                                            occupationIndexProvider.notifier,
                                          )
                                          .state =
                                      idx,
                            ),
                          ),
                        if (step == 2)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: GenderOptionSelector(
                              selectedIndex: selectedGender,
                              onChanged: (idx) =>
                                  ref
                                          .read(selectedGenderProvider.notifier)
                                          .state =
                                      idx,
                            ),
                          ),
                        if (step == 3)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ProfilePictureSetup(),
                          ),
                        GestureDetector(
                          onTap: () {
                            if (step < 3) {
                              ref.read(stepIndexProvider.notifier).state++;
                            } else {
                              // Final step action
                              GoRouter.of(context).go("/interestCapture");
                            }
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width) - 120,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(
                                20,
                              ), // Rounded corners
                            ),
                            child: Center(
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  fontFamily: "Rethink Sans",
                                  color: Color(0xFFF6DDE1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
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
        ],
      ),
    );
  }

  Widget stepBar(int totalSteps, int currentStep) {
    return Row(
      children: List.generate(totalSteps, (index) {
        bool isActive = index < currentStep;
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            height: 4,
            decoration: BoxDecoration(
              color: isActive ? Color(0xFF505050) : Color(0x73505050),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
