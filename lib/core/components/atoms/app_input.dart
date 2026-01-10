import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kikocode/core/design_system/design_system.dart';

/// Input field size types
enum AppInputSize {
  small,
  medium,
  large,
}

/// A reusable text input component with consistent styling
/// 
/// Supports various input types, validation, and customization options.
/// 
/// Example:
/// ```dart
/// AppInput(
///   label: 'Email',
///   hintText: 'Enter your email',
///   prefixIcon: Icons.email,
///   keyboardType: TextInputType.emailAddress,
///   onChanged: (value) => print(value),
/// )
/// ```
class AppInput extends StatefulWidget {
  const AppInput({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.size = AppInputSize.medium,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final AppInputSize size;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Show error text as label when there's an error, otherwise show label
        if (hasError || widget.label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 20), // 20px left padding to match Figma (42px - 22px field margin)
            child: Text(
              hasError ? widget.errorText! : widget.label!,
              style: AppTypography.caption2.copyWith( // Use Caption 2 (11px Nunito Sans Regular)
                color: hasError ? AppColors.accentRed : AppColors.textSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          AppSpacing.v2,
        ],
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          obscureText: _obscureText,
          maxLines: _obscureText ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          autofocus: widget.autofocus,
          autocorrect: widget.autocorrect,
          enableSuggestions: widget.enableSuggestions,
          style: _getTextStyle(widget.size),
          decoration: InputDecoration(
            hintText: widget.hintText,
            helperText: widget.helperText,
            // Don't show errorText below the field - we show it as label above
            errorText: null,
            errorStyle: const TextStyle(height: 0), // Hide error text space
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, size: _getIconSize(widget.size))
                : null,
            suffixIcon: _buildSuffixIcon(),
            contentPadding: _getContentPadding(widget.size),
            border: _buildBorder(false, error: hasError),
            enabledBorder: _buildBorder(false, error: hasError),
            focusedBorder: _buildBorder(true, error: hasError),
            errorBorder: _buildBorder(false, error: true),
            focusedErrorBorder: _buildBorder(true, error: true),
            filled: true,
            fillColor: widget.enabled
                ? AppColors.surfaceHighest // Light beige (#FBF7EF) from Figma
                : AppColors.backgroundSecondary,
            hintStyle: AppTypography.body.copyWith(
              color: hasError 
                  ? AppColors.accentRed.withOpacity(0.4) // Accent/Red at 40% opacity for error state
                  : AppColors.textTertiary, // Gray (#BFBFBF) for default placeholder
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          size: _getIconSize(widget.size),
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return widget.suffixIcon;
  }

  OutlineInputBorder _buildBorder(bool focused, {bool error = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25), // KIKO rounded style: 25px from Figma
      borderSide: BorderSide(
        color: error
            ? AppColors.accentRed // Accent/Red (#FF383C) from Figma for error state
            : focused
                ? AppColors.secondary // Mint green (#9ED9C6) for focused/selected state
                : AppColors.surfaceLow, // Beige (#EFDFBD) for default state
        width: 2, // Always 2px border as per Figma design
      ),
    );
  }

  TextStyle _getTextStyle(AppInputSize size) {
    switch (size) {
      case AppInputSize.small:
        return AppTypography.bodySmall.copyWith(
          color: AppColors.textPrimary,
        );
      case AppInputSize.medium:
        return AppTypography.body.copyWith( // Use Figma's App/Body style (17px)
          color: AppColors.textPrimary,
        );
      case AppInputSize.large:
        return AppTypography.bodyLarge.copyWith(
          color: AppColors.textPrimary,
        );
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
