import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

// Reusable card component with consistent styling
// Supports different variants and content types
class AppCard extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? subtitle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final Border? border;
  final VoidCallback? onTap;
  final bool isSelected;
  final Widget? leading;
  final Widget? trailing;

  const AppCard({
    super.key,
    this.child,
    this.title,
    this.subtitle,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.border,
    this.onTap,
    this.isSelected = false,
    this.leading,
    this.trailing,
  });

  // Passport data card constructor
  const AppCard.passportData({
    super.key,
    required this.child,
    this.title = 'Passport Information',
    this.onTap,
    this.isSelected = false,
  }) : subtitle = null,
       padding = const EdgeInsets.all(AppDimensions.cardPaddingLarge),
       margin = const EdgeInsets.all(AppDimensions.cardMargin),
       backgroundColor = AppColors.surface,
       elevation = AppDimensions.elevationMedium,
       borderRadius = const BorderRadius.all(
         Radius.circular(AppDimensions.radiusL),
       ),
       border = null,
       leading = null,
       trailing = null;

  // Simple content card constructor
  const AppCard.content({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.onTap,
    this.isSelected = false,
  }) : padding = const EdgeInsets.all(AppDimensions.cardPadding),
       margin = const EdgeInsets.all(AppDimensions.cardMargin),
       backgroundColor = AppColors.surface,
       elevation = AppDimensions.elevationLow,
       borderRadius = const BorderRadius.all(
         Radius.circular(AppDimensions.radiusM),
       ),
       border = null,
       leading = null,
       trailing = null;

  // Outlined card constructor
  const AppCard.outlined({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.onTap,
    this.isSelected = false,
  }) : padding = const EdgeInsets.all(AppDimensions.cardPadding),
       margin = const EdgeInsets.all(AppDimensions.cardMargin),
       backgroundColor = AppColors.surface,
       elevation = AppDimensions.elevationNone,
       borderRadius = const BorderRadius.all(
         Radius.circular(AppDimensions.radiusM),
       ),
       border = const Border.fromBorderSide(
         BorderSide(
           color: AppColors.border,
           width: AppDimensions.borderWidthThin,
         ),
       ),
       leading = null,
       trailing = null;

  // Error card constructor
  const AppCard.error({
    super.key,
    required this.child,
    this.title = 'Error',
    this.onTap,
  }) : subtitle = null,
       isSelected = false,
       padding = const EdgeInsets.all(AppDimensions.cardPadding),
       margin = const EdgeInsets.all(AppDimensions.cardMargin),
       backgroundColor = AppColors.errorLight,
       elevation = AppDimensions.elevationLow,
       borderRadius = const BorderRadius.all(
         Radius.circular(AppDimensions.radiusM),
       ),
       border = const Border.fromBorderSide(
         BorderSide(
           color: AppColors.error,
           width: AppDimensions.borderWidthThin,
         ),
       ),
       leading = const Icon(Icons.error_outline, color: AppColors.error),
       trailing = null;

  // Success card constructor
  const AppCard.success({
    super.key,
    required this.child,
    this.title = 'Success',
    this.onTap,
  }) : subtitle = null,
       isSelected = false,
       padding = const EdgeInsets.all(AppDimensions.cardPadding),
       margin = const EdgeInsets.all(AppDimensions.cardMargin),
       backgroundColor = AppColors.successLight,
       elevation = AppDimensions.elevationLow,
       borderRadius = const BorderRadius.all(
         Radius.circular(AppDimensions.radiusM),
       ),
       border = const Border.fromBorderSide(
         BorderSide(
           color: AppColors.success,
           width: AppDimensions.borderWidthThin,
         ),
       ),
       leading = const Icon(
         Icons.check_circle_outline,
         color: AppColors.success,
       ),
       trailing = null;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppDimensions.radiusM),
        border:
            isSelected
                ? Border.all(
                  color: AppColors.primary,
                  width: AppDimensions.borderWidthMedium,
                )
                : border,
        boxShadow:
            elevation != null && elevation! > 0
                ? [
                  BoxShadow(
                    color: AppColors.shadow,
                    offset: const Offset(0, 2),
                    blurRadius: elevation!,
                    spreadRadius: 0,
                  ),
                ]
                : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius:
              borderRadius ?? BorderRadius.circular(AppDimensions.radiusM),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppDimensions.cardPadding),
            child: _buildContent(),
          ),
        ),
      ),
    );

    return card;
  }

  Widget _buildContent() {
    final hasHeader =
        title != null ||
        subtitle != null ||
        leading != null ||
        trailing != null;

    if (!hasHeader && child != null) {
      return child!;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasHeader) _buildHeader(),
        if (hasHeader && child != null) SizedBox(height: AppDimensions.spaceM),
        if (child != null) child!,
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        if (leading != null) ...[
          leading!,
          SizedBox(width: AppDimensions.spaceS),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) Text(title!, style: AppTextStyles.headline6),
              if (subtitle != null) ...[
                SizedBox(height: AppDimensions.spaceXXS),
                Text(subtitle!, style: AppTextStyles.bodySmall),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          SizedBox(width: AppDimensions.spaceS),
          trailing!,
        ],
      ],
    );
  }
}

// Specialized passport field card for displaying individual passport data fields
class PassportFieldCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final bool isHighConfidence;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;

  const PassportFieldCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.isHighConfidence = true,
    this.onTap,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.all(AppDimensions.paddingMedium),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: AppDimensions.iconSmall,
              color: AppColors.textSecondary,
            ),
            SizedBox(width: AppDimensions.spaceS),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(label, style: AppTextStyles.passportDataLabel),
                    SizedBox(width: AppDimensions.spaceXXS),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                            isHighConfidence
                                ? AppColors.confidenceHigh
                                : AppColors.confidenceMedium,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppDimensions.spaceXXS),
                Text(
                  value.isEmpty ? 'Not detected' : value,
                  style:
                      value.isEmpty
                          ? AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textTertiary,
                            fontStyle: FontStyle.italic,
                          )
                          : AppTextStyles.passportDataValue,
                ),
              ],
            ),
          ),
          if (onEdit != null) ...[
            SizedBox(width: AppDimensions.spaceS),
            IconButton(
              icon: Icon(
                Icons.edit_outlined,
                size: AppDimensions.iconSmall,
                color: AppColors.textSecondary,
              ),
              onPressed: onEdit,
            ),
          ],
        ],
      ),
    );
  }
}

// MRZ display card for showing raw MRZ text
class MRZCard extends StatelessWidget {
  final String line1;
  final String line2;
  final double confidence;
  final bool isExpanded;
  final VoidCallback? onToggleExpanded;

  const MRZCard({
    super.key,
    required this.line1,
    required this.line2,
    required this.confidence,
    this.isExpanded = false,
    this.onToggleExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      title: 'Machine Readable Zone (MRZ)',
      padding: EdgeInsets.all(AppDimensions.cardPadding),
      margin: EdgeInsets.all(AppDimensions.cardMargin),
      backgroundColor: AppColors.surface,
      elevation: AppDimensions.elevationNone,
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radiusM)),
      border: Border.fromBorderSide(
        BorderSide(
          color: AppColors.border,
          width: AppDimensions.borderWidthThin,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSmall,
              vertical: AppDimensions.paddingTiny,
            ),
            decoration: BoxDecoration(
              color: _getConfidenceColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
            ),
            child: Text(
              '${(confidence * 100).toStringAsFixed(0)}%',
              style: AppTextStyles.confidenceScore.copyWith(
                color: _getConfidenceColor(),
              ),
            ),
          ),
          if (onToggleExpanded != null) ...[
            SizedBox(width: AppDimensions.spaceXS),
            IconButton(
              icon: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                size: AppDimensions.iconSmall,
              ),
              onPressed: onToggleExpanded,
            ),
          ],
        ],
      ),
      child:
          isExpanded
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(AppDimensions.paddingSmall),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusXS,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Line 1:', style: AppTextStyles.bodySmall),
                        SizedBox(height: AppDimensions.spaceXXS),
                        Text(line1, style: AppTextStyles.mrzText),
                        SizedBox(height: AppDimensions.spaceS),
                        Text('Line 2:', style: AppTextStyles.bodySmall),
                        SizedBox(height: AppDimensions.spaceXXS),
                        Text(line2, style: AppTextStyles.mrzText),
                      ],
                    ),
                  ),
                ],
              )
              : Text(
                'Tap to view raw MRZ data',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
    );
  }

  Color _getConfidenceColor() {
    if (confidence >= 0.8) return AppColors.confidenceHigh;
    if (confidence >= 0.6) return AppColors.confidenceMedium;
    return AppColors.confidenceLow;
  }
}
