import 'package:flutter/material.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/kiko_typography.dart';
import 'loading_indicator.dart';

/// Card displaying group messages with loading progress indicators
class GroupMessageCard extends StatelessWidget {
  final String groupName;
  final int receivedCount;
  final int totalCount;
  final double progress; // 0.0 to 1.0
  final VoidCallback? onTap;

  const GroupMessageCard({
    super.key,
    required this.groupName,
    required this.receivedCount,
    required this.totalCount,
    required this.progress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            // Loading indicator
            LoadingIndicator(progress: progress),
            const SizedBox(width: 28),
            
            // Group name
            Expanded(
              child: Text(
                groupName,
                style: KikoTypography.withColor(
                  KikoTypography.appBody,
                  AppColors.textPrimaryKiko,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // Status count
            Text(
              '$receivedCount/$totalCount',
              style: KikoTypography.withColor(
                KikoTypography.appFootnote,
                AppColors.textPrimaryKiko,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
