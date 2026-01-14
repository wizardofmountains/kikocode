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
          'Wähle einen Betreff für deine Nachricht aus.',
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
                    onPressed: () => context.pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const Spacer(),
                  
                  // Logo
                  SvgPicture.asset(
                    'assets/images/LogoLight.svg',
                    height: 60,
                    width: 149.76,
                  ),
                  const Spacer(),
                  
                  // Profile Picture
                  CircleAvatar(
                    radius: 37.5,
                    backgroundColor: AppColors.gray300,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.gray500,
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
                      placeholder: 'Betreff',
                      onInfoTap: _showSubjectInfo,
                    ),
                    const SizedBox(height: 9),
                    
                    // Message Composer
                    MessageComposerField(
                      controller: _messageController,
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
    );
  }
}
