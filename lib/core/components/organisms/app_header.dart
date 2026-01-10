import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'package:kikocode/core/components/atoms/atoms.dart';

/// A reusable app header/app bar component
/// 
/// Provides consistent styling across all screens.
/// 
/// Example:
/// ```dart
/// AppHeader(
///   title: 'Home',
///   leading: Icon(Icons.menu),
///   actions: [Icon(Icons.search), Icon(Icons.notifications)],
/// )
/// ```
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.centerTitle = false,
    this.showBackButton = false,
    this.onBackPressed,
    this.bottom,
  });

  final String? title;
  final Widget? titleWidget;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final bool centerTitle;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );

  @override
  Widget build(BuildContext context) {
    Widget? effectiveLeading = leading;

    if (effectiveLeading == null && showBackButton) {
      effectiveLeading = IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      );
    }

    return AppBar(
      title: titleWidget ?? (title != null ? Text(title!) : null),
      leading: effectiveLeading,
      actions: actions,
      backgroundColor: backgroundColor ?? AppColors.surface,
      foregroundColor: foregroundColor ?? AppColors.textPrimary,
      elevation: elevation,
      centerTitle: centerTitle,
      bottom: bottom,
      titleTextStyle: AppTypography.h5.copyWith(
        color: foregroundColor ?? AppColors.textPrimary,
      ),
    );
  }
}

/// A header with a search field
/// 
/// Example:
/// ```dart
/// AppSearchHeader(
///   hintText: 'Search...',
///   onSearch: (query) => print('Searching: $query'),
/// )
/// ```
class AppSearchHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppSearchHeader({
    super.key,
    this.hintText = 'Search...',
    this.onSearch,
    this.onChanged,
    this.controller,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.showBackButton = false,
  });

  final String hintText;
  final void Function(String)? onSearch;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool showBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.surface,
      elevation: 0,
      leading: leading ??
          (showBackButton
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null),
      title: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSearch,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: AppBorders.full,
            borderSide: BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppBorders.full,
            borderSide: BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppBorders.full,
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding: AppSpacing.symmetric(
            horizontal: AppSpacing.spacing4,
            vertical: AppSpacing.spacing2,
          ),
          filled: true,
          fillColor: AppColors.backgroundSecondary,
        ),
      ),
      actions: actions,
    );
  }
}

/// A large header with title and subtitle
/// 
/// Example:
/// ```dart
/// AppLargeHeader(
///   title: 'Dashboard',
///   subtitle: 'Welcome back!',
///   actions: [Icon(Icons.settings)],
/// )
/// ```
class AppLargeHeader extends StatelessWidget {
  const AppLargeHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.backgroundColor,
    this.padding,
  });

  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ??
        AppSpacing.symmetric(
          horizontal: AppSpacing.spacing6,
          vertical: AppSpacing.spacing4,
        );

    return Container(
      color: backgroundColor ?? AppColors.surface,
      padding: effectivePadding,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (actions != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              ),
            AppSpacing.v2,
            Text(
              title,
              style: AppTypography.h2,
            ),
            if (subtitle != null) ...[
              AppSpacing.v2,
              Text(
                subtitle!,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A header with tabs
/// 
/// Example:
/// ```dart
/// AppTabHeader(
///   title: 'Messages',
///   tabs: [Tab(text: 'All'), Tab(text: 'Unread')],
///   controller: tabController,
/// )
/// ```
class AppTabHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppTabHeader({
    super.key,
    this.title,
    required this.tabs,
    this.controller,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.indicatorColor,
  });

  final String? title;
  final List<Widget> tabs;
  final TabController? controller;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? indicatorColor;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      leading: leading,
      actions: actions,
      backgroundColor: backgroundColor ?? AppColors.surface,
      elevation: 0,
      bottom: TabBar(
        controller: controller,
        tabs: tabs,
        indicatorColor: indicatorColor ?? AppColors.primary,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTypography.labelBase.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
