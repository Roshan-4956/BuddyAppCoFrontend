import 'package:flutter/material.dart';
import '../../theme/app_text_styles.dart';

/// Error message widget with icon
class ErrorMessage extends StatelessWidget {
  final String message;
  final Widget? icon;

  const ErrorMessage({super.key, required this.message, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon ??
            Icon(
              Icons.error_outline,
              size: 16,
              color: Theme.of(context).colorScheme.error,
            ),
        SizedBox(width: 8),
        Expanded(child: Text(message, style: AppTextStyles.error)),
      ],
    );
  }
}
