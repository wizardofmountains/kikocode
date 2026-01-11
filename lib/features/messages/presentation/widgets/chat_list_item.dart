import 'package:flutter/material.dart';
import 'package:coolicons/coolicons.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/spacing.dart';
import '../../../../core/design_system/kiko_typography.dart';

/// Chat list item with avatar and call/info buttons
class ChatListItem extends StatelessWidget {
  final String name;
  final String emoji;
  final VoidCallback? onCallTap;
  final VoidCallback? onInfoTap;

  const ChatListItem({
    super.key,
    required this.name,
    required this.emoji,
    this.onCallTap,
    this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Avatar with emoji
          Container(
            width: 45,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.surfaceLow,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 2),
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 28),
                ),
              ],
            ),
          ),
          const SizedBox(width: 13),
          
          // Name
          Expanded(
            child: Text(
              name,
              style: KikoTypography.withColor(
                KikoTypography.appBody,
                AppColors.textPrimaryKiko,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // Call + Info buttons combined
          Container(
            width: 94,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondaryKiko,
              borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Call button
                GestureDetector(
                  onTap: onCallTap,
                  child: Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    child: Icon(
                      Coolicons.phone,
                      color: AppColors.surfaceHighest,
                      size: 18,
                    ),
                  ),
                ),
                
                // Divider
                Container(
                  width: 1,
                  height: 28,
                  color: AppColors.surfaceHighest,
                ),
                
                // Info button
                GestureDetector(
                  onTap: onInfoTap,
                  child: Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    child: Icon(
                      Coolicons.info_circle,
                      color: AppColors.surfaceHighest,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
