import 'package:flutter/material.dart';

class GenderOptionSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const GenderOptionSelector({
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
      rotation: -0.06,
      dx: -8,
      dy: -10,
    ),
    _GenderOptionData(
      label: 'Female',
      asset: 'assets/onboarding/female.png',
      color: Color(0xFFF3B8EC),
      rotation: 0.05,
      dx: 8,
      dy: -18,
    ),
    _GenderOptionData(
      label: 'Others',
      asset: 'assets/onboarding/others.png',
      color: Color(0xFF8ED9FE),
      rotation: 0.09,
      dx: -8,
      dy: 8,
    ),
    _GenderOptionData(
      label: 'Prefer not\nto say',
      asset: 'assets/onboarding/prefernot.png',
      color: Color(0xFFFBE36A),
      rotation: -0.03,
      dx: 6,
      dy: 16,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 7),
        Text(
          "To give you a better experience\nlet us know your gender",
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 16,
            fontFamily: "Rethink Sans",
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Color(0x33F6D307), // light yellow bg
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
                color: selected ? Color(0xFFFEDC5D) : Colors.transparent,
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
                      border: Border.all(color: Color(0xFFFEDC5D), width: 1),
                    ),
                    child: selected
                        ? Center(
                            child: Icon(
                              Icons.circle,
                              size: 6,
                              color: Color(0xFFFEDC5D),
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
