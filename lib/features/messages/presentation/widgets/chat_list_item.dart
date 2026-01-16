import 'package:flutter/material.dart';
import '../../../../core/components/atoms/app_avatar.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/kiko_typography.dart';
import '../../../../features/auth/providers/avatar_providers.dart';
import 'shortcut_button.dart';

/// Chat list item with avatar and call/info buttons
class ChatListItem extends StatelessWidget {
  final String name;
  final String? avatarUrl;
  final String? emoji;
  final VoidCallback? onCallTap;
  final VoidCallback? onInfoTap;

  const ChatListItem({
    super.key,
    required this.name,
    this.avatarUrl,
    this.emoji,
    this.onCallTap,
    this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Avatar component
          _buildAvatar(),
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

  Widget _buildAvatar() {
    // Check if avatarUrl is an asset path
    final assetPath = avatarUrl.assetPath;
    final networkUrl = avatarUrl.networkUrl;

    // If we have an avatar URL (either asset or network), use AppAvatar
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return AppAvatar(
        imageUrl: networkUrl,
        assetPath: assetPath,
        initials: name,
        size: AppAvatarSize.large,
      );
    }

    // Fallback to emoji style if provided
    if (emoji != null && emoji!.isNotEmpty) {
      return Container(
        width: 54,
        height: 54,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.secondaryKiko,
        ),
        child: Center(
          child: Text(
            emoji!,
            style: const TextStyle(
              fontSize: 28,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    // Default to AppAvatar with initials
    return AppAvatar(
      initials: name,
      size: AppAvatarSize.large,
    );
  }
}
