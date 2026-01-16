import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/kiko_typography.dart';
import '../providers/messages_providers.dart';
import '../../domain/models/models.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

class MessageScreen extends ConsumerStatefulWidget {
  final String groupName;
  final String groupIcon;
  final List<Map<String, dynamic>>? initialMessages;
  final bool isGroupChat;
  final String? childName;
  final String? childId;
  final String? conversationId;
  final String? eventId;
  final String? groupMessageId;
  final String? parentNames;

  const MessageScreen({
    super.key,
    required this.groupName,
    required this.groupIcon,
    this.initialMessages,
    this.isGroupChat = true,
    this.childName,
    this.childId,
    this.conversationId,
    this.eventId,
    this.groupMessageId,
    this.parentNames,
  });

  @override
  ConsumerState<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _handleSendMessage(String message) async {
    if (widget.conversationId == null) return;

    try {
      final repository = ref.read(messagesRepositoryProvider);
      await repository.sendMessage(
        conversationId: widget.conversationId!,
        content: message,
      );

      // Scroll to bottom after message is sent
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollToBottom();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Senden: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showEventInfoDialog() {
    if (widget.eventId == null) return;

    final eventAsync = ref.read(eventProvider(widget.eventId!));

    eventAsync.whenData((event) {
      if (event == null) return;

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
                    // Title with event icon
                    Row(
                      children: [
                        Text(
                          widget.groupIcon,
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Event-Information',
                                style: KikoTypography.withColor(
                                  KikoTypography.appHeadline,
                                  AppColors.textPrimaryKiko,
                                ),
                              ),
                              Text(
                                event.title,
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

                    // Date & Time
                    _buildInfoRow(
                      icon: Icons.calendar_today,
                      label: 'Datum',
                      value: event.formattedDate,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      icon: Icons.access_time,
                      label: 'Uhrzeit',
                      value: event.formattedTimeRange,
                    ),
                    if (event.location != null) ...[
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        icon: Icons.location_on,
                        label: 'Ort',
                        value: event.location!,
                      ),
                    ],
                    if (event.description != null) ...[
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        icon: Icons.description,
                        label: 'Beschreibung',
                        value: event.description!,
                      ),
                    ],
                    const SizedBox(height: 24),

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

  void _showGroupMessageInfoDialog() {
    if (widget.groupMessageId == null) return;

    final messageAsync = ref.read(groupMessageProvider(widget.groupMessageId!));

    messageAsync.whenData((message) {
      if (message == null) return;

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
                    // Title with group icon
                    Row(
                      children: [
                        Text(
                          widget.groupIcon,
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nachricht-Information',
                                style: KikoTypography.withColor(
                                  KikoTypography.appHeadline,
                                  AppColors.textPrimaryKiko,
                                ),
                              ),
                              if (message.title != null)
                                Text(
                                  message.title!,
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

                    // Group
                    if (message.group != null)
                      _buildInfoRow(
                        icon: Icons.group,
                        label: 'Gruppe',
                        value: message.group!.name,
                      ),
                    const SizedBox(height: 12),

                    // Date & Time
                    _buildInfoRow(
                      icon: Icons.calendar_today,
                      label: 'Datum',
                      value: message.formattedDate,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      icon: Icons.access_time,
                      label: 'Uhrzeit',
                      value: message.formattedTime,
                    ),
                    const SizedBox(height: 12),

                    // Message type
                    _buildInfoRow(
                      icon: Icons.category,
                      label: 'Typ',
                      value: message.messageType.displayName,
                    ),
                    const SizedBox(height: 12),

                    // Content preview
                    _buildInfoRow(
                      icon: Icons.message,
                      label: 'Inhalt',
                      value: message.content,
                    ),

                    // Read statistics
                    if (message.totalRecipients != null) ...[
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        icon: Icons.visibility,
                        label: 'Gelesen',
                        value:
                            '${message.readCount ?? 0} von ${message.totalRecipients} Empfängern',
                      ),
                    ],
                    const SizedBox(height: 24),

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

  void _showGroupChatInfoDialog() {
    // If we have a groupMessageId, show group message info
    if (widget.groupMessageId != null) {
      _showGroupMessageInfoDialog();
    } else if (widget.eventId != null) {
      // Fall back to event info for backward compatibility
      _showEventInfoDialog();
    }
  }

  void _showPhoneDialog() {
    if (widget.childId == null) return;

    final guardiansAsync = ref.read(guardiansForChildProvider(widget.childId!));

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
                      Text(
                        'Anruf',
                        style: KikoTypography.withColor(
                          KikoTypography.appHeadline,
                          AppColors.textPrimaryKiko,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Kind: ${widget.childName}',
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
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(),
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                side: const BorderSide(
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
                          Expanded(
                            child: ElevatedButton(
                              onPressed: selectedPhone != null
                                  ? () {
                                      // TODO: Implement actual call functionality
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

  void _showInfoDialog() {
    if (widget.childId == null) return;

    final guardiansAsync = ref.read(guardiansForChildProvider(widget.childId!));

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
                    Row(
                      children: [
                        Text(
                          widget.groupIcon,
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
                                'Kind: ${widget.childName}',
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
                    ...guardians.map((guardian) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildParentCard(guardian),
                        )),
                    const SizedBox(height: 16),
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
              const Icon(
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
                const Icon(
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
                const Icon(
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
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.textPrimaryKiko,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: KikoTypography.withColor(
                    KikoTypography.appFootnote,
                    AppColors.captionKiko,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: KikoTypography.withColor(
                    KikoTypography.appBody,
                    AppColors.textPrimaryKiko,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use stream provider for real-time messages if we have a conversation ID
    final messagesAsync = widget.conversationId != null
        ? ref.watch(messagesStreamProvider(widget.conversationId!))
        : const AsyncValue<List<PrivateMessage>>.data([]);

    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceHighest,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Coolicons.chevron_left, color: AppColors.textPrimaryKiko),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primaryLightKiko,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  widget.groupIcon,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.groupName,
                    style: KikoTypography.withColor(
                      KikoTypography.appBody,
                      AppColors.textPrimaryKiko,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (!widget.isGroupChat && widget.parentNames != null)
                    Text(
                      widget.parentNames!,
                      style: KikoTypography.withColor(
                        KikoTypography.appFootnote,
                        AppColors.captionKiko,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // Call button (only for private chats)
          if (!widget.isGroupChat && widget.childId != null)
            IconButton(
              icon: const Icon(Icons.phone, color: AppColors.textPrimaryKiko),
              onPressed: _showPhoneDialog,
            ),
          // Info button (for both group and private chats)
          IconButton(
            icon: const Icon(Coolicons.info_circle,
                color: AppColors.textPrimaryKiko),
            onPressed:
                widget.isGroupChat ? _showGroupChatInfoDialog : _showInfoDialog,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.surfaceLow,
            height: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: messagesAsync.when(
              data: (messages) => _buildMessagesList(messages),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: AppColors.error,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Fehler beim Laden der Nachrichten',
                      style: KikoTypography.withColor(
                        KikoTypography.appBody,
                        AppColors.error,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        if (widget.conversationId != null) {
                          ref.invalidate(
                              messagesStreamProvider(widget.conversationId!));
                        }
                      },
                      child: const Text('Erneut versuchen'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Message input
          MessageInput(
            onSendMessage: _handleSendMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList(List<PrivateMessage> messages) {
    // Get current user ID to determine which messages are "mine"
    final currentUserId = ref.read(messagesRepositoryProvider).currentUserId;

    if (messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Coolicons.message,
              size: 64,
              color: AppColors.captionKiko.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Noch keine Nachrichten',
              style: KikoTypography.withColor(
                KikoTypography.appBody,
                AppColors.captionKiko,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Senden Sie die erste Nachricht!',
              style: KikoTypography.withColor(
                KikoTypography.appFootnote,
                AppColors.captionKiko,
              ),
            ),
          ],
        ),
      );
    }

    // Scroll to bottom when messages load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isCurrentUser = message.senderId == currentUserId;

        return MessageBubble(
          message: message.content,
          sender: message.senderName ?? (isCurrentUser ? 'Du' : 'Unbekannt'),
          time: message.formattedTime,
          isCurrentUser: isCurrentUser,
        );
      },
    );
  }
}
