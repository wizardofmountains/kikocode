import 'package:flutter/material.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/kiko_typography.dart';
import 'loading_indicator.dart';

/// Card displaying group messages with loading progress indicators
class GroupMessageCard extends StatelessWidget {
  final String groupName;
  final String? emoji;
  final int receivedCount;
  final int totalCount;
  final double progress; // 0.0 to 1.0
  final VoidCallback? onTap;

  const GroupMessageCard({
    super.key,
    required this.groupName,
    this.emoji,
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
            
            // Group name (takes available space)
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
            
            const SizedBox(width: 8),
            
            // Emoji icon (fixed position and width for vertical alignment)
            if (emoji != null) ...[
              SizedBox(
                width: 28,
                child: Text(
                  emoji!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'Nunito',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 12),
            ],
            
            // Status count (fixed width for consistent emoji positioning)
            SizedBox(
              width: 40,
              child: Text(
                '$receivedCount/$totalCount',
                style: KikoTypography.withColor(
                  KikoTypography.appFootnote,
                  AppColors.textPrimaryKiko,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
