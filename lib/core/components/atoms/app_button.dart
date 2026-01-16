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

/// A reusable button component with consistent styling and smooth press animations
/// 
/// Supports multiple variants (primary, secondary, outline, ghost, danger)
/// and sizes (small, medium, large).
/// 
/// Features smooth animations when transitioning from Default to On Click state.
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
class AppButton extends StatefulWidget {
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
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller for smooth press animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    // Scale animation: slightly shrink button when pressed
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Shadow animation: reduce shadow when pressed
    _shadowAnimation = Tween<double>(
      begin: 1.0,
      end: 0.3,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enabled && !widget.loading) {
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.enabled && !widget.loading;
    final effectiveOnPressed = isEnabled ? widget.onPressed : null;

    final buttonStyle = _getButtonStyle(widget.variant, widget.size);
    final textStyle = _getTextStyle(widget.size);
    final iconSize = _getIconSize(widget.size);

    Widget buttonChild = _buildButtonContent(
      label: widget.label,
      icon: widget.icon,
      iconPosition: widget.iconPosition,
      iconSize: iconSize,
      textStyle: textStyle,
      loading: widget.loading,
    );

    Widget button;

    switch (widget.variant) {
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

    // Add animated glow effect for primary button (KIKO Main Button style from Figma)
    if (widget.variant == AppButtonVariant.primary) {
      button = AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryLight.withOpacity(_shadowAnimation.value),
                    blurRadius: 8 * _shadowAnimation.value,
                    spreadRadius: 2 * _shadowAnimation.value,
                    offset: Offset(2 * _shadowAnimation.value, 2 * _shadowAnimation.value),
                  ),
                ],
              ),
              child: child,
            ),
          );
        },
        child: button,
      );
    }

    // Wrap with GestureDetector to capture tap events for animation
    button = GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: button,
    );

    if (widget.fullWidth) {
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
    final borderRadius = BorderRadius.circular(13); // KIKO Main Button: 13px from Figma

    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // Purple (#A974C7)
          foregroundColor: AppColors.surfaceHigh, // Beige text (#F7EFDE)
          minimumSize: Size(0, height),
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(
              color: AppColors.primaryLight, // Light purple border (#F5DDFF)
              width: 2,
            ),
          ),
          elevation: 0,
          shadowColor: AppColors.primaryLight,
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
        return AppTypography.headline; // Use Figma's App/Headline (Nunito Sans Bold 17px)
      case AppButtonSize.large:
        return AppTypography.labelLarge.copyWith(fontWeight: FontWeight.w600);
    }
  }

  double _getHeight(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return 36;
      case AppButtonSize.medium:
        return 50; // KIKO Main Button: 50px height from Figma
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
