import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/kiko_typography.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final int? messageBadgeCount;
  final Future<bool> Function()? onNavigationAttempt;
  
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    this.messageBadgeCount,
    this.onNavigationAttempt,
  });

  @override
  Widget build(BuildContext context) {
    // Get the bottom safe area padding (for iPhone home indicator)
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceHighest,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 7,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: 12,
        bottom: bottomPadding > 0 ? bottomPadding - 12 : 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            iconPath: 'assets/images/icons/nav_home.svg',
            iconSize: 32,
            label: 'Home',
            isActive: currentIndex == 0,
            onTap: () async {
              if (onNavigationAttempt != null) {
                final canNavigate = await onNavigationAttempt!();
                if (!canNavigate) return;
              }
              if (context.mounted) {
                context.go('/home');
              }
            },
          ),
          _buildNavItem(
            iconPath: 'assets/images/icons/nav_calendar.svg',
            iconSize: 32,
            label: 'Kalender',
            isActive: currentIndex == 1,
            onTap: () async {
              if (onNavigationAttempt != null) {
                final canNavigate = await onNavigationAttempt!();
                if (!canNavigate) return;
              }
              // TODO: Calendar screen
            },
          ),
          _buildNavItem(
            iconPath: 'assets/images/icons/nav_team.svg',
            iconSize: 32,
            label: 'Team',
            isActive: currentIndex == 2,
            badgeCount: messageBadgeCount,
            onTap: () async {
              if (onNavigationAttempt != null) {
                final canNavigate = await onNavigationAttempt!();
                if (!canNavigate) return;
              }
              // TODO: Team screen
            },
          ),
          _buildNavItem(
            iconPath: 'assets/images/icons/nav_messages_inactive.svg',
            activeIconPath: 'assets/images/icons/nav_messages_active.svg',
            iconSize: 32,
            label: 'Nachrichten',
            isActive: currentIndex == 3,
            onTap: () async {
              if (onNavigationAttempt != null) {
                final canNavigate = await onNavigationAttempt!();
                if (!canNavigate) return;
              }
              if (context.mounted) {
                context.go('/message-overview');
              }
            },
          ),
          _buildNavItem(
            iconPath: 'assets/images/icons/nav_settings.svg',
            iconSize: 32,
            label: 'Einstellungen',
            isActive: currentIndex == 4,
            onTap: () async {
              if (onNavigationAttempt != null) {
                final canNavigate = await onNavigationAttempt!();
                if (!canNavigate) return;
              }
              // TODO: Settings screen
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String iconPath,
    String? activeIconPath,
    required double iconSize,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    int? badgeCount,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // Icon container
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primaryKiko : AppColors.primaryLightKiko,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        isActive && activeIconPath != null ? activeIconPath : iconPath,
                        width: iconSize,
                        height: iconSize,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        colorFilter: ColorFilter.mode(
                          isActive ? AppColors.surfaceHighest : AppColors.primaryKiko,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  // Badge positioned on top right
                  if (badgeCount != null && badgeCount > 0)
                    Positioned(
                      top: -6,
                      right: -6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: const BoxDecoration(
                          color: Color(0xFFEF4444), // Red badge
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Center(
                          child: Text(
                            badgeCount > 99 ? '99+' : badgeCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 1),
              Text(
                label,
                style: KikoTypography.withColor(
                  KikoTypography.appCaption2,
                  AppColors.captionKiko,
                ),
                textAlign: TextAlign.center,
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
