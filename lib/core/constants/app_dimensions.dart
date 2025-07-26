// Application dimensions and spacing constants
// Provides consistent spacing and sizing across the entire app
class AppDimensions {
  // Prevent instantiation
  AppDimensions._();

  // Base Spacing Unit (8dp Material Design system)
  static const double _baseUnit = 8.0;

  // Spacing Constants (based on 8dp grid)
  static const double spaceXXS = _baseUnit * 0.5; // 4dp
  static const double spaceXS = _baseUnit; // 8dp
  static const double spaceS = _baseUnit * 1.5; // 12dp
  static const double spaceM = _baseUnit * 2; // 16dp
  static const double spaceL = _baseUnit * 3; // 24dp
  static const double spaceXL = _baseUnit * 4; // 32dp
  static const double spaceXXL = _baseUnit * 6; // 48dp
  static const double spaceXXXL = _baseUnit * 8; // 64dp

  // Semantic Spacing (named by purpose)
  static const double paddingTiny = spaceXXS; // 4dp
  static const double paddingSmall = spaceXS; // 8dp
  static const double paddingMedium = spaceM; // 16dp
  static const double paddingLarge = spaceL; // 24dp
  static const double paddingXLarge = spaceXL; // 32dp

  static const double marginTiny = spaceXXS; // 4dp
  static const double marginSmall = spaceXS; // 8dp
  static const double marginMedium = spaceM; // 16dp
  static const double marginLarge = spaceL; // 24dp
  static const double marginXLarge = spaceXL; // 32dp

  // Button Dimensions
  static const double buttonHeightSmall = _baseUnit * 4; // 32dp
  static const double buttonHeightMedium = _baseUnit * 6; // 48dp
  static const double buttonHeightLarge = _baseUnit * 7; // 56dp

  static const double buttonPaddingHorizontalSmall = spaceM; // 16dp
  static const double buttonPaddingHorizontalMedium = spaceL; // 24dp
  static const double buttonPaddingHorizontalLarge = spaceXL; // 32dp

  static const double buttonPaddingVertical = spaceS; // 12dp

  // Input Field Dimensions
  static const double inputHeight = _baseUnit * 7; // 56dp
  static const double inputHeightSmall = _baseUnit * 5; // 40dp
  static const double inputPaddingHorizontal = spaceM; // 16dp
  static const double inputPaddingVertical = spaceS; // 12dp

  // Card Dimensions
  static const double cardPadding = spaceM; // 16dp
  static const double cardPaddingLarge = spaceL; // 24dp
  static const double cardMargin = spaceM; // 16dp

  // Icon Sizes
  static const double iconTiny = _baseUnit * 2; // 16dp
  static const double iconSmall = _baseUnit * 3; // 24dp
  static const double iconMedium = _baseUnit * 4; // 32dp
  static const double iconLarge = _baseUnit * 6; // 48dp
  static const double iconXLarge = _baseUnit * 8; // 64dp

  // Border Dimensions
  static const double borderWidthThin = 1.0;
  static const double borderWidthMedium = 2.0;
  static const double borderWidthThick = 4.0;

  // Border Radius
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusCircular = 1000.0; // For fully rounded corners

  // Elevation/Shadow
  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationVeryHigh = 16.0;

  // Screen Padding (safe area + additional padding)
  static const double screenPaddingHorizontal = spaceM; // 16dp
  static const double screenPaddingVertical = spaceM; // 16dp
  static const double screenPaddingTop = spaceL; // 24dp
  static const double screenPaddingBottom = spaceL; // 24dp

  // List Item Dimensions
  static const double listItemHeight = _baseUnit * 8; // 64dp
  static const double listItemHeightSmall = _baseUnit * 6; // 48dp
  static const double listItemHeightLarge = _baseUnit * 10; // 80dp
  static const double listItemPadding = spaceM; // 16dp

  // OCR/Camera Specific Dimensions
  static const double cameraOverlayThickness = 3.0;
  static const double mrzOverlayHeight = _baseUnit * 10; // 80dp
  static const double mrzCornerLength = _baseUnit * 3; // 24dp

  // Passport Card Dimensions
  static const double passportCardHeight = _baseUnit * 25; // 200dp
  static const double passportCardWidth =
      _baseUnit * 37.5; // 300dp (3:2 aspect ratio)
  static const double passportFieldSpacing = spaceS; // 12dp

  // Loading Indicator Dimensions
  static const double loadingIndicatorSize = _baseUnit * 6; // 48dp
  static const double loadingIndicatorSizeSmall = _baseUnit * 3; // 24dp
  static const double loadingIndicatorSizeLarge = _baseUnit * 8; // 64dp

  // Modal/Dialog Dimensions
  static const double dialogPadding = spaceL; // 24dp
  static const double dialogMargin = spaceL; // 24dp
  static const double dialogMaxWidth = _baseUnit * 50; // 400dp
  static const double dialogMinHeight = _baseUnit * 20; // 160dp

  // App Bar Dimensions
  static const double appBarHeight = _baseUnit * 7; // 56dp
  static const double appBarElevation = elevationMedium; // 4dp

  // Bottom Navigation Dimensions
  static const double bottomNavHeight = _baseUnit * 8; // 64dp
  static const double bottomNavIconSize = iconMedium; // 32dp

  // Floating Action Button Dimensions
  static const double fabSize = _baseUnit * 7; // 56dp
  static const double fabSizeMini = _baseUnit * 5; // 40dp
  static const double fabMargin = spaceM; // 16dp

  // Tab Dimensions
  static const double tabHeight = _baseUnit * 6; // 48dp
  static const double tabIndicatorHeight = 3.0;

  // Progress Indicator Dimensions
  static const double progressIndicatorHeight = 4.0;
  static const double progressIndicatorHeightThick = 8.0;

  // Breakpoints for Responsive Design
  static const double breakpointMobile = 600;
  static const double breakpointTablet = 1024;
  static const double breakpointDesktop = 1440;

  // Animation Durations (in milliseconds)
  static const int animationDurationFast = 150;
  static const int animationDurationMedium = 300;
  static const int animationDurationSlow = 500;
  static const int animationDurationVerySlow = 800;

  // Helper methods for responsive design

  /// Returns appropriate spacing based on screen size
  static double responsiveSpacing(double screenWidth) {
    if (screenWidth < breakpointMobile) {
      return spaceM; // 16dp for mobile
    } else if (screenWidth < breakpointTablet) {
      return spaceL; // 24dp for tablet
    } else {
      return spaceXL; // 32dp for desktop
    }
  }

  /// Returns appropriate padding based on screen size
  static double responsivePadding(double screenWidth) {
    if (screenWidth < breakpointMobile) {
      return paddingMedium; // 16dp for mobile
    } else if (screenWidth < breakpointTablet) {
      return paddingLarge; // 24dp for tablet
    } else {
      return paddingXLarge; // 32dp for desktop
    }
  }

  /// Returns appropriate card width based on screen size
  static double responsiveCardWidth(double screenWidth) {
    if (screenWidth < breakpointMobile) {
      return screenWidth - (spaceM * 2); // Full width minus margins
    } else if (screenWidth < breakpointTablet) {
      return screenWidth * 0.8; // 80% of screen width
    } else {
      return 600; // Fixed width for desktop
    }
  }

  /// Returns appropriate column count for grid layouts
  static int responsiveColumnCount(double screenWidth) {
    if (screenWidth < breakpointMobile) {
      return 1; // Single column for mobile
    } else if (screenWidth < breakpointTablet) {
      return 2; // Two columns for tablet
    } else {
      return 3; // Three columns for desktop
    }
  }
}
