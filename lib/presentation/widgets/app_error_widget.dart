import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../../core/error/failures.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'app_button.dart';

// Reusable error widget component with consistent styling
// Supports different error types and retry functionality
class AppErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final VoidCallback? onRetry;
  final String? retryText;
  final VoidCallback? onCancel;
  final String? cancelText;
  final Color? backgroundColor;
  final bool isFullScreen;

  const AppErrorWidget({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.onRetry,
    this.retryText,
    this.onCancel,
    this.cancelText,
    this.backgroundColor,
    this.isFullScreen = false,
  });

  // OCR error constructor
  const AppErrorWidget.ocrError({
    super.key,
    this.message =
        'Failed to process the passport image. Please try again with better lighting.',
    this.onRetry,
    this.onCancel,
    this.isFullScreen = false,
  }) : title = 'OCR Processing Failed',
       icon = Icons.document_scanner_outlined,
       retryText = 'Retry Scan',
       cancelText = 'Cancel',
       backgroundColor = null;

  // Camera error constructor
  const AppErrorWidget.cameraError({
    super.key,
    this.message =
        'Unable to access camera. Please check permissions and try again.',
    this.onRetry,
    this.onCancel,
    this.isFullScreen = false,
  }) : title = 'Camera Error',
       icon = Icons.camera_alt_outlined,
       retryText = 'Try Again',
       cancelText = 'Cancel',
       backgroundColor = null;

  // Validation error constructor
  const AppErrorWidget.validationError({
    super.key,
    this.message =
        'The passport data could not be validated. Please check the information.',
    this.onRetry,
    this.onCancel,
    this.isFullScreen = false,
  }) : title = 'Validation Error',
       icon = Icons.warning_amber_outlined,
       retryText = 'Edit Data',
       cancelText = 'Retry Scan',
       backgroundColor = null;

  // Permission error constructor
  const AppErrorWidget.permissionError({
    super.key,
    this.message =
        'Camera permission is required to scan passports. Please grant permission in settings.',
    this.onRetry,
    this.onCancel,
    this.isFullScreen = false,
  }) : title = 'Permission Required',
       icon = Icons.security_outlined,
       retryText = 'Grant Permission',
       cancelText = 'Cancel',
       backgroundColor = null;

  // Generic error constructor
  const AppErrorWidget.generic({
    super.key,
    this.message = 'An unexpected error occurred. Please try again.',
    this.onRetry,
    this.onCancel,
    this.isFullScreen = false,
  }) : title = 'Something went wrong',
       icon = Icons.error_outline,
       retryText = 'Try Again',
       cancelText = 'Cancel',
       backgroundColor = null;

  // Failure-based constructor
  factory AppErrorWidget.fromFailure({
    Key? key,
    required Failure failure,
    VoidCallback? onRetry,
    VoidCallback? onCancel,
    bool isFullScreen = false,
  }) {
    switch (failure.runtimeType) {
      case OCRFailure _:
        return AppErrorWidget.ocrError(
          key: key,
          message: failure.message,
          onRetry: onRetry,
          onCancel: onCancel,
          isFullScreen: isFullScreen,
        );
      case CameraFailure _:
        return AppErrorWidget.cameraError(
          key: key,
          message: failure.message,
          onRetry: onRetry,
          onCancel: onCancel,
          isFullScreen: isFullScreen,
        );
      case ValidationFailure _:
        return AppErrorWidget.validationError(
          key: key,
          message: failure.message,
          onRetry: onRetry,
          onCancel: onCancel,
          isFullScreen: isFullScreen,
        );
      case PermissionFailure _:
        return AppErrorWidget.permissionError(
          key: key,
          message: failure.message,
          onRetry: onRetry,
          onCancel: onCancel,
          isFullScreen: isFullScreen,
        );
      default:
        return AppErrorWidget.generic(
          key: key,
          message: failure.message,
          onRetry: onRetry,
          onCancel: onCancel,
          isFullScreen: isFullScreen,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isFullScreen) {
      return _buildFullScreenError();
    }

    return _buildInlineError();
  }

  Widget _buildFullScreenError() {
    return Container(
      color: backgroundColor ?? AppColors.background,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppDimensions.paddingLarge),
          child: _buildErrorContent(),
        ),
      ),
    );
  }

  Widget _buildInlineError() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.errorLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.3),
          width: AppDimensions.borderWidthThin,
        ),
      ),
      child: _buildErrorContent(),
    );
  }

  Widget _buildErrorContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) _buildIcon(),
        _buildTitle(),
        SizedBox(height: AppDimensions.spaceS),
        _buildMessage(),
        if (onRetry != null || onCancel != null) ...[
          SizedBox(height: AppDimensions.spaceL),
          _buildActions(),
        ],
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
      width: AppDimensions.iconXLarge,
      height: AppDimensions.iconXLarge,
      margin: EdgeInsets.only(bottom: AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: AppDimensions.iconLarge, color: AppColors.error),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: AppTextStyles.headline5.copyWith(color: AppColors.error),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMessage() {
    return Text(
      message,
      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildActions() {
    final actions = <Widget>[];

    if (onCancel != null) {
      actions.add(
        AppButton.secondary(
          text: cancelText ?? 'Cancel',
          onPressed: onCancel,
          size: AppButtonSize.medium,
        ),
      );
    }

    if (onRetry != null) {
      actions.add(
        AppButton.primary(
          text: retryText ?? 'Retry',
          onPressed: onRetry,
          size: AppButtonSize.medium,
        ),
      );
    }

    if (actions.isEmpty) return const SizedBox.shrink();

    if (actions.length == 1) {
      return actions.first;
    }

    return Column(
      children: [
        actions.last, // Primary action (retry) on top
        SizedBox(height: AppDimensions.spaceS),
        actions.first, // Secondary action (cancel) below
      ],
    );
  }
}

// Small error widget for inline use
class InlineErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData? icon;

  const InlineErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.errorLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.3),
          width: AppDimensions.borderWidthThin,
        ),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppDimensions.iconSmall, color: AppColors.error),
            SizedBox(width: AppDimensions.spaceS),
          ],
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(width: AppDimensions.spaceS),
            TextButton(
              onPressed: onRetry,
              child: Text(
                'Retry',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Empty state widget for when there's no data
class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionText;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.onAction,
    this.actionText,
  });

  // No passport scanned constructor
  const EmptyStateWidget.noPassportScanned({super.key, this.onAction})
    : title = 'Start Scanning',
      message =
          'Scan your Pakistani passport to extract information automatically',
      icon = Icons.document_scanner_outlined,
      actionText = 'Scan Passport';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimensions.paddingXLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppDimensions.iconXLarge * 1.5,
            height: AppDimensions.iconXLarge * 1.5,
            margin: EdgeInsets.only(bottom: AppDimensions.spaceL),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: AppDimensions.iconXLarge,
              color: AppColors.primary,
            ),
          ),
          Text(
            title,
            style: AppTextStyles.headline4,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimensions.spaceS),
          Text(
            message,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          if (onAction != null) ...[
            SizedBox(height: AppDimensions.spaceL),
            AppButton.primary(
              text: actionText ?? 'Get Started',
              onPressed: onAction,
              size: AppButtonSize.large,
            ),
          ],
        ],
      ),
    );
  }
}
