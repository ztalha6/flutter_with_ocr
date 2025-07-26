import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

// Reusable loading indicator component with consistent styling
// Supports different sizes and variants with optional text
class AppLoadingIndicator extends StatelessWidget {
  final String? text;
  final AppLoadingSize size;
  final AppLoadingType type;
  final Color? color;
  final double? strokeWidth;

  const AppLoadingIndicator({
    super.key,
    this.text,
    this.size = AppLoadingSize.medium,
    this.type = AppLoadingType.circular,
    this.color,
    this.strokeWidth,
  });

  // Small loading indicator constructor
  const AppLoadingIndicator.small({
    super.key,
    this.text,
    this.type = AppLoadingType.circular,
    this.color,
  }) : size = AppLoadingSize.small,
       strokeWidth = 2.0;

  // Large loading indicator constructor
  const AppLoadingIndicator.large({
    super.key,
    this.text,
    this.type = AppLoadingType.circular,
    this.color,
  }) : size = AppLoadingSize.large,
       strokeWidth = 4.0;

  // OCR processing indicator constructor
  const AppLoadingIndicator.ocrProcessing({
    super.key,
    this.text = 'Processing passport...',
    this.color = AppColors.primary,
  }) : size = AppLoadingSize.large,
       type = AppLoadingType.circular,
       strokeWidth = 3.0;

  // Camera initializing indicator constructor
  const AppLoadingIndicator.cameraInitializing({
    super.key,
    this.text = 'Initializing camera...',
    this.color = AppColors.primary,
  }) : size = AppLoadingSize.medium,
       type = AppLoadingType.circular,
       strokeWidth = 2.5;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIndicator(),
        if (text != null) ...[
          SizedBox(height: AppDimensions.spaceM),
          _buildText(),
        ],
      ],
    );
  }

  Widget _buildIndicator() {
    switch (type) {
      case AppLoadingType.circular:
        return _buildCircularIndicator();
      case AppLoadingType.linear:
        return _buildLinearIndicator();
      case AppLoadingType.dots:
        return _buildDotsIndicator();
    }
  }

  Widget _buildCircularIndicator() {
    return SizedBox(
      width: _getIndicatorSize(),
      height: _getIndicatorSize(),
      child: CircularProgressIndicator(
        color: color ?? AppColors.primary,
        strokeWidth: strokeWidth ?? _getDefaultStrokeWidth(),
        backgroundColor: AppColors.border.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildLinearIndicator() {
    return SizedBox(
      width: _getLinearWidth(),
      height: AppDimensions.progressIndicatorHeight,
      child: LinearProgressIndicator(
        color: color ?? AppColors.primary,
        backgroundColor: AppColors.border.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildDotsIndicator() {
    return SizedBox(
      width: _getDotsWidth(),
      height: _getDotSize(),
      child: _DotsIndicator(
        color: color ?? AppColors.primary,
        size: _getDotSize(),
      ),
    );
  }

  Widget _buildText() {
    return Text(text!, style: _getTextStyle(), textAlign: TextAlign.center);
  }

  double _getIndicatorSize() {
    return switch (size) {
      AppLoadingSize.small => AppDimensions.loadingIndicatorSizeSmall,
      AppLoadingSize.medium => AppDimensions.loadingIndicatorSize,
      AppLoadingSize.large => AppDimensions.loadingIndicatorSizeLarge,
    };
  }

  double _getDefaultStrokeWidth() {
    return switch (size) {
      AppLoadingSize.small => 2.0,
      AppLoadingSize.medium => 3.0,
      AppLoadingSize.large => 4.0,
    };
  }

  double _getLinearWidth() {
    return switch (size) {
      AppLoadingSize.small => 100,
      AppLoadingSize.medium => 150,
      AppLoadingSize.large => 200,
    };
  }

  double _getDotsWidth() {
    return switch (size) {
      AppLoadingSize.small => 60,
      AppLoadingSize.medium => 80,
      AppLoadingSize.large => 100,
    };
  }

  double _getDotSize() {
    return switch (size) {
      AppLoadingSize.small => 8,
      AppLoadingSize.medium => 12,
      AppLoadingSize.large => 16,
    };
  }

  TextStyle _getTextStyle() {
    return switch (size) {
      AppLoadingSize.small => AppTextStyles.bodySmall,
      AppLoadingSize.medium => AppTextStyles.bodyMedium,
      AppLoadingSize.large => AppTextStyles.bodyLarge,
    };
  }
}

// Animated dots loading indicator
class _DotsIndicator extends StatefulWidget {
  final Color color;
  final double size;

  const _DotsIndicator({required this.color, required this.size});

  @override
  State<_DotsIndicator> createState() => _DotsIndicatorState();
}

class _DotsIndicatorState extends State<_DotsIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );

    _animations =
        _controllers
            .map(
              (controller) => Tween<double>(begin: 0.4, end: 1.0).animate(
                CurvedAnimation(parent: controller, curve: Curves.easeInOut),
              ),
            )
            .toList();

    _startAnimations();
  }

  void _startAnimations() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withValues(alpha: _animations[index].value),
              ),
            );
          },
        );
      }),
    );
  }
}

// Full screen loading overlay
class AppLoadingOverlay extends StatelessWidget {
  final String? text;
  final bool isVisible;
  final Color? backgroundColor;
  final AppLoadingSize size;

  const AppLoadingOverlay({
    super.key,
    this.text,
    this.isVisible = true,
    this.backgroundColor,
    this.size = AppLoadingSize.large,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Container(
      color: backgroundColor ?? AppColors.cameraOverlay,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(AppDimensions.paddingLarge),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                offset: const Offset(0, 4),
                blurRadius: 16,
                spreadRadius: 0,
              ),
            ],
          ),
          child: AppLoadingIndicator(text: text, size: size),
        ),
      ),
    );
  }
}

// Inline loading indicator for buttons
class InlineLoadingIndicator extends StatelessWidget {
  final AppLoadingSize size;
  final Color? color;

  const InlineLoadingIndicator({
    super.key,
    this.size = AppLoadingSize.small,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final indicatorSize = switch (size) {
      AppLoadingSize.small => 16.0,
      AppLoadingSize.medium => 20.0,
      AppLoadingSize.large => 24.0,
    };

    return SizedBox(
      width: indicatorSize,
      height: indicatorSize,
      child: CircularProgressIndicator(
        color: color ?? AppColors.textOnPrimary,
        strokeWidth: 2,
      ),
    );
  }
}

// Loading size enum
enum AppLoadingSize { small, medium, large }

// Loading type enum
enum AppLoadingType { circular, linear, dots }
