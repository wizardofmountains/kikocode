import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kikocode/core/design_system/design_system.dart';

/// Icon size presets
enum AppIconSize {
  xSmall(16),
  small(20),
  medium(24),
  large(32),
  xLarge(48);

  const AppIconSize(this.size);
  final double size;
}

/// A reusable icon component that supports both Material icons and SVG assets
/// 
/// Automatically handles color filtering and sizing.
/// 
/// Example with Material icon:
/// ```dart
/// AppIcon(
///   icon: Icons.home,
///   size: AppIconSize.medium,
///   color: AppColors.primary,
/// )
/// ```
/// 
/// Example with SVG:
/// ```dart
/// AppIcon.svg(
///   assetPath: AssetPaths.iconSettings,
///   size: AppIconSize.medium,
///   color: AppColors.primary,
/// )
/// ```
class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.icon,
    this.size = AppIconSize.medium,
    this.color,
    this.semanticLabel,
  })  : assetPath = null,
        isSvg = false;

  const AppIcon.svg({
    super.key,
    required String this.assetPath,
    this.size = AppIconSize.medium,
    this.color,
    this.semanticLabel,
  })  : icon = null,
        isSvg = true;

  final IconData? icon;
  final String? assetPath;
  final bool isSvg;
  final AppIconSize size;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    if (isSvg && assetPath != null) {
      return SvgPicture.asset(
        assetPath!,
        width: size.size,
        height: size.size,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        semanticsLabel: semanticLabel,
      );
    }

    return Icon(
      icon,
      size: size.size,
      color: color,
      semanticLabel: semanticLabel,
    );
  }
}

/// A circular icon container with background
/// 
/// Useful for avatar placeholders, action buttons, or icon badges.
/// 
/// Example:
/// ```dart
/// AppIconCircle(
///   icon: Icons.person,
///   backgroundColor: AppColors.primary100,
///   iconColor: AppColors.primary700,
///   size: 48,
/// )
/// ```
class AppIconCircle extends StatelessWidget {
  const AppIconCircle({
    super.key,
    required this.icon,
    this.size = 48,
    this.backgroundColor,
    this.iconColor,
    this.iconSize,
    this.onTap,
    this.semanticLabel,
  });

  final IconData icon;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? iconSize;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.primary100;
    final fgColor = iconColor ?? AppColors.primary700;
    final effectiveIconSize = iconSize ?? size * 0.5;

    final container = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          size: effectiveIconSize,
          color: fgColor,
          semanticLabel: semanticLabel,
        ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: container,
      );
    }

    return container;
  }
}

/// A square icon container with rounded corners
/// 
/// Similar to AppIconCircle but with rounded square shape.
/// 
/// Example:
/// ```dart
/// AppIconSquare(
///   icon: Icons.settings,
///   backgroundColor: AppColors.secondary100,
///   iconColor: AppColors.secondary700,
///   size: 48,
/// )
/// ```
class AppIconSquare extends StatelessWidget {
  const AppIconSquare({
    super.key,
    required this.icon,
    this.size = 48,
    this.backgroundColor,
    this.iconColor,
    this.iconSize,
    this.borderRadius,
    this.onTap,
    this.semanticLabel,
  });

  final IconData icon;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? iconSize;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.primary100;
    final fgColor = iconColor ?? AppColors.primary700;
    final effectiveIconSize = iconSize ?? size * 0.5;
    final effectiveBorderRadius = borderRadius ?? AppBorders.lg;

    final container = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: effectiveBorderRadius,
      ),
      child: Center(
        child: Icon(
          icon,
          size: effectiveIconSize,
          color: fgColor,
          semanticLabel: semanticLabel,
        ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: effectiveBorderRadius,
        child: container,
      );
    }

    return container;
  }
}
