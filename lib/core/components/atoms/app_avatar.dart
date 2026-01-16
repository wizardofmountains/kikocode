import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../design_system/design_system.dart';

/// Avatar size presets
enum AppAvatarSize {
  /// 32px diameter
  small(32),
  /// 44px diameter
  medium(44),
  /// 56px diameter
  large(56),
  /// 80px diameter
  xlarge(80),
  /// 120px diameter
  xxlarge(120);

  const AppAvatarSize(this.value);
  final double value;
}

/// A versatile avatar component supporting network images, assets, initials, and icons.
///
/// Features:
/// - Network image support with caching via CachedNetworkImage
/// - Asset image support for predefined avatars
/// - Initials fallback when no image is available
/// - Icon fallback as last resort
/// - Loading and error states
/// - Optional online indicator
/// - Tap handler for interactions
class AppAvatar extends StatelessWidget {
  /// URL of the network image to display
  final String? imageUrl;

  /// Asset path for predefined avatars
  final String? assetPath;

  /// Initials to display when no image is available
  final String? initials;

  /// Size of the avatar
  final AppAvatarSize size;

  /// Custom size (overrides size enum)
  final double? customSize;

  /// Background color for initials/icon fallback
  final Color? backgroundColor;

  /// Text color for initials
  final Color? initialsColor;

  /// Whether to show online indicator
  final bool showOnlineIndicator;

  /// Whether user is online (only shown if showOnlineIndicator is true)
  final bool isOnline;

  /// Callback when avatar is tapped
  final VoidCallback? onTap;

  /// Custom placeholder widget while loading
  final Widget? placeholder;

  /// Custom error widget when image fails to load
  final Widget? errorWidget;

  /// Border width (0 for no border)
  final double borderWidth;

  /// Border color
  final Color? borderColor;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.initials,
    this.size = AppAvatarSize.medium,
    this.customSize,
    this.backgroundColor,
    this.initialsColor,
    this.showOnlineIndicator = false,
    this.isOnline = false,
    this.onTap,
    this.placeholder,
    this.errorWidget,
    this.borderWidth = 0,
    this.borderColor,
  });

  double get _size => customSize ?? size.value;

  double get _fontSize {
    final s = _size;
    if (s <= 32) return 12;
    if (s <= 44) return 14;
    if (s <= 56) return 18;
    if (s <= 80) return 24;
    return 32;
  }

  double get _iconSize {
    final s = _size;
    if (s <= 32) return 16;
    if (s <= 44) return 20;
    if (s <= 56) return 24;
    if (s <= 80) return 32;
    return 48;
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar = _buildAvatar();

    if (showOnlineIndicator) {
      avatar = Stack(
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: _size * 0.25,
              height: _size * 0.25,
              decoration: BoxDecoration(
                color: isOnline ? AppColors.success : AppColors.gray400,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: avatar,
      );
    }

    return avatar;
  }

  Widget _buildAvatar() {
    final bgColor = backgroundColor ?? AppColors.secondaryKiko;
    final border = borderWidth > 0
        ? Border.all(
            color: borderColor ?? AppColors.white,
            width: borderWidth,
          )
        : null;

    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
        border: border,
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildContent(bgColor),
    );
  }

  Widget _buildContent(Color bgColor) {
    // Priority: imageUrl > assetPath > initials > icon
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return _buildNetworkImage(bgColor);
    }

    if (assetPath != null && assetPath!.isNotEmpty) {
      return _buildAssetImage(bgColor);
    }

    if (initials != null && initials!.isNotEmpty) {
      return _buildInitials();
    }

    return _buildIconFallback();
  }

  Widget _buildNetworkImage(Color bgColor) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: BoxFit.cover,
      width: _size,
      height: _size,
      placeholder: (context, url) =>
          placeholder ?? _buildLoadingIndicator(bgColor),
      errorWidget: (context, url, error) =>
          errorWidget ?? _buildFallbackContent(),
    );
  }

  Widget _buildAssetImage(Color bgColor) {
    return Image.asset(
      assetPath!,
      fit: BoxFit.cover,
      width: _size,
      height: _size,
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? _buildFallbackContent();
      },
    );
  }

  Widget _buildInitials() {
    final displayInitials = _getDisplayInitials();
    return Center(
      child: Text(
        displayInitials,
        style: TextStyle(
          color: initialsColor ?? AppColors.textPrimaryKiko,
          fontSize: _fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _getDisplayInitials() {
    if (initials == null || initials!.isEmpty) return '';
    final parts = initials!.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return initials!.substring(0, initials!.length >= 2 ? 2 : 1).toUpperCase();
  }

  Widget _buildIconFallback() {
    return Center(
      child: Icon(
        Icons.person,
        size: _iconSize,
        color: initialsColor ?? AppColors.textPrimaryKiko,
      ),
    );
  }

  Widget _buildLoadingIndicator(Color bgColor) {
    return Container(
      color: bgColor,
      child: Center(
        child: SizedBox(
          width: _iconSize * 0.75,
          height: _iconSize * 0.75,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              initialsColor ?? AppColors.textPrimaryKiko,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackContent() {
    // When image fails, try initials, then icon
    if (initials != null && initials!.isNotEmpty) {
      return _buildInitials();
    }
    return _buildIconFallback();
  }
}

/// Avatar with edit overlay button
class AppAvatarEditable extends StatelessWidget {
  /// The avatar to display
  final AppAvatar avatar;

  /// Callback when edit button is tapped
  final VoidCallback? onEditTap;

  /// Icon to show in edit button
  final IconData editIcon;

  const AppAvatarEditable({
    super.key,
    required this.avatar,
    this.onEditTap,
    this.editIcon = Icons.camera_alt,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = avatar.customSize ?? avatar.size.value;
    final buttonSize = avatarSize * 0.35;
    final iconSize = buttonSize * 0.6;

    return Stack(
      children: [
        avatar,
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: onEditTap,
            child: Container(
              width: buttonSize,
              height: buttonSize,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white,
                  width: 2,
                ),
              ),
              child: Icon(
                editIcon,
                size: iconSize,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Avatar group showing multiple avatars stacked
class AppAvatarGroup extends StatelessWidget {
  /// List of avatar configs to display
  final List<AppAvatarConfig> avatars;

  /// Maximum number of avatars to show
  final int maxDisplay;

  /// Size of each avatar
  final AppAvatarSize size;

  /// Overlap amount between avatars
  final double overlap;

  const AppAvatarGroup({
    super.key,
    required this.avatars,
    this.maxDisplay = 4,
    this.size = AppAvatarSize.small,
    this.overlap = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    final displayCount =
        avatars.length > maxDisplay ? maxDisplay : avatars.length;
    final hasMore = avatars.length > maxDisplay;
    final extraCount = avatars.length - maxDisplay;
    final avatarSize = size.value;
    final overlapOffset = avatarSize * (1 - overlap);

    return SizedBox(
      width: (displayCount + (hasMore ? 1 : 0)) * overlapOffset + avatarSize * overlap,
      height: avatarSize,
      child: Stack(
        children: [
          for (int i = 0; i < displayCount; i++)
            Positioned(
              left: i * overlapOffset,
              child: AppAvatar(
                imageUrl: avatars[i].imageUrl,
                assetPath: avatars[i].assetPath,
                initials: avatars[i].initials,
                size: size,
                borderWidth: 2,
                borderColor: AppColors.white,
              ),
            ),
          if (hasMore)
            Positioned(
              left: displayCount * overlapOffset,
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  color: AppColors.gray200,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '+$extraCount',
                    style: TextStyle(
                      color: AppColors.gray700,
                      fontSize: avatarSize * 0.35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Configuration for a single avatar in a group
class AppAvatarConfig {
  final String? imageUrl;
  final String? assetPath;
  final String? initials;

  const AppAvatarConfig({
    this.imageUrl,
    this.assetPath,
    this.initials,
  });
}
