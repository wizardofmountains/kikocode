import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  
  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.primary200,
        boxShadow: AppShadows.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            icon: Coolicons.home_outline,
            isActive: currentIndex == 0,
            onTap: () => context.go('/home'),
          ),
          _buildNavItem(
            icon: Coolicons.calendar,
            isActive: currentIndex == 1,
            onTap: () {},
          ),
          _buildNavItem(
            icon: Coolicons.user,
            isActive: currentIndex == 2,
            onTap: () {},
          ),
          _buildNavItem(
            icon: Coolicons.message_circle,
            isActive: currentIndex == 3,
            onTap: () => context.go('/messages'),
          ),
          _buildNavItem(
            icon: Coolicons.settings,
            isActive: currentIndex == 4,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: isActive ? AppColors.purple400 : Colors.transparent,
          borderRadius: AppBorders.xl,
        ),
        child: Icon(
          icon,
          color: isActive ? AppColors.white : AppColors.purple600,
          size: 28,
        ),
      ),
    );
  }
}

