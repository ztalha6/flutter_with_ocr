import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../../core/error/failures.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import '../widgets/app_error_widget.dart';
import '../widgets/app_input_field.dart';
import '../widgets/app_loading_indicator.dart';

// Widget catalog page for testing and showcasing all reusable UI components
// This page demonstrates different states and variants of each component
class WidgetCatalogPage extends StatefulWidget {
  const WidgetCatalogPage({super.key});

  @override
  State<WidgetCatalogPage> createState() => _WidgetCatalogPageState();
}

class _WidgetCatalogPageState extends State<WidgetCatalogPage> {
  bool _isLoading = false;
  bool _mrzExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Widget Catalog'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: AppDimensions.appBarElevation,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Colors', _buildColorsSection()),
            _buildSection('Typography', _buildTypographySection()),
            _buildSection('Buttons', _buildButtonsSection()),
            _buildSection('Input Fields', _buildInputFieldsSection()),
            _buildSection('Cards', _buildCardsSection()),
            _buildSection(
              'Loading Indicators',
              _buildLoadingIndicatorsSection(),
            ),
            _buildSection('Error Widgets', _buildErrorWidgetsSection()),
            _buildSection(
              'Passport Components',
              _buildPassportComponentsSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppDimensions.spaceL),
          child: Text(title, style: AppTextStyles.headline4),
        ),
        content,
        SizedBox(height: AppDimensions.spaceXL),
      ],
    );
  }

  Widget _buildColorsSection() {
    final colors = [
      ('Primary', AppColors.primary),
      ('Secondary', AppColors.secondary),
      ('Accent', AppColors.accent),
      ('Success', AppColors.success),
      ('Error', AppColors.error),
      ('Warning', AppColors.warning),
      ('Info', AppColors.info),
    ];

    return Wrap(
      spacing: AppDimensions.spaceM,
      runSpacing: AppDimensions.spaceM,
      children:
          colors.map((colorInfo) {
            return Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: colorInfo.$2,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                    border: Border.all(color: AppColors.border),
                  ),
                ),
                SizedBox(height: AppDimensions.spaceXS),
                Text(colorInfo.$1, style: AppTextStyles.bodySmall),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildTypographySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Headline 1', style: AppTextStyles.headline1),
        SizedBox(height: AppDimensions.spaceS),
        Text('Headline 2', style: AppTextStyles.headline2),
        SizedBox(height: AppDimensions.spaceS),
        Text('Headline 3', style: AppTextStyles.headline3),
        SizedBox(height: AppDimensions.spaceS),
        Text('Headline 4', style: AppTextStyles.headline4),
        SizedBox(height: AppDimensions.spaceS),
        Text('Body Large', style: AppTextStyles.bodyLarge),
        SizedBox(height: AppDimensions.spaceS),
        Text('Body Medium', style: AppTextStyles.bodyMedium),
        SizedBox(height: AppDimensions.spaceS),
        Text('Body Small', style: AppTextStyles.bodySmall),
        SizedBox(height: AppDimensions.spaceS),
        Text('Label Large', style: AppTextStyles.labelLarge),
        SizedBox(height: AppDimensions.spaceS),
        Text('Button Text', style: AppTextStyles.buttonMedium),
      ],
    );
  }

  Widget _buildButtonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Primary buttons
        Text('Primary Buttons', style: AppTextStyles.headline6),
        SizedBox(height: AppDimensions.spaceM),
        Wrap(
          spacing: AppDimensions.spaceM,
          runSpacing: AppDimensions.spaceM,
          children: [
            AppButton.primary(
              text: 'Large',
              onPressed: _showSnackBar,
              size: AppButtonSize.large,
            ),
            AppButton.primary(
              text: 'Medium',
              onPressed: _showSnackBar,
              size: AppButtonSize.medium,
            ),
            AppButton.primary(
              text: 'Small',
              onPressed: _showSnackBar,
              size: AppButtonSize.small,
            ),
            AppButton.primary(
              text: 'Loading',
              onPressed: null,
              isLoading: true,
            ),
            AppButton.primary(text: 'Disabled', onPressed: null),
          ],
        ),

        SizedBox(height: AppDimensions.spaceL),

        // Secondary buttons
        Text('Secondary Buttons', style: AppTextStyles.headline6),
        SizedBox(height: AppDimensions.spaceM),
        Wrap(
          spacing: AppDimensions.spaceM,
          runSpacing: AppDimensions.spaceM,
          children: [
            AppButton.secondary(text: 'Secondary', onPressed: _showSnackBar),
            AppButton.secondary(
              text: 'With Icon',
              onPressed: _showSnackBar,
              leadingIcon: const Icon(Icons.add, size: 20),
            ),
            AppButton.secondary(text: 'Disabled', onPressed: null),
          ],
        ),

        SizedBox(height: AppDimensions.spaceL),

        // Icon buttons
        Text('Icon Buttons', style: AppTextStyles.headline6),
        SizedBox(height: AppDimensions.spaceM),
        Wrap(
          spacing: AppDimensions.spaceM,
          runSpacing: AppDimensions.spaceM,
          children: [
            AppButton.icon(
              icon: Icons.camera_alt,
              onPressed: _showSnackBar,
              size: AppButtonSize.large,
            ),
            AppButton.icon(
              icon: Icons.edit,
              onPressed: _showSnackBar,
              size: AppButtonSize.medium,
            ),
            AppButton.icon(
              icon: Icons.delete,
              onPressed: _showSnackBar,
              size: AppButtonSize.small,
            ),
            AppButton.icon(
              icon: Icons.refresh,
              onPressed: null,
              isLoading: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputFieldsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppInputField(
          label: 'Full Name',
          hint: 'Enter your full name',
          isRequired: true,
        ),
        SizedBox(height: AppDimensions.spaceM),

        AppInputField.passportNumber(),
        SizedBox(height: AppDimensions.spaceM),

        const AppInputField.email(),
        SizedBox(height: AppDimensions.spaceM),

        const AppInputField.password(),
        SizedBox(height: AppDimensions.spaceM),

        const AppInputField.date(label: 'Date of Birth'),
        SizedBox(height: AppDimensions.spaceM),

        const AppInputField(
          label: 'Comments',
          hint: 'Enter additional comments',
          maxLines: 3,
        ),
        SizedBox(height: AppDimensions.spaceM),

        const AppInputField(
          label: 'Disabled Field',
          hint: 'This field is disabled',
          isEnabled: false,
          initialValue: 'Cannot edit this',
        ),
        SizedBox(height: AppDimensions.spaceM),

        const AppInputField(
          label: 'Error Field',
          hint: 'This field has an error',
          errorText: 'This field is required',
        ),
      ],
    );
  }

  Widget _buildCardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard.content(
          title: 'Simple Card',
          subtitle: 'This is a subtitle',
          child: Text(
            'This is the content of a simple card with title and subtitle.',
            style: AppTextStyles.bodyMedium,
          ),
        ),

        AppCard.outlined(
          title: 'Outlined Card',
          child: Text(
            'This is an outlined card without elevation.',
            style: AppTextStyles.bodyMedium,
          ),
        ),

        AppCard.passportData(
          child: Text(
            'This is a passport data card with larger padding.',
            style: AppTextStyles.bodyMedium,
          ),
        ),

        AppCard.error(
          child: Text(
            'This is an error card with error styling.',
            style: AppTextStyles.bodyMedium,
          ),
        ),

        AppCard.success(
          child: Text(
            'This is a success card with success styling.',
            style: AppTextStyles.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicatorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Circular Indicators', style: AppTextStyles.headline6),
        SizedBox(height: AppDimensions.spaceM),

        const Row(
          children: [
            AppLoadingIndicator.small(),
            SizedBox(width: 32),
            AppLoadingIndicator(),
            SizedBox(width: 32),
            AppLoadingIndicator.large(),
          ],
        ),

        SizedBox(height: AppDimensions.spaceL),

        Text('With Text', style: AppTextStyles.headline6),
        SizedBox(height: AppDimensions.spaceM),

        const AppLoadingIndicator.ocrProcessing(),

        SizedBox(height: AppDimensions.spaceL),

        Text('Different Types', style: AppTextStyles.headline6),
        SizedBox(height: AppDimensions.spaceM),

        const Column(
          children: [
            AppLoadingIndicator(
              text: 'Linear Progress',
              type: AppLoadingType.linear,
            ),
            SizedBox(height: 32),
            AppLoadingIndicator(
              text: 'Dots Animation',
              type: AppLoadingType.dots,
            ),
          ],
        ),

        SizedBox(height: AppDimensions.spaceL),

        Text('Inline Loading', style: AppTextStyles.headline6),
        SizedBox(height: AppDimensions.spaceM),

        Row(
          children: [
            AppButton(
              text: _isLoading ? null : 'Start Loading',
              onPressed: _isLoading ? null : _toggleLoading,
              isLoading: _isLoading,
            ),
            SizedBox(width: AppDimensions.spaceM),
            if (_isLoading)
              AppButton.secondary(
                text: 'Stop Loading',
                onPressed: _toggleLoading,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildErrorWidgetsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Different Error Types', style: AppTextStyles.headline6),
        SizedBox(height: AppDimensions.spaceM),

        AppErrorWidget.ocrError(
          onRetry: _showSnackBar,
          onCancel: _showSnackBar,
        ),

        SizedBox(height: AppDimensions.spaceM),

        AppErrorWidget.cameraError(onRetry: _showSnackBar),

        SizedBox(height: AppDimensions.spaceM),

        AppErrorWidget.validationError(
          message:
              'Invalid passport number format. Please check and try again.',
          onRetry: _showSnackBar,
        ),

        SizedBox(height: AppDimensions.spaceM),

        const InlineErrorWidget(message: 'This is an inline error message'),

        SizedBox(height: AppDimensions.spaceM),

        const EmptyStateWidget.noPassportScanned(),

        SizedBox(height: AppDimensions.spaceM),

        Text('From Failure', style: AppTextStyles.headline6),
        SizedBox(height: AppDimensions.spaceM),

        AppErrorWidget.fromFailure(
          failure: const OCRFailure.processingFailed(),
          onRetry: _showSnackBar,
        ),
      ],
    );
  }

  Widget _buildPassportComponentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Passport Field Cards', style: AppTextStyles.headline6),
        SizedBox(height: AppDimensions.spaceM),

        const PassportFieldCard(
          label: 'Full Name',
          value: 'AHMED ALI',
          icon: Icons.person_outline,
          isHighConfidence: true,
        ),

        SizedBox(height: AppDimensions.spaceS),

        const PassportFieldCard(
          label: 'Passport Number',
          value: 'AB1234567',
          icon: Icons.badge_outlined,
          isHighConfidence: true,
        ),

        SizedBox(height: AppDimensions.spaceS),

        const PassportFieldCard(
          label: 'Date of Birth',
          value: '',
          icon: Icons.calendar_today_outlined,
          isHighConfidence: false,
        ),

        SizedBox(height: AppDimensions.spaceL),

        Text('MRZ Card', style: AppTextStyles.headline6),
        SizedBox(height: AppDimensions.spaceM),

        MRZCard(
          line1: 'P<PAKAHMED<<ALI<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<',
          line2: 'AB12345671PAK9001011M3012319<<<<<<<<<<<<<<<6',
          confidence: 0.95,
          isExpanded: _mrzExpanded,
          onToggleExpanded: () => setState(() => _mrzExpanded = !_mrzExpanded),
        ),
      ],
    );
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Button pressed!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _toggleLoading() {
    setState(() => _isLoading = !_isLoading);

    if (_isLoading) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      });
    }
  }
}
