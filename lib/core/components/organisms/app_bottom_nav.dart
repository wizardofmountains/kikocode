import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';

/// Bottom navigation item data
class AppBottomNavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final Widget? badge;

  const AppBottomNavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.badge,
  });
}

/// A reusable bottom navigation bar component
/// 
/// Provides consistent styling and behavior for bottom navigation.
/// 
/// Example:
/// ```dart
/// AppBottomNav(
///   currentIndex: selectedIndex,
///   onTap: (index) => setState(() => selectedIndex = index),
///   items: [
///     AppBottomNavItem(icon: Icons.home, label: 'Home'),
///     AppBottomNavItem(icon: Icons.search, label: 'Search'),
///     AppBottomNavItem(icon: Icons.person, label: 'Profile'),
///   ],
/// )
/// ```
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation = 8,
    this.showLabels = true,
  });

  final int currentIndex;
  final void Function(int) onTap;
  final List<AppBottomNavItem> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double elevation;
  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: elevation,
                  offset: Offset(0, -elevation / 2),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          items: items.map((item) {
            return BottomNavigationBarItem(
              icon: item.badge != null
                  ? Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(item.icon),
                        Positioned(
                          right: -6,
                          top: -6,
                          child: item.badge!,
                        ),
                      ],
                    )
                  : Icon(item.icon),
              activeIcon: item.activeIcon != null
                  ? Icon(item.activeIcon)
                  : Icon(item.icon),
              label: item.label,
            );
          }).toList(),
          backgroundColor: backgroundColor ?? AppColors.surface,
          selectedItemColor: selectedItemColor ?? AppColors.primary,
          unselectedItemColor: unselectedItemColor ?? AppColors.textTertiary,
          selectedLabelStyle: AppTypography.labelSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: AppTypography.labelSmall,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          showSelectedLabels: showLabels,
          showUnselectedLabels: showLabels,
        ),
      ),
    );
  }
}

/// A custom styled bottom navigation bar with more flexibility
/// 
/// Example:
/// ```dart
/// AppCustomBottomNav(
///   currentIndex: selectedIndex,
///   onTap: (index) => setState(() => selectedIndex = index),
///   items: [
///     AppBottomNavItem(icon: Icons.home, label: 'Home'),
///     AppBottomNavItem(icon: Icons.search, label: 'Search'),
///   ],
/// )
/// ```
class AppCustomBottomNav extends StatelessWidget {
  const AppCustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
    this.height = 64,
  });

  final int currentIndex;
  final void Function(int) onTap;
  final List<AppBottomNavItem> items;
  final Color? backgroundColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        boxShadow: AppShadows.md,
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            items.length,
            (index) => _NavItem(
              item: items[index],
              isSelected: currentIndex == index,
              onTap: () => onTap(index),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final AppBottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.textTertiary;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: AppSpacing.symmetric(vertical: AppSpacing.spacing2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    isSelected && item.activeIcon != null
                        ? item.activeIcon
                        : item.icon,
                    color: color,
                    size: 24,
                  ),
                  if (item.badge != null)
                    Positioned(
                      right: -8,
                      top: -8,
                      child: item.badge!,
                    ),
                ],
              ),
              AppSpacing.v1,
              Text(
                item.label,
                style: AppTypography.labelSmall.copyWith(
                  color: color,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A floating action button for bottom navigation
/// 
/// Example:
/// ```dart
/// AppBottomNavWithFab(
///   currentIndex: selectedIndex,
///   onTap: (index) => setState(() => selectedIndex = index),
///   items: [...],
///   fabIcon: Icons.add,
///   onFabPressed: () => print('FAB pressed'),
/// )
/// ```
class AppBottomNavWithFab extends StatelessWidget {
  const AppBottomNavWithFab({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    required this.fabIcon,
    required this.onFabPressed,
    this.backgroundColor,
    this.fabColor,
  });

  final int currentIndex;
  final void Function(int) onTap;
  final List<AppBottomNavItem> items;
  final IconData fabIcon;
  final VoidCallback onFabPressed;
  final Color? backgroundColor;
  final Color? fabColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AppBottomNav(
          currentIndex: currentIndex,
          onTap: onTap,
          items: items,
          backgroundColor: backgroundColor,
        ),
        Positioned(
          top: -28,
          child: FloatingActionButton(
            onPressed: onFabPressed,
            backgroundColor: fabColor ?? AppColors.primary,
            child: Icon(fabIcon, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
