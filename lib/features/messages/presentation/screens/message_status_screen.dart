import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/kiko_typography.dart';
import '../widgets/group_message_card.dart';
import '../widgets/chat_list_item.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/message_fab.dart';

/// Main messages overview screen with group messages and chats
/// Features: Custom header, group message status, individual chats, integrated tab bar
class MessageStatusScreen extends StatefulWidget {
  const MessageStatusScreen({super.key});

  @override
  State<MessageStatusScreen> createState() => _MessageStatusScreenState();
}

class _MessageStatusScreenState extends State<MessageStatusScreen> {
  int _selectedTabIndex = 3; // Messages tab selected

  // Mock data for group messages
  final List<Map<String, dynamic>> _groupMessages = [
    {
      'name': 'Laternenwanderung',
      'received': 10,
      'total': 20,
      'progress': 0.50,
    },
    {
      'name': 'Gemüsebuffet',
      'received': 5,
      'total': 20,
      'progress': 0.25,
    },
    {
      'name': 'Pyjamaparty',
      'received': 15,
      'total': 20,
      'progress': 0.75,
    },
  ];

  // Mock data for chats
  final List<Map<String, dynamic>> _chats = [
    {'name': 'Andreas', 'emoji': '👦🏻'},
    {'name': 'Barbara', 'emoji': '👧🏽'},
    {'name': 'Kevin', 'emoji': '👦🏼'},
  ];

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
    context.go('/message-compose');
  }

  void _showPhoneDialog(String name) {
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
                  'Anruf',
                  style: KikoTypography.withColor(
                    KikoTypography.appHeadline,
                    AppColors.textPrimaryKiko,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: KikoTypography.withColor(
                    KikoTypography.appBody,
                    AppColors.textPrimaryKiko,
                  ),
                ),
                const SizedBox(height: 24),
                // Phone number
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceHigh,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.surfaceLow,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.phone,
                        color: AppColors.textPrimaryKiko,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '+43 664 123 4567',
                        style: KikoTypography.withColor(
                          KikoTypography.appBody,
                          AppColors.textPrimaryKiko,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Buttons
                Row(
                  children: [
                    // Cancel button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
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
                    // Call button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement actual call functionality
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: AppColors.primaryKiko,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Anrufen',
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
  }

  void _showInfoDialog(String childName, String emoji) {
    // Generate parent/guardian information based on child
    final parentInfo = _getParentInfo(childName);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                  // Parents info in compact format
                  _buildParentCard(
                    name: parentInfo['mother']!,
                    relation: 'Mutter',
                    phone: parentInfo['motherPhone']!,
                    email: parentInfo['motherEmail']!,
                  ),
                  const SizedBox(height: 12),
                  _buildParentCard(
                    name: parentInfo['father']!,
                    relation: 'Vater',
                    phone: parentInfo['fatherPhone']!,
                    email: parentInfo['fatherEmail']!,
                  ),
                  const SizedBox(height: 16),
                  // Address
                  _buildInfoRow(
                    icon: Icons.location_on,
                    label: 'Adresse',
                    value: parentInfo['address']!,
                  ),
                  const SizedBox(height: 24),
                  // Close button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
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
  }

  Map<String, String> _getParentInfo(String childName) {
    // Mock parent/guardian data based on child name
    switch (childName) {
      case 'Andreas':
        return {
          'mother': 'Maria Schmidt',
          'motherPhone': '+43 664 123 4567',
          'motherEmail': 'm.schmidt@example.com',
          'father': 'Thomas Schmidt',
          'fatherPhone': '+43 664 234 5678',
          'fatherEmail': 't.schmidt@example.com',
          'address': 'Hauptstraße 123\n1010 Wien',
        };
      case 'Barbara':
        return {
          'mother': 'Sarah Müller',
          'motherPhone': '+43 664 345 6789',
          'motherEmail': 's.mueller@example.com',
          'father': 'Michael Müller',
          'fatherPhone': '+43 664 456 7890',
          'fatherEmail': 'm.mueller@example.com',
          'address': 'Ringstraße 45\n1020 Wien',
        };
      case 'Kevin':
        return {
          'mother': 'Julia Weber',
          'motherPhone': '+43 664 567 8901',
          'motherEmail': 'j.weber@example.com',
          'father': 'Daniel Weber',
          'fatherPhone': '+43 664 678 9012',
          'fatherEmail': 'd.weber@example.com',
          'address': 'Mozartgasse 78\n1030 Wien',
        };
      default:
        return {
          'mother': 'Anna Mustermann',
          'motherPhone': '+43 664 111 2222',
          'motherEmail': 'a.mustermann@example.com',
          'father': 'Max Mustermann',
          'fatherPhone': '+43 664 222 3333',
          'fatherEmail': 'm.mustermann@example.com',
          'address': 'Beispielstraße 1\n1040 Wien',
        };
    }
  }

  Widget _buildParentCard({
    required String name,
    required String relation,
    required String phone,
    required String email,
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
                relation,
                style: KikoTypography.withColor(
                  KikoTypography.appFootnote,
                  AppColors.captionKiko,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: KikoTypography.withColor(
              KikoTypography.appBody,
              AppColors.textPrimaryKiko,
            ),
          ),
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
                phone,
                style: KikoTypography.withColor(
                  KikoTypography.appFootnote,
                  AppColors.textPrimaryKiko,
                ),
              ),
            ],
          ),
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
                  email,
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
                            ..._groupMessages.asMap().entries.map((entry) {
                              final index = entry.key;
                              final message = entry.value;
                              return Column(
                                children: [
                                  GroupMessageCard(
                                    groupName: message['name'],
                                    receivedCount: message['received'],
                                    totalCount: message['total'],
                                    progress: message['progress'],
                                    onTap: () {
                                      // Navigate to group message detail
                                    },
                                  ),
                                  if (index < _groupMessages.length - 1)
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
                            }),
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
                            ..._chats.asMap().entries.map((entry) {
                              final index = entry.key;
                              final chat = entry.value;
                              return Column(
                                children: [
                                  ChatListItem(
                                    name: chat['name'],
                                    emoji: chat['emoji'],
                                    onCallTap: () => _showPhoneDialog(chat['name']),
                                    onInfoTap: () => _showInfoDialog(
                                      chat['name'],
                                      chat['emoji'],
                                    ),
                                  ),
                                  if (index < _chats.length - 1)
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
                            }),
                            ],
                          ),
                        ),

                        // Bottom padding for tab bar
                        const SizedBox(height: 140),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tab Bar positioned at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomTabBar(
              selectedIndex: _selectedTabIndex,
              onTap: _onTabTap,
              badgeCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}
