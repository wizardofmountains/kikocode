import 'package:flutter/material.dart';
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
        color: const Color(0xFFE9D5FF), // Light purple/lavender
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
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
            onTap: () {}, // TODO: Calendar screen
          ),
          _buildNavItem(
            icon: Coolicons.user,
            isActive: currentIndex == 2,
            onTap: () {}, // TODO: Family/People screen
          ),
          _buildNavItem(
            icon: Coolicons.message_circle,
            isActive: currentIndex == 3,
            onTap: () => context.go('/messages'),
          ),
          _buildNavItem(
            icon: Coolicons.settings,
            isActive: currentIndex == 4,
            onTap: () {}, // TODO: Settings screen
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
          color: isActive ? const Color(0xFFB794F6) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.white : const Color(0xFF9333EA),
          size: 28,
        ),
      ),
    );
  }
}

