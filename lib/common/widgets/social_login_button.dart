import 'package:flutter/material.dart';

/// Social login button widget for Apple, Google, etc.
class SocialLoginButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;
  final double? width;
  final double height;

  const SocialLoginButton({
    super.key,
    required this.assetPath,
    required this.onPressed,
    this.width,
    this.height = 55,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(
            color: theme.brightness == Brightness.light
                ? Color(0xFFF6DDE1)
                : Color(0xFF555555),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            scale: 4,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.image_not_supported,
                color: theme.colorScheme.onSurface,
              );
            },
          ),
        ),
      ),
    );
  }
}
