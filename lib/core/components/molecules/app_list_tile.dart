import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';

/// List tile size variants
enum AppListTileSize {
  compact,
  standard,
  large,
}

/// A reusable list tile component with consistent styling
/// 
/// Provides a horizontal layout with optional leading/trailing widgets.
/// 
/// Example:
/// ```dart
/// AppListTile(
///   leading: Icon(Icons.person),
///   title: 'John Doe',
///   subtitle: 'Software Developer',
///   trailing: Icon(Icons.chevron_right),
///   onTap: () => print('Tapped'),
/// )
/// ```
class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.size = AppListTileSize.standard,
    this.backgroundColor,
    this.contentPadding,
    this.enabled = true,
  });

  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final AppListTileSize size;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = contentPadding ?? _getDefaultPadding(size);
    final minHeight = _getMinHeight(size);
    final titleStyle = _getTitleStyle(size);
    final subtitleStyle = _getSubtitleStyle(size);

    return Material(
      color: backgroundColor ?? Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        child: Container(
          constraints: BoxConstraints(minHeight: minHeight),
          padding: effectivePadding,
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                SizedBox(width: AppSpacing.spacing3),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: titleStyle.copyWith(
                        color: enabled
                            ? AppColors.textPrimary
                            : AppColors.textTertiary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: AppSpacing.spacing1),
                      Text(
                        subtitle!,
                        style: subtitleStyle.copyWith(
                          color: enabled
                              ? AppColors.textSecondary
                              : AppColors.textTertiary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                SizedBox(width: AppSpacing.spacing3),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }

  EdgeInsetsGeometry _getDefaultPadding(AppListTileSize size) {
    switch (size) {
      case AppListTileSize.compact:
        return AppSpacing.symmetric(
          horizontal: AppSpacing.spacing4,
          vertical: AppSpacing.spacing2,
        );
      case AppListTileSize.standard:
        return AppSpacing.symmetric(
          horizontal: AppSpacing.spacing4,
          vertical: AppSpacing.spacing3,
        );
      case AppListTileSize.large:
        return AppSpacing.symmetric(
          horizontal: AppSpacing.spacing4,
          vertical: AppSpacing.spacing4,
        );
    }
  }

  double _getMinHeight(AppListTileSize size) {
    switch (size) {
      case AppListTileSize.compact:
        return 48;
      case AppListTileSize.standard:
        return 56;
      case AppListTileSize.large:
        return 72;
    }
  }

  TextStyle _getTitleStyle(AppListTileSize size) {
    switch (size) {
      case AppListTileSize.compact:
        return AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500);
      case AppListTileSize.standard:
        return AppTypography.bodyBase.copyWith(fontWeight: FontWeight.w500);
      case AppListTileSize.large:
        return AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w500);
    }
  }

  TextStyle _getSubtitleStyle(AppListTileSize size) {
    switch (size) {
      case AppListTileSize.compact:
        return AppTypography.bodyXSmall;
      case AppListTileSize.standard:
        return AppTypography.bodySmall;
      case AppListTileSize.large:
        return AppTypography.bodyBase;
    }
  }
}

/// A list tile with an avatar/icon on the left
/// 
/// Example:
/// ```dart
/// AppAvatarListTile(
///   avatar: CircleAvatar(child: Text('JD')),
///   title: 'John Doe',
///   subtitle: 'Online',
///   onTap: () {},
/// )
/// ```
class AppAvatarListTile extends StatelessWidget {
  const AppAvatarListTile({
    super.key,
    required this.avatar,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.size = AppListTileSize.standard,
  });

  final Widget avatar;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final AppListTileSize size;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      leading: avatar,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
      size: size,
    );
  }
}

/// A list tile with a checkbox
/// 
/// Example:
/// ```dart
/// AppCheckboxListTile(
///   title: 'Accept terms',
///   value: isChecked,
///   onChanged: (value) => setState(() => isChecked = value),
/// )
/// ```
class AppCheckboxListTile extends StatelessWidget {
  const AppCheckboxListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      title: title,
      subtitle: subtitle,
      trailing: Checkbox(
        value: value,
        onChanged: enabled ? onChanged : null,
        activeColor: AppColors.primary,
      ),
      onTap: enabled ? () => onChanged(!value) : null,
      enabled: enabled,
    );
  }
}

/// A list tile with a switch
/// 
/// Example:
/// ```dart
/// AppSwitchListTile(
///   title: 'Enable notifications',
///   value: isEnabled,
///   onChanged: (value) => setState(() => isEnabled = value),
/// )
/// ```
class AppSwitchListTile extends StatelessWidget {
  const AppSwitchListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      title: title,
      subtitle: subtitle,
      trailing: Switch(
        value: value,
        onChanged: enabled ? onChanged : null,
        activeColor: AppColors.primary,
      ),
      onTap: enabled ? () => onChanged(!value) : null,
      enabled: enabled,
    );
  }
}
