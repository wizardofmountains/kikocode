import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/kiko_typography.dart';
import '../../../../core/components/atoms/app_avatar.dart';
import '../widgets/message_composer_field.dart';
import '../widgets/group_selection_field.dart';
import '../widgets/subject_input_field.dart';
import '../../domain/models/group.dart';
import '../providers/messages_providers.dart';
import '../../../home/presentation/widgets/bottom_nav_bar.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../../auth/providers/avatar_providers.dart';

/// Screen for composing a new message
/// Features: Group selection, Subject selection, Message text area
class MessagePageScreen extends ConsumerStatefulWidget {
  const MessagePageScreen({super.key});

  @override
  ConsumerState<MessagePageScreen> createState() => _MessagePageScreenState();
}

class _MessagePageScreenState extends ConsumerState<MessagePageScreen> {
  List<Group> _selectedGroups = [];
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // FocusNodes for keyboard control
  final FocusNode _subjectFocusNode = FocusNode();
  final FocusNode _messageFocusNode = FocusNode();

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    _subjectFocusNode.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  bool _isSending = false;

  Future<void> _sendMessage() async {
    if (_selectedGroups.isEmpty ||
        _subjectController.text.trim().isEmpty ||
        _messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte fülle alle Felder aus'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_isSending) return;

    setState(() {
      _isSending = true;
    });

    try {
      final repository = ref.read(groupMessagesRepositoryProvider);
      await repository.sendGroupMessageToMultiple(
        groupIds: _selectedGroups.map((g) => g.id).toList(),
        title: _subjectController.text.trim(),
        content: _messageController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Nachricht an ${_selectedGroups.length} Gruppe(n) gesendet!',
            ),
            duration: const Duration(seconds: 2),
          ),
        );

        // Invalidate the group messages provider to refresh the list
        ref.invalidate(groupMessagesWithStatsProvider);

        // Navigate to message overview
        context.go('/message-overview');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Senden: $e'),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  void _showGroupInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Gruppenauswahl',
          style: KikoTypography.appHeadline,
        ),
        content: Text(
          'Wähle die Gruppe(n) aus, an die du die Nachricht senden möchtest.',
          style: KikoTypography.appBody,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: KikoTypography.withColor(
                KikoTypography.appBody,
                AppColors.primaryKiko,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSubjectInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Betreff',
          style: KikoTypography.appHeadline,
        ),
        content: Text(
          'Gib einen Betreff für deine Nachricht ein.',
          style: KikoTypography.appBody,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: KikoTypography.withColor(
                KikoTypography.appBody,
                AppColors.primaryKiko,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _hasUnsavedChanges() {
    return _selectedGroups.isNotEmpty ||
        _subjectController.text.trim().isNotEmpty ||
        _messageController.text.trim().isNotEmpty;
  }

  Future<bool> _showDiscardDialog() async {
    if (!_hasUnsavedChanges()) {
      return true;
    }

    final result = await showDialog<bool>(
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
                // Warning Icon
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primaryKiko.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Coolicons.warning,
                    color: AppColors.primaryKiko,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  'Entwurf verwerfen?',
                  style: KikoTypography.withColor(
                    KikoTypography.appHeadline,
                    AppColors.textPrimaryKiko,
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  'Deine ungespeicherten Änderungen gehen verloren, wenn du fortfährst.',
                  style: KikoTypography.withColor(
                    KikoTypography.appBody,
                    AppColors.captionKiko,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Buttons
                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(
                            color: AppColors.primaryKiko,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Abbrechen',
                          style: KikoTypography.withColor(
                            KikoTypography.appBody,
                            AppColors.primaryKiko,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Discard Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
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
                          'Verwerfen',
                          style: KikoTypography.withColor(
                            KikoTypography.appBody,
                            AppColors.surfaceHighest,
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

    return result ?? false;
  }

  void _handleBackPress() async {
    final canNavigate = await _showDiscardDialog();
    if (canNavigate && context.mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupsAsync = ref.watch(groupsProvider);
    final profileAsync = ref.watch(currentProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar with Back Button, Logo and Profile Picture
            Container(
              color: AppColors.surfaceBase,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Row(
                children: [
                  // Back Button
                  IconButton(
                    icon: Icon(
                      Coolicons.chevron_left,
                      color: AppColors.textPrimaryKiko,
                      size: 28,
                    ),
                    onPressed: _handleBackPress,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const Spacer(),

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
            Expanded(
              child: groupsAsync.when(
                data: (groups) => SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),

                      // Title
                      Text(
                        'Neue Nachricht',
                        style: KikoTypography.withColor(
                          KikoTypography.appTitle1,
                          AppColors.primaryKiko,
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Group Selection
                      GroupSelectionField(
                        groups: groups,
                        selectedGroups: _selectedGroups,
                        onChanged: (selectedGroups) {
                          setState(() {
                            _selectedGroups = selectedGroups;
                          });
                        },
                        onInfoTap: _showGroupInfo,
                      ),
                      const SizedBox(height: 9),

                      // Subject Input
                      SubjectInputField(
                        controller: _subjectController,
                        focusNode: _subjectFocusNode,
                        placeholder: 'Betreff',
                        onInfoTap: _showSubjectInfo,
                      ),
                      const SizedBox(height: 9),

                      // Message Composer
                      MessageComposerField(
                        controller: _messageController,
                        focusNode: _messageFocusNode,
                        onSend: _sendMessage,
                        placeholder: 'Meine Nachricht ...',
                      ),

                      const SizedBox(height: 50),
                    ],
                  ),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Fehler beim Laden der Gruppen',
                        style: KikoTypography.withColor(
                          KikoTypography.appBody,
                          AppColors.error,
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
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3, // Nachrichten-Tab ist aktiv
        messageBadgeCount: 6, // Badge für ungelesene Nachrichten
        onNavigationAttempt: _showDiscardDialog,
      ),
    );
  }
}
