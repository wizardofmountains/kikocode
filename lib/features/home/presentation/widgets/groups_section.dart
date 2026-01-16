import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'package:kikocode/features/messages/presentation/providers/messages_providers.dart';
import 'package:kikocode/features/messages/domain/models/group.dart';

class GroupsSection extends ConsumerWidget {
  const GroupsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(groupsProvider);

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
          groupsAsync.when(
            data: (groups) => _buildGroupsList(context, groups),
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, stack) => SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: AppColors.error,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fehler beim Laden der Gruppen',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => ref.invalidate(groupsProvider),
                      child: const Text('Erneut versuchen'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupsList(BuildContext context, List<Group> groups) {
    if (groups.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Keine Gruppen vorhanden'),
      );
    }

    return Column(
      children: groups.asMap().entries.map((entry) {
        final index = entry.key;
        final group = entry.value;
        return Column(
          children: [
            _buildGroupItem(
              context,
              emoji: group.emoji,
              name: group.name,
              groupId: group.id,
            ),
            if (index < groups.length - 1)
              Divider(
                color: AppColors.surfaceLow,
                height: 24,
                thickness: 1,
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildGroupItem(
    BuildContext context, {
    required String emoji,
    required String name,
    required String groupId,
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
