import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kikocode/core/constants/asset_paths.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'package:kikocode/core/components/atoms/app_avatar.dart';
import 'package:kikocode/core/components/molecules/molecules.dart';
import 'package:kikocode/features/auth/providers/auth_providers.dart';
import 'package:kikocode/features/auth/providers/avatar_providers.dart';
import '../widgets/groups_section.dart';
import '../widgets/bottom_nav_bar.dart';

class MainScreen extends ConsumerStatefulWidget {
  final String username;

  const MainScreen({
    super.key,
    required this.username,
  });

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int? _selectedMoodIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.all5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with logo and profile
                    _buildHeader(),
                    AppSpacing.v5,

                    // Greeting - centered
                    _buildGreeting(),
                    AppSpacing.v3,

                    // Mood emoji selector - centered
                    Center(child: _buildMoodSelector()),
                    AppSpacing.v5,

                    // Events section with border
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.surfaceLow, width: 2),
                        borderRadius: AppBorders.xl2,
                      ),
                      child: AppEventsCard(
                        title: 'Meine Ereignisse',
                        events: [
                          AppEventItem(
                            dateLabel: 'Heute',
                            eventName: 'Laternenwanderung',
                            isActive: true,
                          ),
                          AppEventItem(
                            dateLabel: 'Mi, 10.',
                            eventName: 'Gemüsebuffet',
                          ),
                          AppEventItem(
                            dateLabel: 'Do, 11.',
                            eventName: 'Pyjamaparty',
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.v5,

                    // Groups section
                    const GroupsSection(),
                    AppSpacing.v5,

                    // Bottom action cards with border
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionCard(
                            title: 'Meine\nAufgaben',
                            onTap: () {},
                          ),
                        ),
                        AppSpacing.h4,
                        Expanded(
                          child: _buildActionCard(
                            title: 'Abstimmung &\nUmfrage',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.v20, // Space for bottom nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(
        currentIndex: 0,
        messageBadgeCount: 6,
      ),
    );
  }

  Widget _buildHeader() {
    final profileAsync = ref.watch(profileStreamProvider);
    final uploadState = ref.watch(avatarUploadProvider);

    // Listen for upload state changes to show feedback
    ref.listen<AvatarUploadState>(avatarUploadProvider, (previous, next) {
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profilbild aktualisiert'),
            backgroundColor: AppColors.success,
          ),
        );
        ref.read(avatarUploadProvider.notifier).reset();
      } else if (next.isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage ?? 'Fehler beim Aktualisieren'),
            backgroundColor: AppColors.error,
          ),
        );
        ref.read(avatarUploadProvider.notifier).reset();
      }
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // KIKO Logo
        SvgPicture.asset(
          AssetPaths.logoLight,
          width: 150,
          height: 60,
        ),
        // Profile photo - connected to profile stream
        profileAsync.when(
          data: (profile) {
            final avatarUrl = profile?.avatarUrl;
            final isAsset = avatarUrl.isAssetAvatar;

            // Show loading indicator while uploading
            if (uploadState.isUploading) {
              return Stack(
                children: [
                  AppAvatar(
                    imageUrl: isAsset ? null : avatarUrl,
                    assetPath: avatarUrl.assetPath,
                    initials: profile?.name ?? widget.username,
                    size: AppAvatarSize.xlarge,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return AppAvatarEditable(
              avatar: AppAvatar(
                imageUrl: isAsset ? null : avatarUrl,
                assetPath: avatarUrl.assetPath,
                initials: profile?.name ?? widget.username,
                size: AppAvatarSize.xlarge,
              ),
              onEditTap: () => _showAvatarPicker(profile?.avatarUrl),
            );
          },
          loading: () => AppAvatar(
            initials: widget.username,
            size: AppAvatarSize.xlarge,
          ),
          error: (_, __) => AppAvatarEditable(
            avatar: AppAvatar(
              initials: widget.username,
              size: AppAvatarSize.xlarge,
            ),
            onEditTap: () => _showAvatarPicker(null),
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    final profileAsync = ref.watch(profileStreamProvider);
    final profileName = profileAsync.whenOrNull(
      data: (profile) => profile?.name,
    );
    // Use profile name if available, otherwise fallback to widget.username, then 'User'
    String displayName = 'User';
    if (profileName != null && profileName.isNotEmpty) {
      displayName = profileName;
    } else if (widget.username.isNotEmpty) {
      displayName = widget.username;
    }

    return Center(
      child: Text(
        'Hallo $displayName, wie geht\'s Dir heute?',
        style: AppTypography.bodyBase.copyWith(
          fontWeight: AppTypography.semiBold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Future<void> _showAvatarPicker(String? currentAvatarUrl) async {
    final result = await AppAvatarPicker.show(
      context,
      currentAvatarUrl: currentAvatarUrl,
      currentAssetPath: currentAvatarUrl.assetPath,
      showRemoveOption: currentAvatarUrl != null && currentAvatarUrl.isNotEmpty,
    );

    if (result == null) return;

    if (result.imageFile != null) {
      // User selected a photo from camera/gallery
      await ref.read(avatarUploadProvider.notifier).uploadCustomAvatar(result.imageFile!);
    } else if (result.assetPath != null) {
      // User selected a predefined avatar
      await ref.read(avatarUploadProvider.notifier).setPredefinedAvatar(result.assetPath!);
    } else if (result.removeAvatar) {
      // User wants to remove avatar
      await ref.read(avatarUploadProvider.notifier).clearAvatar();
    }
  }

  Widget _buildMoodSelector() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildMoodButton(0, FeatherIcons.frown), // sad face
        const SizedBox(width: 20),
        _buildMoodButton(1, FeatherIcons.meh), // neutral/meh face
        const SizedBox(width: 20),
        _buildMoodButton(2, FeatherIcons.smile), // happy face
      ],
    );
  }

  Widget _buildMoodButton(int index, IconData icon) {
    final isSelected = _selectedMoodIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMoodIndex = index;
        });
      },
      child: Icon(
        icon,
        size: 25,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.surfaceHighest,
          borderRadius: AppBorders.xl2,
          border: Border.all(color: AppColors.surfaceLow, width: 2),
          boxShadow: AppShadows.md,
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: AppTypography.bodyBase.copyWith(
              fontWeight: AppTypography.semiBold,
            ),
          ),
        ),
      ),
    );
  }
}

