import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';

/// Button variant types
enum AppButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  danger,
}

/// Button size types
enum AppButtonSize {
  small,
  medium,
  large,
}

/// A reusable button component with consistent styling
/// 
/// Supports multiple variants (primary, secondary, outline, ghost, danger)
/// and sizes (small, medium, large).
/// 
/// Example:
/// ```dart
/// AppButton(
///   label: 'Submit',
///   onPressed: () => print('Pressed'),
///   variant: AppButtonVariant.primary,
///   size: AppButtonSize.medium,
/// )
/// ```
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.fullWidth = false,
    this.loading = false,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final IconPosition iconPosition;
  final bool fullWidth;
  final bool loading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled && !loading;
    final effectiveOnPressed = isEnabled ? onPressed : null;

    final buttonStyle = _getButtonStyle(variant, size);
    final textStyle = _getTextStyle(size);
    final iconSize = _getIconSize(size);

    Widget buttonChild = _buildButtonContent(
      label: label,
      icon: icon,
      iconPosition: iconPosition,
      iconSize: iconSize,
      textStyle: textStyle,
      loading: loading,
    );

    Widget button;

    switch (variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.danger:
        button = ElevatedButton(
          onPressed: effectiveOnPressed,
          style: buttonStyle,
          child: buttonChild,
        );
        break;
      case AppButtonVariant.secondary:
        button = FilledButton(
          onPressed: effectiveOnPressed,
          style: buttonStyle,
          child: buttonChild,
        );
        break;
      case AppButtonVariant.outline:
        button = OutlinedButton(
          onPressed: effectiveOnPressed,
          style: buttonStyle,
          child: buttonChild,
        );
        break;
      case AppButtonVariant.ghost:
        button = TextButton(
          onPressed: effectiveOnPressed,
          style: buttonStyle,
          child: buttonChild,
        );
        break;
    }

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }

  ButtonStyle _getButtonStyle(AppButtonVariant variant, AppButtonSize size) {
    final height = _getHeight(size);
    final padding = _getPadding(size);
    final borderRadius = AppBorders.lg;

    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: Size(0, height),
          padding: padding,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          elevation: 0,
        );
      case AppButtonVariant.secondary:
        return FilledButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          minimumSize: Size(0, height),
          padding: padding,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          elevation: 0,
        );
      case AppButtonVariant.outline:
        return OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: Size(0, height),
          padding: padding,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          side: BorderSide(color: AppColors.border, width: 1.5),
        );
      case AppButtonVariant.ghost:
        return TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: Size(0, height),
          padding: padding,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        );
      case AppButtonVariant.danger:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.error,
          foregroundColor: Colors.white,
          minimumSize: Size(0, height),
          padding: padding,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          elevation: 0,
        );
    }
  }

  TextStyle _getTextStyle(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return AppTypography.labelSmall.copyWith(fontWeight: FontWeight.w600);
      case AppButtonSize.medium:
        return AppTypography.labelBase.copyWith(fontWeight: FontWeight.w600);
      case AppButtonSize.large:
        return AppTypography.labelLarge.copyWith(fontWeight: FontWeight.w600);
    }
  }

  double _getHeight(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return 36;
      case AppButtonSize.medium:
        return 44;
      case AppButtonSize.large:
        return 52;
    }
  }

  EdgeInsetsGeometry _getPadding(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return AppSpacing.h3v2;
      case AppButtonSize.medium:
        return AppSpacing.h4v3;
      case AppButtonSize.large:
        return AppSpacing.h6v3;
    }
  }

  double _getIconSize(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  Widget _buildButtonContent({
    required String label,
    required IconData? icon,
    required IconPosition iconPosition,
    required double iconSize,
    required TextStyle textStyle,
    required bool loading,
  }) {
    if (loading) {
      return SizedBox(
        width: iconSize,
        height: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            textStyle.color ?? Colors.white,
          ),
        ),
      );
    }

    if (icon == null) {
      return Text(label, style: textStyle);
    }

    final iconWidget = Icon(icon, size: iconSize);
    final textWidget = Text(label, style: textStyle);
    final spacing = SizedBox(width: AppSpacing.spacing2);

    if (iconPosition == IconPosition.left) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [iconWidget, spacing, textWidget],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [textWidget, spacing, iconWidget],
      );
    }
  }
}

/// Icon position in button
enum IconPosition {
  left,
  right,
}
