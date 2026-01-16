import 'package:flutter/material.dart';
import 'package:coolicons/coolicons.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/spacing.dart';
import '../../../../core/design_system/kiko_typography.dart';

/// Custom tab bar widget with 5 tabs and badge support
/// Tabs: Home, Kalender, Team, Nachrichten, Einstellungen
class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final int? badgeCount;

  const CustomTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.surfaceHighest,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        minimum: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TabBarItem(
                    icon: Icons.home_rounded,
                label: 'Home',
                isSelected: selectedIndex == 0,
                onTap: () => onTap(0),
              ),
              _TabBarItem(
                icon: Icons.calendar_today_rounded,
                label: 'Kalender',
                isSelected: selectedIndex == 1,
                onTap: () => onTap(1),
              ),
              _TabBarItem(
                    icon: Icons.group_rounded,
                label: 'Team',
                isSelected: selectedIndex == 2,
                onTap: () => onTap(2),
              ),
              _TabBarItem(
                    icon: Icons.message_rounded,
                label: 'Nachrichten',
                isSelected: selectedIndex == 3,
                badgeCount: badgeCount,
                onTap: () => onTap(3),
              ),
              _TabBarItem(
                icon: Icons.settings_rounded,
                label: 'Einstellungen',
                isSelected: selectedIndex == 4,
                onTap: () => onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int? badgeCount;

  const _TabBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryKiko
                        : AppColors.primaryLightKiko,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.tabBarItemRadius,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected
                        ? AppColors.surfaceHighest
                        : AppColors.primaryKiko,
                    size: 24,
                  ),
                ),
                if (badgeCount != null && badgeCount! > 0)
                  Positioned(
                    top: -6,
                    right: -6,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 22,
                        minHeight: 22,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.red500,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Text(
                        badgeCount.toString(),
                        style: KikoTypography.withColor(
                          KikoTypography.appFootnote,
                          AppColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: KikoTypography.withColor(
                KikoTypography.appCaption2,
                AppColors.captionKiko,
              ).copyWith(fontSize: 10),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
