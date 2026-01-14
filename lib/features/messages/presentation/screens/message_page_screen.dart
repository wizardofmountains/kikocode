import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/kiko_typography.dart';
import '../widgets/message_composer_field.dart';
import '../widgets/group_selection_field.dart';
import '../widgets/subject_input_field.dart';
import '../../domain/models/group.dart';
import '../../../home/presentation/widgets/bottom_nav_bar.dart';

/// Screen for composing a new message
/// Features: Group selection, Subject selection, Message text area
class MessagePageScreen extends StatefulWidget {
  const MessagePageScreen({super.key});

  @override
  State<MessagePageScreen> createState() => _MessagePageScreenState();
}

class _MessagePageScreenState extends State<MessagePageScreen> {
  List<Group> _selectedGroups = [];
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  
  // FocusNodes for keyboard control
  final FocusNode _subjectFocusNode = FocusNode();
  final FocusNode _messageFocusNode = FocusNode();

  final List<Group> _groups = [
    const Group(
      id: '1',
      name: 'Schmetterling',
      emoji: '🦋',
      iconColor: AppColors.secondaryKiko,
    ),
    const Group(
      id: '2',
      name: 'Marienkäfer',
      emoji: '🐞',
      iconColor: AppColors.secondaryKiko,
    ),
    const Group(
      id: '3',
      name: 'Papagei',
      emoji: '🦜',
      iconColor: AppColors.secondaryKiko,
    ),
  ];

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    _subjectFocusNode.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_selectedGroups.isNotEmpty &&
        _subjectController.text.trim().isNotEmpty &&
        _messageController.text.trim().isNotEmpty) {
      // TODO: Implement actual message sending
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Nachricht an ${_selectedGroups.length} Gruppe(n) gesendet!',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      
      // Navigate to message overview
      context.go('/message-overview');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte fülle alle Felder aus'),
          duration: Duration(seconds: 2),
        ),
      );
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

  void _handleBackPress() {
    if (_hasUnsavedChanges()) {
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
                          onPressed: () => Navigator.of(context).pop(),
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
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                            context.pop(); // Go back
                          },
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
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surfaceLow,
                      image: const DecorationImage(
                        image: NetworkImage(
                          'http://localhost:3845/assets/65d3d9833026f2cd571bbbfb21edfa38e4d64489.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
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
                      groups: _groups,
                      selectedGroups: _selectedGroups,
                      onChanged: (groups) {
                        setState(() {
                          _selectedGroups = groups;
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3, // Nachrichten-Tab ist aktiv
        messageBadgeCount: 6, // Badge für ungelesene Nachrichten
      ),
    );
  }
}
