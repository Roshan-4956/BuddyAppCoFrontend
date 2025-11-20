import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// App theme configuration for light and dark modes
class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Color Scheme
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryDark,
      secondary: AppColors.primaryPink,
      tertiary: AppColors.primaryYellow,
      surface: AppColors.surfaceLight,
      error: AppColors.error,
      onPrimary: AppColors.textOnDark,
      onSecondary: AppColors.textOnLight,
      onSurface: AppColors.textPrimary,
      onError: AppColors.white,
      // Additional custom colors
      surfaceContainerHighest: AppColors.chipBg,
      outline: AppColors.borderLight,
      outlineVariant: AppColors.textNeutral60,
    ),

    // Scaffold
    scaffoldBackgroundColor: AppColors.backgroundLight,

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(
        color: AppColors.textHeading,
      ),
      displayMedium: AppTextStyles.displayMedium.copyWith(
        color: AppColors.textHeading,
      ),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(
        color: AppColors.textHeading,
      ),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(
        color: AppColors.textHeading,
      ),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textSecondary,
      ),
      bodySmall: AppTextStyles.bodySmall.copyWith(
        color: AppColors.textNeutral60,
      ),
      labelLarge: AppTextStyles.labelLarge.copyWith(
        color: AppColors.textPrimary,
      ),
      labelMedium: AppTextStyles.labelMedium.copyWith(
        color: AppColors.textSecondary,
      ),
      labelSmall: AppTextStyles.labelSmall.copyWith(
        color: AppColors.textNeutral60,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      hintStyle: AppTextStyles.inputHint,
      labelStyle: AppTextStyles.labelMedium,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.borderLight, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.borderLight, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.borderLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.textOnDark,
        textStyle: AppTextStyles.buttonLarge,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        textStyle: AppTextStyles.buttonLarge,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: BorderSide(color: AppColors.borderLight, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.surfaceLight,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );

  /// Dark theme configuration
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Color Scheme
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryPink,
      secondary: AppColors.primaryDark,
      tertiary: AppColors.accentPinkDark,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
      onPrimary: AppColors.textOnLight,
      onSecondary: AppColors.textOnDark,
      onSurface: AppColors.textOnDark,
      onError: AppColors.white,
      // Additional custom colors
      surfaceContainerHighest: AppColors.lightLavender,
      outline: AppColors.borderDark,
      outlineVariant: AppColors.textNeutral60,
    ),

    // Scaffold
    scaffoldBackgroundColor: AppColors.backgroundDark,

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: AppColors.textOnDark,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.textOnDark),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(
        color: AppColors.textOnDark,
      ),
      displayMedium: AppTextStyles.displayMedium.copyWith(
        color: AppColors.textOnDark,
      ),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(
        color: AppColors.textOnDark,
      ),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(
        color: AppColors.textOnDark,
      ),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.textTertiary,
      ),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textTertiary,
      ),
      bodySmall: AppTextStyles.bodySmall.copyWith(
        color: AppColors.textTertiary,
      ),
      labelLarge: AppTextStyles.labelLarge.copyWith(
        color: AppColors.textOnDark,
      ),
      labelMedium: AppTextStyles.labelMedium.copyWith(
        color: AppColors.textOnDark,
      ),
      labelSmall: AppTextStyles.labelSmall.copyWith(
        color: AppColors.textOnDark,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      hintStyle: AppTextStyles.inputHint,
      labelStyle: AppTextStyles.labelMedium.copyWith(
        color: AppColors.textOnDark,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.borderDark, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.borderDark, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primaryPink, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryPink,
        foregroundColor: AppColors.textOnLight,
        textStyle: AppTextStyles.buttonLarge.copyWith(
          color: AppColors.textOnLight,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.textOnDark,
        textStyle: AppTextStyles.buttonLarge.copyWith(
          color: AppColors.textOnDark,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: BorderSide(color: AppColors.borderDark, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
