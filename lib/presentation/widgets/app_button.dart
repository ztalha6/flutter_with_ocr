import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

// Reusable button component with consistent styling
// Supports primary, secondary, icon, and disabled variants
class AppButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final bool isExpanded;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  const AppButton({
    super.key,
    this.text,
    this.icon,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isExpanded = false,
    this.leadingIcon,
    this.trailingIcon,
  }) : assert(
         text != null || icon != null,
         'Either text or icon must be provided',
       );

  // Primary button constructor
  const AppButton.primary({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isExpanded = false,
    this.leadingIcon,
    this.trailingIcon,
  }) : type = AppButtonType.primary,
       icon = null;

  // Secondary button constructor
  const AppButton.secondary({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isExpanded = false,
    this.leadingIcon,
    this.trailingIcon,
  }) : type = AppButtonType.secondary,
       icon = null;

  // Icon button constructor
  const AppButton.icon({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
  }) : type = AppButtonType.icon,
       text = null,
       isExpanded = false,
       leadingIcon = null,
       trailingIcon = null;

  // Text button constructor
  const AppButton.text({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isExpanded = false,
    this.leadingIcon,
    this.trailingIcon,
  }) : type = AppButtonType.text,
       icon = null;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    if (type == AppButtonType.icon) {
      return _buildIconButton(context, isEnabled);
    }

    return _buildRegularButton(context, isEnabled);
  }

  Widget _buildRegularButton(BuildContext context, bool isEnabled) {
    final buttonChild = _buildButtonChild();

    final button = switch (type) {
      AppButtonType.primary => ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: _getPrimaryButtonStyle(isEnabled),
        child: buttonChild,
      ),
      AppButtonType.secondary => OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: _getSecondaryButtonStyle(isEnabled),
        child: buttonChild,
      ),
      AppButtonType.text => TextButton(
        onPressed: isEnabled ? onPressed : null,
        style: _getTextButtonStyle(isEnabled),
        child: buttonChild,
      ),
      AppButtonType.icon => throw UnimplementedError(), // Handled separately
    };

    return isExpanded
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }

  Widget _buildIconButton(BuildContext context, bool isEnabled) {
    return IconButton(
      onPressed: isEnabled ? onPressed : null,
      icon:
          isLoading
              ? SizedBox(
                width: _getIconSize(),
                height: _getIconSize(),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isEnabled ? AppColors.primary : AppColors.disabled,
                  ),
                ),
              )
              : Icon(
                icon,
                size: _getIconSize(),
                color: isEnabled ? AppColors.primary : AppColors.disabled,
              ),
      style: IconButton.styleFrom(
        minimumSize: Size(_getButtonHeight(), _getButtonHeight()),
        padding: EdgeInsets.all(AppDimensions.paddingSmall),
      ),
    );
  }

  Widget _buildButtonChild() {
    if (isLoading) {
      return SizedBox(
        height: _getTextStyle().fontSize,
        width: _getTextStyle().fontSize,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.textOnPrimary),
        ),
      );
    }

    final widgets = <Widget>[];

    if (leadingIcon != null) {
      widgets.add(leadingIcon!);
      if (text != null) widgets.add(SizedBox(width: AppDimensions.spaceXS));
    }

    if (text != null) {
      widgets.add(
        Text(text!, style: _getTextStyle(), textAlign: TextAlign.center),
      );
    }

    if (trailingIcon != null) {
      if (text != null) widgets.add(SizedBox(width: AppDimensions.spaceXS));
      widgets.add(trailingIcon!);
    }

    return widgets.length == 1
        ? widgets.first
        : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        );
  }

  ButtonStyle _getPrimaryButtonStyle(bool isEnabled) {
    return ElevatedButton.styleFrom(
      backgroundColor: isEnabled ? AppColors.primary : AppColors.disabled,
      foregroundColor: AppColors.textOnPrimary,
      disabledBackgroundColor: AppColors.disabled,
      disabledForegroundColor: AppColors.disabledText,
      elevation: AppDimensions.elevationMedium,
      shadowColor: AppColors.shadow,
      minimumSize: Size(_getMinWidth(), _getButtonHeight()),
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(),
        vertical: AppDimensions.buttonPaddingVertical,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
    );
  }

  ButtonStyle _getSecondaryButtonStyle(bool isEnabled) {
    return OutlinedButton.styleFrom(
      foregroundColor: isEnabled ? AppColors.primary : AppColors.disabled,
      disabledForegroundColor: AppColors.disabledText,
      side: BorderSide(
        color: isEnabled ? AppColors.primary : AppColors.disabled,
        width: AppDimensions.borderWidthMedium,
      ),
      minimumSize: Size(_getMinWidth(), _getButtonHeight()),
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(),
        vertical: AppDimensions.buttonPaddingVertical,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
    );
  }

  ButtonStyle _getTextButtonStyle(bool isEnabled) {
    return TextButton.styleFrom(
      foregroundColor: isEnabled ? AppColors.primary : AppColors.disabled,
      disabledForegroundColor: AppColors.disabledText,
      minimumSize: Size(_getMinWidth(), _getButtonHeight()),
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(),
        vertical: AppDimensions.buttonPaddingVertical,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
    );
  }

  double _getButtonHeight() {
    return switch (size) {
      AppButtonSize.small => AppDimensions.buttonHeightSmall,
      AppButtonSize.medium => AppDimensions.buttonHeightMedium,
      AppButtonSize.large => AppDimensions.buttonHeightLarge,
    };
  }

  double _getHorizontalPadding() {
    return switch (size) {
      AppButtonSize.small => AppDimensions.buttonPaddingHorizontalSmall,
      AppButtonSize.medium => AppDimensions.buttonPaddingHorizontalMedium,
      AppButtonSize.large => AppDimensions.buttonPaddingHorizontalLarge,
    };
  }

  double _getMinWidth() {
    return switch (size) {
      AppButtonSize.small => 80,
      AppButtonSize.medium => 100,
      AppButtonSize.large => 120,
    };
  }

  double _getIconSize() {
    return switch (size) {
      AppButtonSize.small => AppDimensions.iconSmall,
      AppButtonSize.medium => AppDimensions.iconMedium,
      AppButtonSize.large => AppDimensions.iconLarge,
    };
  }

  TextStyle _getTextStyle() {
    return switch (size) {
      AppButtonSize.small => AppTextStyles.buttonSmall,
      AppButtonSize.medium => AppTextStyles.buttonMedium,
      AppButtonSize.large => AppTextStyles.buttonLarge,
    };
  }
}

// Button type enum
enum AppButtonType { primary, secondary, text, icon }

// Button size enum
enum AppButtonSize { small, medium, large }
