import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';

/// Badge variant types
enum AppBadgeVariant {
  primary,
  secondary,
  success,
  warning,
  error,
  info,
  neutral,
}

/// Badge size types
enum AppBadgeSize {
  small,
  medium,
  large,
}

/// A reusable badge/chip component for status indicators and labels
/// 
/// Supports multiple variants and sizes with consistent styling.
/// 
/// Example:
/// ```dart
/// AppBadge(
///   label: 'Active',
///   variant: AppBadgeVariant.success,
///   size: AppBadgeSize.medium,
/// )
/// ```
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.neutral,
    this.size = AppBadgeSize.medium,
    this.icon,
    this.onTap,
    this.onDelete,
  });

  final String label;
  final AppBadgeVariant variant;
  final AppBadgeSize size;
  final IconData? icon;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(variant);
    final textStyle = _getTextStyle(size).copyWith(color: colors.textColor);
    final padding = _getPadding(size);
    final iconSize = _getIconSize(size);

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: iconSize, color: colors.textColor),
          SizedBox(width: AppSpacing.spacing1),
        ],
        Text(label, style: textStyle),
        if (onDelete != null) ...[
          SizedBox(width: AppSpacing.spacing1),
          GestureDetector(
            onTap: onDelete,
            child: Icon(
              Icons.close,
              size: iconSize,
              color: colors.textColor,
            ),
          ),
        ],
      ],
    );

    Widget badge = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: AppBorders.full,
        border: Border.all(
          color: colors.borderColor ?? Colors.transparent,
          width: 1,
        ),
      ),
      child: content,
    );

    if (onTap != null) {
      badge = InkWell(
        onTap: onTap,
        borderRadius: AppBorders.full,
        child: badge,
      );
    }

    return badge;
  }

  _BadgeColors _getColors(AppBadgeVariant variant) {
    switch (variant) {
      case AppBadgeVariant.primary:
        return _BadgeColors(
          backgroundColor: AppColors.primary100,
          textColor: AppColors.primary700,
          borderColor: AppColors.primary200,
        );
      case AppBadgeVariant.secondary:
        return _BadgeColors(
          backgroundColor: AppColors.secondary100,
          textColor: AppColors.secondary700,
          borderColor: AppColors.secondary200,
        );
      case AppBadgeVariant.success:
        return _BadgeColors(
          backgroundColor: AppColors.success100,
          textColor: AppColors.success700,
          borderColor: AppColors.success200,
        );
      case AppBadgeVariant.warning:
        return _BadgeColors(
          backgroundColor: AppColors.warning100,
          textColor: AppColors.warning700,
          borderColor: AppColors.warning200,
        );
      case AppBadgeVariant.error:
        return _BadgeColors(
          backgroundColor: AppColors.error100,
          textColor: AppColors.error700,
          borderColor: AppColors.error200,
        );
      case AppBadgeVariant.info:
        return _BadgeColors(
          backgroundColor: AppColors.info100,
          textColor: AppColors.info700,
          borderColor: AppColors.info200,
        );
      case AppBadgeVariant.neutral:
        return _BadgeColors(
          backgroundColor: AppColors.gray100,
          textColor: AppColors.gray700,
          borderColor: AppColors.gray200,
        );
    }
  }

  TextStyle _getTextStyle(AppBadgeSize size) {
    switch (size) {
      case AppBadgeSize.small:
        return AppTypography.labelSmall.copyWith(fontWeight: FontWeight.w600);
      case AppBadgeSize.medium:
        return AppTypography.labelBase.copyWith(fontWeight: FontWeight.w600);
      case AppBadgeSize.large:
        return AppTypography.labelLarge.copyWith(fontWeight: FontWeight.w600);
    }
  }

  EdgeInsetsGeometry _getPadding(AppBadgeSize size) {
    switch (size) {
      case AppBadgeSize.small:
        return AppSpacing.symmetric(
          horizontal: AppSpacing.spacing2,
          vertical: AppSpacing.spacing1,
        );
      case AppBadgeSize.medium:
        return AppSpacing.symmetric(
          horizontal: AppSpacing.spacing3,
          vertical: AppSpacing.spacing1,
        );
      case AppBadgeSize.large:
        return AppSpacing.symmetric(
          horizontal: AppSpacing.spacing4,
          vertical: AppSpacing.spacing2,
        );
    }
  }

  double _getIconSize(AppBadgeSize size) {
    switch (size) {
      case AppBadgeSize.small:
        return 12;
      case AppBadgeSize.medium:
        return 14;
      case AppBadgeSize.large:
        return 16;
    }
  }
}

class _BadgeColors {
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  _BadgeColors({
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  });
}

/// A notification badge (dot or number) typically shown on icons
/// 
/// Example:
/// ```dart
/// Stack(
///   children: [
///     Icon(Icons.notifications),
///     Positioned(
///       right: 0,
///       top: 0,
///       child: AppNotificationBadge(count: 5),
///     ),
///   ],
/// )
/// ```
class AppNotificationBadge extends StatelessWidget {
  const AppNotificationBadge({
    super.key,
    this.count,
    this.showDot = false,
    this.color,
    this.textColor,
  });

  final int? count;
  final bool showDot;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final bgColor = color ?? AppColors.error;
    final fgColor = textColor ?? Colors.white;

    if (showDot || count == null || count == 0) {
      return Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
      );
    }

    final displayCount = count! > 99 ? '99+' : count.toString();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: count! > 9 ? 4 : 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: const BoxConstraints(
        minWidth: 18,
        minHeight: 18,
      ),
      child: Center(
        child: Text(
          displayCount,
          style: AppTypography.caption.copyWith(
            color: fgColor,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ),
    );
  }
}
