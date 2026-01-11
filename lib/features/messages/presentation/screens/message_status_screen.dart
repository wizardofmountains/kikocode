import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/spacing.dart';
import '../../../../core/design_system/kiko_typography.dart';
import '../widgets/group_message_card.dart';
import '../widgets/chat_list_item.dart';

/// Main messages overview screen with group messages and chats
/// Features: Tab bar navigation, group message status, individual chats
class MessageStatusScreen extends StatefulWidget {
  const MessageStatusScreen({super.key});

  @override
  State<MessageStatusScreen> createState() => _MessageStatusScreenState();
}

class _MessageStatusScreenState extends State<MessageStatusScreen> {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar with Logo and Profile Picture
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
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      
                      // Title
                      Text(
                        'Meine Nachrichten',
                        style: KikoTypography.withColor(
                          KikoTypography.appTitle1,
                          AppColors.primaryKiko,
                        ),
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
                          borderRadius: BorderRadius.circular(
                            AppSpacing.cardRadius,
                          ),
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
                            }).toList(),
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
                          borderRadius: BorderRadius.circular(
                            AppSpacing.cardRadius,
                          ),
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
                                    onCallTap: () {
                                      // Handle call
                                    },
                                    onInfoTap: () {
                                      // Show info
                                    },
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
                            }).toList(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 140), // Space for tab bar
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
