import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

final selectedGenderProvider1 = StateProvider<int>((ref) => 3);

class LocationPreference extends ConsumerStatefulWidget {
  final String nextLocation;
  const LocationPreference({super.key, required this.nextLocation});

  @override
  ConsumerState<LocationPreference> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<LocationPreference> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selGender = ref.watch(selectedGenderProvider1);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image.asset("assets/genderPrefBG.png", scale: 4),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height / 11,
            left: 30,
            right: 30,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Tell us your preference",
                    style: TextStyle(
                      fontFamily: "Rethink Sans",
                      fontSize: 24,
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
                    "Choose whose profiles you’d\nlike us to recommend",
                    style: TextStyle(
                      fontFamily: "Rethink Sans",
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w600, // Set weight to 1000 if supported
                      color: Color(0xFF8793A1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 5.5,
            left: 30,
            right: 30,
            child: Align(
              alignment: Alignment.topCenter,
              child: LocationOptionSelector(
                selectedIndex: selGender,
                onChanged: (idx) =>
                    ref.read(selectedGenderProvider1.notifier).state = idx,
              ),
            ),
          ),

          Positioned(
            bottom: MediaQuery.of(context).size.height / 11,
            left: 30,
            right: 30,
            child: Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () => GoRouter.of(context).go(widget.nextLocation),
                child: Container(
                  width: (MediaQuery.of(context).size.width) - 30,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  child: Center(
                    child: const Text(
                      'Continue',
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
            ),
          ),
        ],
      ),
    );
  }
}

class LocationOptionSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const LocationOptionSelector({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  // Replace with your graphics asset names!
  static const List<_GenderOptionData> options = [
    _GenderOptionData(
      label: 'Male',
      asset: 'assets/onboarding/male.png',
      color: Color(0xFFA3DF50),
      rotation: 0.06,
      dx: -15,
      dy: -10,
    ),
    _GenderOptionData(
      label: 'Female',
      asset: 'assets/onboarding/female.png',
      color: Color(0xFFF3B8EC),
      rotation: -0.09,
      dx: 8,
      dy: -18,
    ),
    _GenderOptionData(
      label: 'Others',
      asset: 'assets/onboarding/others.png',
      color: Color(0xFF8ED9FE),
      rotation: 0.09,
      dx: -18,
      dy: 8,
    ),
    _GenderOptionData(
      label: 'Prefer not\nto say',
      asset: 'assets/onboarding/prefernot.png',
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
            color: Colors.transparent, // light yellow bg
            borderRadius: BorderRadius.circular(32),
          ),
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          // 2x2 Grid
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [0, 1].map((i) => _genderCard(context, i)).toList(),
              ),
              SizedBox(height: 24),
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
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(horizontal: 8),
            width: 95,
            height: 118,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: selected ? Color(0xFF98D81E) : Colors.transparent,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
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
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        data.asset,
                        width: 54,
                        height: 54,
                        fit: BoxFit.contain,
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
                      border: Border.all(color: Color(0xFF98D81E), width: 1),
                    ),
                    child: selected
                        ? Center(
                            child: Icon(
                              Icons.circle,
                              size: 6,
                              color: Color(0xFF98D81E),
                            ),
                          )
                        : SizedBox(),
                  ),
                ),
                // Option label
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Text(
                      data.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontFamily: "Rethink Sans",
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

class _GenderOptionData {
  final String label;
  final String asset;
  final Color color;
  final double rotation;
  final double dx, dy;
  const _GenderOptionData({
    required this.label,
    required this.asset,
    required this.color,
    required this.rotation,
    required this.dx,
    required this.dy,
  });
}
