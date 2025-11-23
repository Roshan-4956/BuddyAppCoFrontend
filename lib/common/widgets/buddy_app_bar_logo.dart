import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/constants/assets.dart';

/// A reusable component for the Buddy logo in the AppBar.
/// It handles the Hero animation tag and responsive sizing.
class BuddyAppBarLogo extends StatelessWidget {
  /// Optional height override. If null, defaults to 5% of screen height.
  final double? height;

  const BuddyAppBarLogo({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    // Default to 5% of screen height if not provided to match existing design
    final logoHeight = height ?? MediaQuery.of(context).size.height * 0.05;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Hero(
        tag: 'buddy-logo',
        child: SvgPicture.asset(
          Assets.buddyIconWithText,
          height: logoHeight,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
