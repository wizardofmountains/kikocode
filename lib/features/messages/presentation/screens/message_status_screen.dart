import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/kiko_typography.dart';
import '../../../../core/components/atoms/app_avatar.dart';
import '../providers/messages_providers.dart';
import '../../domain/models/models.dart';
import '../widgets/group_message_card.dart';
import '../widgets/chat_list_item.dart';
import '../widgets/message_fab.dart';
import '../../../home/presentation/widgets/bottom_nav_bar.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../../auth/providers/avatar_providers.dart';

/// Main messages overview screen with group messages and chats
/// Features: Custom header, group message status, individual chats, integrated tab bar
class MessageStatusScreen extends ConsumerStatefulWidget {
  const MessageStatusScreen({super.key});

  @override
  ConsumerState<MessageStatusScreen> createState() =>
      _MessageStatusScreenState();
}

class _MessageStatusScreenState extends ConsumerState<MessageStatusScreen> {
  int _selectedTabIndex = 3; // Messages tab selected

  void _onTabTap(int index) {
    setState(() {
      _selectedTabIndex = index;
    });

    // Navigate based on tab
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        // TODO: Navigate to calendar
        break;
      case 2:
        // TODO: Navigate to teams
        break;
      case 3:
        // Already on messages
        break;
      case 4:
        // TODO: Navigate to settings
        break;
    }
  }

  void _onFabPressed() {
    _showComposeDialog();
  }

  void _showComposeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColors.surfaceHighest,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  'Neue Nachricht',
                  style: KikoTypography.withColor(
                    KikoTypography.appHeadline,
                    AppColors.textPrimaryKiko,
                  ),
                ),
                const SizedBox(height: 24),

                // Group Message Option
                _buildComposeOption(
                  icon: Coolicons.user_circle,
                  title: 'Gruppennachricht',
                  description: 'Nachricht an eine oder mehrere Gruppen',
                  onTap: () {
                    Navigator.of(context).pop();
                    this.context.push('/message-compose');
                  },
                ),
                const SizedBox(height: 16),

                // Individual Chat Option
                _buildComposeOption(
                  icon: Coolicons.message,
                  title: 'Chat',
                  description: 'Nachricht an ein einzelnes Kind',
                  onTap: () {
                    Navigator.of(context).pop();
                    // TODO: Navigate to individual chat selection
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Chat-Funktion wird bald verfügbar sein'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Cancel Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: AppColors.primaryKiko,
                      foregroundColor: AppColors.surfaceHighest,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Abbrechen',
                      style: KikoTypography.withColor(
                        KikoTypography.appBody,
                        AppColors.surfaceHighest,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildComposeOption({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceHigh,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.surfaceLow,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryKiko.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primaryKiko,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: KikoTypography.withColor(
                      KikoTypography.appBody,
                      AppColors.textPrimaryKiko,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: KikoTypography.withColor(
                      KikoTypography.appFootnote,
                      AppColors.captionKiko,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Coolicons.chevron_right,
              color: AppColors.captionKiko,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showPhoneDialog(String childId, String childName) {
    final guardiansAsync = ref.read(guardiansForChildProvider(childId));

    guardiansAsync.whenData((guardians) {
      if (guardians.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Keine Kontakte gefunden'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          String? selectedPhone;

          return StatefulBuilder(
            builder: (dialogContext, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: AppColors.surfaceHighest,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        'Anruf',
                        style: KikoTypography.withColor(
                          KikoTypography.appHeadline,
                          AppColors.textPrimaryKiko,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Kind: $childName',
                        style: KikoTypography.withColor(
                          KikoTypography.appFootnote,
                          AppColors.captionKiko,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Guardian phone options
                      ...guardians.map((guardian) {
                        if (guardian.phone == null) return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedPhone = guardian.phone;
                              });
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: selectedPhone == guardian.phone
                                    ? AppColors.primaryLightKiko
                                    : AppColors.surfaceHigh,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: selectedPhone == guardian.phone
                                      ? AppColors.primaryKiko
                                      : AppColors.surfaceLow,
                                  width:
                                      selectedPhone == guardian.phone ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: selectedPhone == guardian.phone
                                        ? AppColors.primaryKiko
                                        : AppColors.textPrimaryKiko,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          guardian.fullName,
                                          style: KikoTypography.withColor(
                                            KikoTypography.appBody,
                                            AppColors.textPrimaryKiko,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${guardian.relationshipLabel}${guardian.isPrimaryContact ? ' • Hauptkontakt' : ''}',
                                          style: KikoTypography.withColor(
                                            KikoTypography.appCaption1,
                                            AppColors.captionKiko,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          guardian.phone!,
                                          style: KikoTypography.withColor(
                                            KikoTypography.appFootnote,
                                            AppColors.textPrimaryKiko,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 12),
                      // Buttons
                      Row(
                        children: [
                          // Cancel button
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(),
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                side: BorderSide(
                                  color: AppColors.surfaceLow,
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Abbrechen',
                                style: KikoTypography.withColor(
                                  KikoTypography.appBody,
                                  AppColors.textPrimaryKiko,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Call button - disabled if no phone selected
                          Expanded(
                            child: ElevatedButton(
                              onPressed: selectedPhone != null
                                  ? () {
                                      // TODO: Implement actual call functionality with selectedPhone
                                      Navigator.of(dialogContext).pop();
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: AppColors.primaryKiko,
                                disabledBackgroundColor: AppColors.surfaceLow,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Anrufen',
                                style: KikoTypography.withColor(
                                  KikoTypography.appBody,
                                  selectedPhone != null
                                      ? AppColors.surfaceHighest
                                      : AppColors.captionKiko,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }

  void _showInfoDialog(String childId, String childName, String emoji) {
    final guardiansAsync = ref.read(guardiansForChildProvider(childId));

    guardiansAsync.whenData((guardians) {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: AppColors.surfaceHighest,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with child info
                    Row(
                      children: [
                        Text(
                          emoji,
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Angehörige',
                                style: KikoTypography.withColor(
                                  KikoTypography.appHeadline,
                                  AppColors.textPrimaryKiko,
                                ),
                              ),
                              Text(
                                'Kind: $childName',
                                style: KikoTypography.withColor(
                                  KikoTypography.appFootnote,
                                  AppColors.captionKiko,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Guardian cards
                    ...guardians.map((guardian) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildParentCard(guardian),
                        )),
                    const SizedBox(height: 16),
                    // Close button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: AppColors.primaryKiko,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Schließen',
                          style: KikoTypography.withColor(
                            KikoTypography.appBody,
                            AppColors.surfaceHighest,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildParentCard(Guardian guardian) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.surfaceLow,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: AppColors.textPrimaryKiko,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                guardian.relationshipLabel,
                style: KikoTypography.withColor(
                  KikoTypography.appFootnote,
                  AppColors.captionKiko,
                ),
              ),
              if (guardian.isPrimaryContact) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryKiko.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Hauptkontakt',
                    style: KikoTypography.withColor(
                      KikoTypography.appCaption1,
                      AppColors.primaryKiko,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            guardian.fullName,
            style: KikoTypography.withColor(
              KikoTypography.appBody,
              AppColors.textPrimaryKiko,
            ),
          ),
          if (guardian.phone != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.phone,
                  color: AppColors.captionKiko,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  guardian.phone!,
                  style: KikoTypography.withColor(
                    KikoTypography.appFootnote,
                    AppColors.textPrimaryKiko,
                  ),
                ),
              ],
            ),
          ],
          if (guardian.email != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: AppColors.captionKiko,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    guardian.email!,
                    style: KikoTypography.withColor(
                      KikoTypography.appFootnote,
                      AppColors.textPrimaryKiko,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
          if (guardian.address != null) ...[
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.captionKiko,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    guardian.address!,
                    style: KikoTypography.withColor(
                      KikoTypography.appFootnote,
                      AppColors.textPrimaryKiko,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupMessagesAsync = ref.watch(groupMessagesWithStatsProvider);
    final conversationsAsync = ref.watch(conversationsProvider);
    final profileAsync = ref.watch(currentProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      body: Stack(
        children: [
          // Main content with scroll
          SingleChildScrollView(
            child: SafeArea(
              bottom: false, // Tab bar handles bottom safe area
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Logo and Profile Picture
                  Container(
                    color: AppColors.surfaceBase,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        // Logo
                        SvgPicture.asset(
                          'assets/images/LogoLight.svg',
                          height: 60,
                          width: 149.76,
                          allowDrawingOutsideViewBox: true,
                        ),
                        const Spacer(),

                        // Profile Picture
                        profileAsync.when(
                          data: (profile) => AppAvatar(
                            imageUrl: profile?.avatarUrl?.networkUrl,
                            assetPath: profile?.avatarUrl?.assetPath,
                            initials: profile?.fullName,
                            customSize: 75,
                            backgroundColor: AppColors.surfaceLow,
                          ),
                          loading: () => Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.surfaceLow,
                            ),
                          ),
                          error: (e, s) => AppAvatar(
                            customSize: 75,
                            backgroundColor: AppColors.surfaceLow,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),

                        // Title with Plus Button
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Meine Nachrichten',
                              style: KikoTypography.withColor(
                                KikoTypography.appTitle1,
                                AppColors.primaryKiko,
                              ),
                            ),
                            const Spacer(),
                            MessageFab(
                              onPressed: _onFabPressed,
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Group Messages Card
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceHighest,
                            border: Border.all(
                              color: AppColors.surfaceLow,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gruppennachrichten',
                                style: KikoTypography.withColor(
                                  KikoTypography.appHeadline,
                                  AppColors.textPrimaryKiko,
                                ),
                              ),
                              const SizedBox(height: 20),
                              groupMessagesAsync.when(
                                data: (groupMessages) =>
                                    _buildGroupMessagesList(groupMessages),
                                loading: () => const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                error: (error, stack) => _buildErrorWidget(
                                  'Fehler beim Laden',
                                  () => ref.invalidate(groupMessagesWithStatsProvider),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Chats Card
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceHighest,
                            border: Border.all(
                              color: AppColors.surfaceLow,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chats',
                                style: KikoTypography.withColor(
                                  KikoTypography.appHeadline,
                                  AppColors.textPrimaryKiko,
                                ),
                              ),
                              const SizedBox(height: 20),
                              conversationsAsync.when(
                                data: (conversations) =>
                                    _buildChatsList(conversations),
                                loading: () => const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                error: (error, stack) => _buildErrorWidget(
                                  'Fehler beim Laden',
                                  () => ref.invalidate(conversationsProvider),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Bottom padding for navigation bar
                        const SizedBox(height: 90),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3, // Nachrichten-Tab ist aktiv
        messageBadgeCount: 6, // Badge für ungelesene Nachrichten
      ),
    );
  }

  Widget _buildGroupMessagesList(List<Map<String, dynamic>> groupMessages) {
    if (groupMessages.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            'Keine Gruppennachrichten',
            style: KikoTypography.withColor(
              KikoTypography.appBody,
              AppColors.captionKiko,
            ),
          ),
        ),
      );
    }

    return Column(
      children: groupMessages.asMap().entries.map((entry) {
        final index = entry.key;
        final messageData = entry.value;
        final message = GroupMessage.fromJson(messageData);
        final readCount = messageData['read_count'] as int? ?? 0;
        final totalCount = messageData['total_recipients'] as int? ?? 0;
        final progress = messageData['progress'] as double? ?? 0.0;

        // Get group emoji from joined data
        final groupEmoji = message.group?.emoji ?? '';
        final displayTitle = message.title ?? message.content.substring(
          0,
          message.content.length > 30 ? 30 : message.content.length,
        );

        return Column(
          children: [
            GroupMessageCard(
              groupName: displayTitle,
              emoji: groupEmoji,
              receivedCount: readCount,
              totalCount: totalCount,
              progress: progress,
              onTap: () {
                context.push(
                  '/message/${Uri.encodeComponent(displayTitle)}',
                  extra: {
                    'groupIcon': groupEmoji,
                    'isGroupChat': true,
                    'groupMessageId': message.id,
                  },
                );
              },
            ),
            if (index < groupMessages.length - 1)
              Padding(
                padding: const EdgeInsets.only(
                  left: 58,
                  top: 8,
                  bottom: 8,
                ),
                child: Container(
                  height: 1,
                  color: AppColors.surfaceLow,
                ),
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildChatsList(List<PrivateConversation> conversations) {
    if (conversations.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            'Keine Chats',
            style: KikoTypography.withColor(
              KikoTypography.appBody,
              AppColors.captionKiko,
            ),
          ),
        ),
      );
    }

    return Column(
      children: conversations.asMap().entries.map((entry) {
        final index = entry.key;
        final conversation = entry.value;
        final childName = conversation.child?.firstName ?? 'Unbekannt';
        final emoji = _getEmojiForChild(childName);

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                final guardianName = conversation.guardian?.fullName ?? '';
                context.push(
                  '/message/${Uri.encodeComponent('Familie von $childName')}',
                  extra: {
                    'groupIcon': emoji,
                    'isGroupChat': false,
                    'childName': childName,
                    'childId': conversation.childId,
                    'conversationId': conversation.id,
                    'parentNames': guardianName,
                  },
                );
              },
              child: ChatListItem(
                name: childName,
                emoji: emoji,
                onCallTap: () => _showPhoneDialog(
                  conversation.childId,
                  childName,
                ),
                onInfoTap: () => _showInfoDialog(
                  conversation.childId,
                  childName,
                  emoji,
                ),
              ),
            ),
            if (index < conversations.length - 1)
              Padding(
                padding: const EdgeInsets.only(
                  left: 58,
                  top: 8,
                  bottom: 8,
                ),
                child: Container(
                  height: 1,
                  color: AppColors.surfaceLow,
                ),
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildErrorWidget(String message, VoidCallback onRetry) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.error,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: KikoTypography.withColor(
              KikoTypography.appFootnote,
              AppColors.error,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onRetry,
            child: const Text('Erneut versuchen'),
          ),
        ],
      ),
    );
  }

  String _getEmojiForChild(String name) {
    // Simple hash-based emoji selection for consistent child emojis
    final emojis = [
      '\u{1F466}\u{1F3FB}', // 👦🏻
      '\u{1F467}\u{1F3FD}', // 👧🏽
      '\u{1F466}\u{1F3FC}', // 👦🏼
      '\u{1F467}\u{1F3FB}', // 👧🏻
      '\u{1F466}\u{1F3FE}', // 👦🏾
    ];
    return emojis[name.hashCode.abs() % emojis.length];
  }
}
