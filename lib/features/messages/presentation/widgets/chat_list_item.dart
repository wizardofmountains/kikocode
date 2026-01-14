import 'package:flutter/material.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/kiko_typography.dart';
import 'shortcut_button.dart';

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
          // Avatar with emoji in corporate design (Figma 560:2702)
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondaryKiko,
            ),
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondaryLightKiko,
              ),
              child: Center(
                child: Text(
                  emoji,
                  style: const TextStyle(
                    fontSize: 28,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
          
          // Call + Info shortcut button
          ShortcutButton(
            onCallTap: onCallTap,
            onInfoTap: onInfoTap,
          ),
        ],
      ),
    );
  }
}
