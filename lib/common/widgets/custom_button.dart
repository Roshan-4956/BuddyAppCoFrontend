import 'package:flutter/material.dart';

/// Custom button widget with consistent styling
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 55,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final button = isOutlined
        ? OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: backgroundColor != null
                ? OutlinedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    foregroundColor: textColor,
                  )
                : null,
            child: _buildButtonChild(),
          )
        : ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: backgroundColor != null
                ? ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    foregroundColor: textColor,
                  )
                : null,
            child: _buildButtonChild(),
          );

    return SizedBox(width: width, height: height, child: button);
  }

  Widget _buildButtonChild() {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor ?? Colors.white),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [icon!, SizedBox(width: 8), Text(text)],
      );
    }

    return Text(text);
  }
}
