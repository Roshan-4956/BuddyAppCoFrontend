import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

/// Reusable selection option widget for onboarding screens
/// Provides consistent design for list-based selections
class SelectionOption extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Widget? iconWidget;
  final bool isSelected;
  final VoidCallback onTap;
  final double height;

  const SelectionOption({
    super.key,
    required this.text,
    this.icon,
    this.iconWidget,
    required this.isSelected,
    required this.onTap,
    this.height = 56.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.selectionBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.selectionBorder : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            // Icon
            if (iconWidget != null)
              iconWidget!
            else if (icon != null)
              CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                radius: 18,
                child: Icon(icon, size: 22),
              ),
            const SizedBox(width: 16),
            // Text
            Expanded(child: Text(text, style: AppTextStyles.optionText)),
            // Selection indicator
            Container(
              margin: const EdgeInsets.only(right: 16),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.selectionBorder
                      : Colors.black26,
                  width: 1.5,
                ),
                color: isSelected
                    ? AppColors.selectionActive
                    : Colors.transparent,
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.check,
                        color: AppColors.selectionBorder,
                        size: 12,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
