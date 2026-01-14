import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/kiko_typography.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final int? messageBadgeCount;
  
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    this.messageBadgeCount,
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
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            icon: Coolicons.home_outline,
            label: 'Home',
            isActive: currentIndex == 0,
            onTap: () => context.go('/home'),
          ),
          _buildNavItem(
            icon: Coolicons.calendar,
            label: 'Kalender',
            isActive: currentIndex == 1,
            onTap: () {}, // TODO: Calendar screen
          ),
          _buildNavItem(
            icon: Coolicons.user_circle,
            label: 'Team',
            isActive: currentIndex == 2,
            onTap: () {}, // TODO: Team screen
          ),
          _buildNavItem(
            icon: Coolicons.message,
            label: 'Nachrichten',
            isActive: currentIndex == 3,
            badgeCount: messageBadgeCount,
            onTap: () => context.go('/message-overview'),
          ),
          _buildNavItem(
            icon: Coolicons.settings,
            label: 'Einstellungen',
            isActive: currentIndex == 4,
            onTap: () {}, // TODO: Settings screen
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
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
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // Icon container - only visible when active
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primaryKiko : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: isActive ? AppColors.surfaceHighest : AppColors.primaryKiko,
                      size: 26,
                    ),
                  ),
                  // Badge positioned on top right
                  if (badgeCount != null && badgeCount > 0)
                    Positioned(
                      top: -2,
                      right: 2,
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
              const SizedBox(height: 2),
              Text(
                label,
                style: KikoTypography.withColor(
                  KikoTypography.appCaption1,
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
