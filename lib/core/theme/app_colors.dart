import 'package:flutter/material.dart';

// Application color palette
// Provides consistent colors across the entire app
class AppColors {
  // Prevent instantiation
  AppColors._();

  // Primary Brand Colors
  static const Color primary = Color(0xFF1B5E20); // Dark green - passport theme
  static const Color primaryLight = Color(0xFF4C8C4A);
  static const Color primaryDark = Color(0xFF0D2818);

  // Secondary Colors
  static const Color secondary = Color(0xFF2E7D32); // Medium green
  static const Color secondaryLight = Color(0xFF60AD5E);
  static const Color secondaryDark = Color(0xFF1B5E20);

  // Accent Colors
  static const Color accent = Color(0xFF4CAF50); // Bright green for CTAs
  static const Color accentLight = Color(0xFF80E27E);
  static const Color accentDark = Color(0xFF087F23);

  // Neutral Colors
  static const Color background = Color(0xFFFAFAFA); // Light gray background
  static const Color surface = Color(0xFFFFFFFF); // White cards/surfaces
  static const Color surfaceVariant = Color(0xFFF5F5F5); // Subtle variant

  // Text Colors
  static const Color textPrimary = Color(0xFF212121); // Dark gray - main text
  static const Color textSecondary = Color(
    0xFF757575,
  ); // Medium gray - secondary text
  static const Color textTertiary = Color(
    0xFF9E9E9E,
  ); // Light gray - hints/placeholders
  static const Color textOnPrimary = Color(
    0xFFFFFFFF,
  ); // White text on primary colors

  // Status/Semantic Colors
  static const Color success = Color(0xFF4CAF50); // Success messages
  static const Color successLight = Color(0xFFC8E6C9);
  static const Color successDark = Color(0xFF1B5E20);

  static const Color error = Color(0xFFD32F2F); // Error messages
  static const Color errorLight = Color(0xFFFFCDD2);
  static const Color errorDark = Color(0xFFB71C1C);

  static const Color warning = Color(0xFFF57C00); // Warning messages
  static const Color warningLight = Color(0xFFFFE0B2);
  static const Color warningDark = Color(0xFFE65100);

  static const Color info = Color(0xFF1976D2); // Info messages
  static const Color infoLight = Color(0xFFBBDEFB);
  static const Color infoDark = Color(0xFF0D47A1);

  // OCR/Camera Specific Colors
  static const Color cameraOverlay = Color(
    0x80000000,
  ); // Semi-transparent black
  static const Color mrzHighlight = Color(
    0xFF4CAF50,
  ); // Green for MRZ detection
  static const Color confidenceHigh = Color(
    0xFF4CAF50,
  ); // High confidence indicator
  static const Color confidenceMedium = Color(0xFFFF9800); // Medium confidence
  static const Color confidenceLow = Color(0xFFD32F2F); // Low confidence

  // Border Colors
  static const Color border = Color(0xFFE0E0E0); // Default borders
  static const Color borderFocus = Color(0xFF4CAF50); // Focused input borders
  static const Color borderError = Color(0xFFD32F2F); // Error borders

  // Divider Colors
  static const Color divider = Color(0xFFBDBDBD);
  static const Color dividerLight = Color(0xFFE0E0E0);

  // Shadow Colors
  static const Color shadow = Color(0x1F000000); // Light shadow
  static const Color shadowMedium = Color(0x33000000); // Medium shadow
  static const Color shadowHeavy = Color(0x4D000000); // Heavy shadow

  // Disabled Colors
  static const Color disabled = Color(0xFFBDBDBD);
  static const Color disabledText = Color(0xFF9E9E9E);

  // Helper methods for color variations

  /// Creates a lighter shade of the given color
  static Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// Creates a darker shade of the given color
  static Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// Creates a color with specified opacity
  static Color withOpacity(Color color, double opacity) {
    assert(opacity >= 0 && opacity <= 1);
    return color.withValues(alpha: opacity);
  }

  // Material Color Swatch for primary color
  static const MaterialColor primarySwatch =
      MaterialColor(0xFF1B5E20, <int, Color>{
        50: Color(0xFFE8F5E8),
        100: Color(0xFFC8E6C9),
        200: Color(0xFFA5D6A7),
        300: Color(0xFF81C784),
        400: Color(0xFF66BB6A),
        500: Color(0xFF4CAF50),
        600: Color(0xFF43A047),
        700: Color(0xFF388E3C),
        800: Color(0xFF2E7D32),
        900: Color(0xFF1B5E20),
      });
}
