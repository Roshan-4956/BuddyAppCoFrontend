import 'package:flutter/material.dart';
import '../../theme/app_text_styles.dart';

/// Custom text field widget with consistent styling
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.controller,
    this.label,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTextStyles.labelMedium.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          obscuringCharacter: '•',
          keyboardType: keyboardType,
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readOnly,
          maxLines: maxLines,
          maxLength: maxLength,
          cursorColor: theme.colorScheme.primary,
          style: AppTextStyles.inputText.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            errorStyle: AppTextStyles.error,
            counterText: '',
          ),
        ),
      ],
    );
  }
}
