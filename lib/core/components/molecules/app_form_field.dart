import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'package:kikocode/core/components/atoms/atoms.dart';

/// A complete form field with label, input, validation, and helper text
/// 
/// This combines AppInput with additional form functionality.
/// 
/// Example:
/// ```dart
/// AppFormField(
///   label: 'Email',
///   hintText: 'Enter your email',
///   validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
///   onSaved: (value) => email = value,
/// )
/// ```
class AppFormField extends StatelessWidget {
  const AppFormField({
    super.key,
    required this.label,
    this.hintText,
    this.helperText,
    this.controller,
    this.initialValue,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.size = AppInputSize.medium,
    this.required = false,
  });

  final String label;
  final String? hintText;
  final String? helperText;
  final TextEditingController? controller;
  final String? initialValue;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final AppInputSize size;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTypography.labelBase.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            if (required)
              Text(
                ' *',
                style: AppTypography.labelBase.copyWith(
                  color: AppColors.error,
                ),
              ),
          ],
        ),
        AppSpacing.v2,
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          enabled: enabled,
          readOnly: readOnly,
          obscureText: obscureText,
          maxLines: obscureText ? 1 : maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          validator: validator,
          onChanged: onChanged,
          onSaved: onSaved,
          style: _getTextStyle(size),
          decoration: InputDecoration(
            hintText: hintText,
            helperText: helperText,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: _getIconSize(size))
                : null,
            suffixIcon: suffixIcon,
            contentPadding: _getContentPadding(size),
            border: _buildBorder(false),
            enabledBorder: _buildBorder(false),
            focusedBorder: _buildBorder(true),
            errorBorder: _buildBorder(false, error: true),
            focusedErrorBorder: _buildBorder(true, error: true),
            filled: true,
            fillColor: enabled
                ? AppColors.surface
                : AppColors.backgroundSecondary,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(bool focused, {bool error = false}) {
    return OutlineInputBorder(
      borderRadius: AppBorders.lg,
      borderSide: BorderSide(
        color: error
            ? AppColors.error
            : focused
                ? AppColors.primary
                : AppColors.border,
        width: focused ? 2 : 1,
      ),
    );
  }

  TextStyle _getTextStyle(AppInputSize size) {
    switch (size) {
      case AppInputSize.small:
        return AppTypography.bodySmall;
      case AppInputSize.medium:
        return AppTypography.bodyBase;
      case AppInputSize.large:
        return AppTypography.bodyLarge;
    }
  }

  EdgeInsetsGeometry _getContentPadding(AppInputSize size) {
    switch (size) {
      case AppInputSize.small:
        return AppSpacing.symmetric(
          horizontal: AppSpacing.spacing3,
          vertical: AppSpacing.spacing2,
        );
      case AppInputSize.medium:
        return AppSpacing.symmetric(
          horizontal: AppSpacing.spacing4,
          vertical: AppSpacing.spacing3,
        );
      case AppInputSize.large:
        return AppSpacing.symmetric(
          horizontal: AppSpacing.spacing4,
          vertical: AppSpacing.spacing4,
        );
    }
  }

  double _getIconSize(AppInputSize size) {
    switch (size) {
      case AppInputSize.small:
        return 18;
      case AppInputSize.medium:
        return 20;
      case AppInputSize.large:
        return 24;
    }
  }
}

/// A dropdown/select form field
/// 
/// Example:
/// ```dart
/// AppDropdownFormField<String>(
///   label: 'Country',
///   value: selectedCountry,
///   items: countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
///   onChanged: (value) => setState(() => selectedCountry = value),
/// )
/// ```
class AppDropdownFormField<T> extends StatelessWidget {
  const AppDropdownFormField({
    super.key,
    required this.label,
    this.hintText,
    this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.prefixIcon,
    this.enabled = true,
    this.required = false,
  });

  final String label;
  final String? hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final IconData? prefixIcon;
  final bool enabled;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTypography.labelBase.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            if (required)
              Text(
                ' *',
                style: AppTypography.labelBase.copyWith(
                  color: AppColors.error,
                ),
              ),
          ],
        ),
        AppSpacing.v2,
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: enabled ? onChanged : null,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            contentPadding: AppSpacing.symmetric(
              horizontal: AppSpacing.spacing4,
              vertical: AppSpacing.spacing3,
            ),
            border: OutlineInputBorder(
              borderRadius: AppBorders.lg,
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppBorders.lg,
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppBorders.lg,
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            filled: true,
            fillColor: enabled
                ? AppColors.surface
                : AppColors.backgroundSecondary,
          ),
        ),
      ],
    );
  }
}

/// A text area (multi-line) form field
/// 
/// Example:
/// ```dart
/// AppTextAreaFormField(
///   label: 'Message',
///   hintText: 'Enter your message',
///   minLines: 3,
///   maxLines: 6,
/// )
/// ```
class AppTextAreaFormField extends StatelessWidget {
  const AppTextAreaFormField({
    super.key,
    required this.label,
    this.hintText,
    this.helperText,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.minLines = 3,
    this.maxLines = 6,
    this.maxLength,
    this.enabled = true,
    this.required = false,
  });

  final String label;
  final String? hintText;
  final String? helperText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final bool enabled;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return AppFormField(
      label: label,
      hintText: hintText,
      helperText: helperText,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: enabled,
      required: required,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );
  }
}
