import 'package:flutter/material.dart';

/// App color palette for both light and dark themes
class AppColors {
  AppColors._();

  // Primary Brand Colors
  static const Color primaryPink = Color(0xFFF6DDE1);
  static const Color primaryYellow = Color(0xFFF6D307);
  static const Color primaryDark = Color(0xFF1E1E1E);
  static const Color primaryBlue = Color(0xFF64BDFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textHeading = Color(0xFF555555);
  static const Color textSecondary = Color(0xFF424242);
  static const Color textTertiary = Color(0xFF8793A1); // Neutral/Gray text
  static const Color textSubtle = Color(0x99555555); // rgba(85, 85, 85, 0.6)
  static const Color textNeutral60 = Color(0xFF8793A1);
  static const Color textOnDark = Color(0xFFF6DDE1);
  static const Color textOnLight = Color(0xFF1E1E1E);
  static const Color textOnChip = Color(0xCC000000); // rgba(0, 0, 0, 0.8)

  // Background Colors
  static const Color backgroundLight = Colors.white;
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Component Backgrounds
  static const Color chipBg = Color(0x54F6DDE1); // rgba(246, 221, 225, 0.33)
  static const Color chipBgAlt = Color(0x52F6DDE1); // rgba(246, 221, 225, 0.32)
  static const Color statCardBg = Color(0x4DF6DDE1); // rgba(246, 221, 225, 0.3)
  static const Color progressTrack = Color(0xFFFFE75D);

  // Button States
  static const Color buttonInactive = Color(
    0xCC1E1E1E,
  ); // rgba(30, 30, 30, 0.8)

  // Error Colors
  static const Color error = Color(0xFFBC1010);
  static const Color errorLight = Color(0xFFFFEBEE);

  // Border Colors
  static const Color borderLight = Color(0xFFF6DDE1);
  static const Color borderDark = Color(0xFF555555);

  // Accent & Decorative Colors
  static const Color accentPink = Color(0xFFFFB9FF);
  static const Color accentPinkDark = Color(0xFFE769CE);
  static const Color lightLavender = Color(0xFFFFDAFF);

  // Shadows (for reference, use with opacity in BoxShadow)
  static const Color cardShadowColor = Color(0x24000000); // rgba(0, 0, 0, 0.14)
  static const Color bottomBarShadowColor = Color(
    0x2B000000,
  ); // rgba(0, 0, 0, 0.17)

  // Selection Colors (for onboarding and similar UIs)
  static const Color selectionBackground = Color(0xFFE9F4FF);
  static const Color selectionBorder = Color(0xFF53A9FF);
  static const Color selectionActive = Color(0x4253A9FF); // 26% opacity

  // Other Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
}
