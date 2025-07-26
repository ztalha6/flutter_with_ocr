import 'package:flutter/material.dart';
import 'app_colors.dart';

// Application text styles
// Provides consistent typography across the entire app
class AppTextStyles {
  // Prevent instantiation
  AppTextStyles._();

  // Base font family
  static const String _fontFamily =
      'System'; // Use system font for better readability

  // Headline Text Styles
  static const TextStyle headline1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700, // Bold
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle headline3 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: 0,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle headline4 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: 0,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle headline5 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle headline6 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  // Body Text Styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 0.25,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 0.4,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  // Label Text Styles (for buttons, inputs, etc.)
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.5,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  // Semantic Text Styles

  // Button Text Styles
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: 0.5,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: 0.5,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: 0.5,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );

  // Input Field Text Styles
  static const TextStyle inputText = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle inputLabel = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.1,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static const TextStyle inputHint = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 0.15,
    color: AppColors.textTertiary,
    height: 1.5,
  );

  static const TextStyle inputError = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 0.4,
    color: AppColors.error,
    height: 1.3,
  );

  // OCR/Passport Specific Text Styles
  static const TextStyle passportDataLabel = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: 0.5,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static const TextStyle passportDataValue = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle confidenceScore = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600, // Semi-bold
    letterSpacing: 0.4,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static const TextStyle mrzText = TextStyle(
    fontFamily: 'Courier', // Monospace font for MRZ
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    letterSpacing: 1.0,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  // Status Text Styles
  static const TextStyle successText = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.25,
    color: AppColors.success,
    height: 1.4,
  );

  static const TextStyle errorText = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.25,
    color: AppColors.error,
    height: 1.4,
  );

  static const TextStyle warningText = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.25,
    color: AppColors.warning,
    height: 1.4,
  );

  static const TextStyle infoText = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.25,
    color: AppColors.info,
    height: 1.4,
  );

  // Helper methods for text style variations

  /// Creates a text style with specified color
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Creates a text style with specified font weight
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Creates a text style with specified font size
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  /// Creates a text style with specified opacity
  static TextStyle withOpacity(TextStyle style, double opacity) {
    return style.copyWith(color: style.color?.withValues(alpha: opacity));
  }

  /// Creates a text style with underline decoration
  static TextStyle underlined(TextStyle style) {
    return style.copyWith(decoration: TextDecoration.underline);
  }

  /// Creates a text style with strikethrough decoration
  static TextStyle strikethrough(TextStyle style) {
    return style.copyWith(decoration: TextDecoration.lineThrough);
  }
}
