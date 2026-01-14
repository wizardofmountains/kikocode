import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kikocode/core/design_system/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  
  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5EFE0), // Light beige background
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
                icon: Icons.group,
                label: 'Team',
                isActive: currentIndex == 2,
                onTap: () {}, // TODO: Family/People screen
                badgeCount: 6,
              ),
              _buildNavItem(
                icon: Coolicons.message_circle,
                label: 'Nachrichten',
                isActive: currentIndex == 3,
                onTap: () => context.go('/messages'),
              ),
              _buildNavItem(
                icon: Coolicons.settings,
                label: 'Einstellungen',
                isActive: currentIndex == 4,
                onTap: () {}, // TODO: Settings screen
              ),
            ],
          ),
        ),
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
    return GestureDetector(
      onTap: onTap,
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
                  color: AppColors.primary200, // Light purple rounded square
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary, // Medium purple icon
                  size: 24,
                ),
              ),
              if (badgeCount != null)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppColors.error, // Red badge
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        badgeCount.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.gray600, // Grey text
            ),
          ),
        ],
      ),
    );
  }
}

