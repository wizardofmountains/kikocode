import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        padding: AppSpacing.all4,
        decoration: BoxDecoration(
          color: AppColors.surfaceBright,
          borderRadius: AppBorders.xl,
          boxShadow: AppShadows.md,
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall.copyWith(
              fontWeight: AppTypography.semiBold,
            ),
          ),
        ),
      ),
    );
  }
}

