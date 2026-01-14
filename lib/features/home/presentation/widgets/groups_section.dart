import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';

class GroupsSection extends StatelessWidget {
  const GroupsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.all5,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppBorders.xl2,
        boxShadow: AppShadows.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gruppen',
            style: AppTypography.h5.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          AppSpacing.v4,
          _buildGroupItem(
            context,
            emoji: '🦋',
            name: 'Schmetterling',
            color: const Color(0xFF7DD3C0),
          ),
          AppSpacing.v3,
          _buildGroupItem(
            context,
            emoji: '🐞',
            name: 'Marienkäfer',
            color: const Color(0xFFFF9999),
          ),
          AppSpacing.v3,
          _buildGroupItem(
            context,
            emoji: '🦜',
            name: 'Papagei',
            color: const Color(0xFF92C6E8),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupItem(
    BuildContext context, {
    required String emoji,
    required String name,
    required Color color,
  }) {
    return Container(
      padding: AppSpacing.h4v3,
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: AppBorders.xl,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: AppBorders.lg,
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          AppSpacing.h3,
          Expanded(
            child: Text(
              name,
              style: AppTypography.bodyBase.copyWith(
                fontWeight: AppTypography.medium,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Container(
            padding: AppSpacing.h3v2,
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: AppBorders.lg,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => context.go('/messages'),
                  child: Icon(
                    Coolicons.message_circle,
                    size: 18,
                    color: color.withOpacity(0.8),
                  ),
                ),
                AppSpacing.h2,
                Icon(
                  Coolicons.calendar,
                  size: 18,
                  color: color.withOpacity(0.8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

