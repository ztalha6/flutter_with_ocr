import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_dimensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

// Reusable input field component with consistent styling
// Supports validation, different input types, and error states
class AppInputField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final String? errorText;
  final bool isRequired;
  final bool isEnabled;
  final bool obscureText;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final AutovalidateMode autovalidateMode;

  const AppInputField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.errorText,
    this.isRequired = false,
    this.isEnabled = true,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  // Email input field constructor
  const AppInputField.email({
    super.key,
    this.label = 'Email',
    this.hint = 'Enter your email',
    this.initialValue,
    this.errorText,
    this.isRequired = true,
    this.isEnabled = true,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.controller,
    this.focusNode,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : obscureText = false,
       readOnly = false,
       maxLines = 1,
       maxLength = null,
       keyboardType = TextInputType.emailAddress,
       textInputAction = TextInputAction.next,
       textCapitalization = TextCapitalization.none,
       inputFormatters = null,
       prefixIcon = const Icon(Icons.email_outlined),
       suffixIcon = null;

  // Password input field constructor
  const AppInputField.password({
    super.key,
    this.label = 'Password',
    this.hint = 'Enter your password',
    this.initialValue,
    this.errorText,
    this.isRequired = true,
    this.isEnabled = true,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.controller,
    this.focusNode,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : obscureText = true,
       readOnly = false,
       maxLines = 1,
       maxLength = null,
       keyboardType = TextInputType.visiblePassword,
       textInputAction = TextInputAction.done,
       textCapitalization = TextCapitalization.none,
       inputFormatters = null,
       prefixIcon = const Icon(Icons.lock_outline),
       suffixIcon = null;

  // Passport number input field constructor
  AppInputField.passportNumber({
    super.key,
    this.label = 'Passport Number',
    this.hint = 'e.g. AB1234567',
    this.initialValue,
    this.errorText,
    this.isRequired = true,
    this.isEnabled = true,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.controller,
    this.focusNode,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : obscureText = false,
       readOnly = false,
       maxLines = 1,
       maxLength = 9,
       keyboardType = TextInputType.text,
       textInputAction = TextInputAction.next,
       textCapitalization = TextCapitalization.characters,
       inputFormatters = [
         FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
       ],
       prefixIcon = const Icon(Icons.badge_outlined),
       suffixIcon = null;

  // Date input field constructor
  const AppInputField.date({
    super.key,
    this.label = 'Date',
    this.hint = 'Select date',
    this.initialValue,
    this.errorText,
    this.isRequired = true,
    this.isEnabled = true,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.controller,
    this.focusNode,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : obscureText = false,
       readOnly = true,
       maxLines = 1,
       maxLength = null,
       keyboardType = TextInputType.none,
       textInputAction = TextInputAction.next,
       textCapitalization = TextCapitalization.none,
       inputFormatters = null,
       prefixIcon = const Icon(Icons.calendar_today_outlined),
       suffixIcon = null;

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    _obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) _buildLabel(),
        SizedBox(height: AppDimensions.spaceXS),
        _buildInputField(),
        if (widget.errorText != null) _buildErrorText(),
      ],
    );
  }

  Widget _buildLabel() {
    return RichText(
      text: TextSpan(
        text: widget.label!,
        style: AppTextStyles.inputLabel,
        children: [
          if (widget.isRequired)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: AppColors.error),
            ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    final hasError = widget.errorText != null;

    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      enabled: widget.isEnabled,
      readOnly: widget.readOnly,
      obscureText: _obscureText,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      style: AppTextStyles.inputText.copyWith(
        color:
            widget.isEnabled ? AppColors.textPrimary : AppColors.disabledText,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: AppTextStyles.inputHint,
        prefixIcon:
            widget.prefixIcon != null ? _buildPrefixIcon(hasError) : null,
        suffixIcon: _buildSuffixIcon(hasError),
        filled: true,
        fillColor:
            widget.isEnabled ? AppColors.surface : AppColors.surfaceVariant,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.inputPaddingHorizontal,
          vertical: AppDimensions.inputPaddingVertical,
        ),
        border: _buildBorder(AppColors.border),
        enabledBorder: _buildBorder(AppColors.border),
        focusedBorder: _buildBorder(AppColors.borderFocus),
        errorBorder: _buildBorder(AppColors.borderError),
        focusedErrorBorder: _buildBorder(AppColors.borderError),
        disabledBorder: _buildBorder(AppColors.disabled),
        counterText: widget.maxLength != null ? null : '',
      ),
    );
  }

  Widget? _buildPrefixIcon(bool hasError) {
    if (widget.prefixIcon == null) return null;

    final color =
        hasError
            ? AppColors.error
            : widget.isEnabled
            ? AppColors.textSecondary
            : AppColors.disabled;

    return IconTheme(
      data: IconThemeData(color: color, size: AppDimensions.iconSmall),
      child: widget.prefixIcon!,
    );
  }

  Widget? _buildSuffixIcon(bool hasError) {
    final List<Widget> suffixWidgets = [];

    // Add password visibility toggle for password fields
    if (widget.obscureText) {
      suffixWidgets.add(
        IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            size: AppDimensions.iconSmall,
            color:
                widget.isEnabled ? AppColors.textSecondary : AppColors.disabled,
          ),
          onPressed:
              widget.isEnabled
                  ? () => setState(() => _obscureText = !_obscureText)
                  : null,
        ),
      );
    }

    // Add clear button for non-empty, enabled, non-readonly fields
    if (widget.isEnabled &&
        !widget.readOnly &&
        _controller.text.isNotEmpty &&
        !widget.obscureText) {
      suffixWidgets.add(
        IconButton(
          icon: Icon(
            Icons.clear,
            size: AppDimensions.iconSmall,
            color: AppColors.textSecondary,
          ),
          onPressed: () {
            _controller.clear();
            widget.onChanged?.call('');
          },
        ),
      );
    }

    // Add custom suffix icon
    if (widget.suffixIcon != null) {
      final color =
          hasError
              ? AppColors.error
              : widget.isEnabled
              ? AppColors.textSecondary
              : AppColors.disabled;

      suffixWidgets.add(
        IconTheme(
          data: IconThemeData(color: color, size: AppDimensions.iconSmall),
          child: widget.suffixIcon!,
        ),
      );
    }

    if (suffixWidgets.isEmpty) return null;

    return suffixWidgets.length == 1
        ? suffixWidgets.first
        : Row(mainAxisSize: MainAxisSize.min, children: suffixWidgets);
  }

  Widget _buildErrorText() {
    return Padding(
      padding: EdgeInsets.only(
        top: AppDimensions.spaceXXS,
        left: AppDimensions.inputPaddingHorizontal,
      ),
      child: Text(widget.errorText!, style: AppTextStyles.inputError),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      borderSide: BorderSide(
        color: color,
        width: AppDimensions.borderWidthMedium,
      ),
    );
  }
}
