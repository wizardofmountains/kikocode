import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'app_card.dart';

/// A specialized card component for action buttons
/// 
/// Provides a tappable card with centered text, typically used for
/// quick actions or navigation. Features consistent styling with
/// fixed height, padding, and elevation.
/// 
/// Example:
/// ```dart
/// AppActionCard(
///   title: 'Meine Aufgaben',
///   onTap: () => navigateToTasks(),
/// )
/// 
/// // With custom height
/// AppActionCard(
///   title: 'Abstimmung/\nUmfrage',
///   onTap: () => navigateToPolls(),
///   height: 100,
/// )
/// ```
class AppActionCard extends StatelessWidget {
  const AppActionCard({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 80,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.textStyle,
    this.textAlign = TextAlign.center,
  });

  /// The text to display in the card
  final String title;
  
  /// Callback when the card is tapped
  final VoidCallback onTap;
  
  /// Height of the card (default: 80)
  final double height;
  
  /// Padding inside the card (default: AppSpacing.all4)
  final EdgeInsetsGeometry? padding;
  
  /// Background color (default: AppColors.surfaceBright)
  final Color? backgroundColor;
  
  /// Border radius (default: AppBorders.xl)
  final BorderRadius? borderRadius;
  
  /// Text style (default: AppTypography.bodySmall with semiBold)
  final TextStyle? textStyle;
  
  /// Text alignment (default: TextAlign.center)
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ?? AppSpacing.all4;
    final effectiveBackgroundColor = backgroundColor ?? AppColors.surfaceBright;
    final effectiveBorderRadius = borderRadius ?? AppBorders.xl;
    final effectiveTextStyle = textStyle ??
        AppTypography.bodySmall.copyWith(
          fontWeight: AppTypography.semiBold,
        );

    return AppCard(
      height: height,
      padding: effectivePadding,
      backgroundColor: effectiveBackgroundColor,
      borderRadius: effectiveBorderRadius,
      elevation: AppCardElevation.medium,
      onTap: onTap,
      child: Center(
        child: Text(
          title,
          textAlign: textAlign,
          style: effectiveTextStyle,
        ),
      ),
    );
  }
}
