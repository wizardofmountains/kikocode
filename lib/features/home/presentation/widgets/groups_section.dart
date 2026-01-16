import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';
import 'package:kikocode/core/design_system/design_system.dart';

class GroupsSection extends StatelessWidget {
  const GroupsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = [
      _GroupData(emoji: '\u{1F98B}', name: 'Schmetterling'), // butterfly
      _GroupData(emoji: '\u{1F41E}', name: 'Marienkäfer'), // ladybug
      _GroupData(emoji: '\u{1F99C}', name: 'Papagei'), // parrot
    ];

    return Container(
      padding: AppSpacing.all5,
      decoration: BoxDecoration(
        color: AppColors.surfaceHighest,
        borderRadius: AppBorders.xl2,
        border: Border.all(color: AppColors.surfaceLow, width: 2),
        boxShadow: AppShadows.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gruppen',
            style: AppTypography.h5,
          ),
          AppSpacing.v4,
          // Group items with dividers
          ...groups.asMap().entries.map((entry) {
            final index = entry.key;
            final group = entry.value;
            return Column(
              children: [
                _buildGroupItem(
                  context,
                  emoji: group.emoji,
                  name: group.name,
                ),
                if (index < groups.length - 1)
                  Divider(
                    color: AppColors.surfaceLow,
                    height: 24,
                    thickness: 1,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildGroupItem(
    BuildContext context, {
    required String emoji,
    required String name,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Emoji icon - circular with shadow
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceHighest,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          AppSpacing.h4,
          // Group name
          Expanded(
            child: Text(
              name,
              style: AppTypography.bodyBase.copyWith(
                fontWeight: AppTypography.medium,
              ),
            ),
          ),
          // Action buttons - green pill
          Container(
            width: 94,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondary, // #9ED9C6
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Paper plane / send icon
                GestureDetector(
                  onTap: () => context.go('/messages'),
                  child: SvgPicture.asset(
                    'assets/images/icons/nav_messages_inactive.svg',
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      AppColors.surfaceHighest,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                // Vertical divider
                Container(
                  height: 28,
                  width: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  color: AppColors.surfaceHighest,
                ),
                // Calendar icon
                Icon(
                  Coolicons.calendar,
                  size: 24,
                  color: AppColors.surfaceHighest,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupData {
  final String emoji;
  final String name;

  const _GroupData({required this.emoji, required this.name});
}

