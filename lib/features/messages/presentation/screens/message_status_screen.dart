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
      'icon': '🏮',
      'received': 10,
      'total': 20,
      'progress': 0.50,
    },
    {
      'name': 'Gemüsebuffet',
      'icon': '🥗',
      'received': 5,
      'total': 20,
      'progress': 0.25,
    },
    {
      'name': 'Pyjamaparty',
      'icon': '🎉',
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
    context.push('/message-compose');
  }

  void _showPhoneDialog(String name) {
    final parentInfo = _getParentInfo(name);
    
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
                  'Kind: $name',
                  style: KikoTypography.withColor(
                    KikoTypography.appFootnote,
                    AppColors.captionKiko,
                  ),
                ),
                const SizedBox(height: 24),
                // Mother's phone number (Primary contact)
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
                    children: [
                      const Icon(
                        Icons.phone,
                        color: AppColors.textPrimaryKiko,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              parentInfo['mother']!,
                              style: KikoTypography.withColor(
                                KikoTypography.appBody,
                                AppColors.textPrimaryKiko,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Mutter • Hauptkontakt',
                              style: KikoTypography.withColor(
                                KikoTypography.appCaption1,
                                AppColors.captionKiko,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              parentInfo['motherPhone']!,
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
                const SizedBox(height: 12),
                // Father's phone number (Secondary contact)
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
                    children: [
                      const Icon(
                        Icons.phone,
                        color: AppColors.textPrimaryKiko,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              parentInfo['father']!,
                              style: KikoTypography.withColor(
                                KikoTypography.appBody,
                                AppColors.textPrimaryKiko,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Vater • Zweitkontakt',
                              style: KikoTypography.withColor(
                                KikoTypography.appCaption1,
                                AppColors.captionKiko,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              parentInfo['fatherPhone']!,
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

  // Generate mockup messages for group chats (events)
  List<Map<String, dynamic>> _getGroupChatMessages(String eventName) {
    switch (eventName) {
      case 'Laternenwanderung':
        return [
          {
            'message': 'Hallo zusammen! Die Laternenwanderung findet am Freitag um 18:00 Uhr statt.',
            'sender': 'Kindergarten Team',
            'time': '14:30',
            'isCurrentUser': false,
          },
          {
            'message': 'Bitte bringt warme Kleidung und eure Laternen mit! 🏮',
            'sender': 'Kindergarten Team',
            'time': '14:31',
            'isCurrentUser': false,
          },
          {
            'message': 'Können wir helfen beim Aufbau?',
            'sender': 'Maria Schmidt',
            'time': '15:10',
            'isCurrentUser': false,
          },
          {
            'message': 'Das wäre super! Wir treffen uns um 17:30 Uhr zum Aufbau.',
            'sender': 'Kindergarten Team',
            'time': '15:15',
            'isCurrentUser': false,
          },
          {
            'message': 'Andreas freut sich schon sehr darauf! Wir sind dabei. 😊',
            'sender': 'Du',
            'time': '15:45',
            'isCurrentUser': true,
          },
        ];
      case 'Gemüsebuffet':
        return [
          {
            'message': 'Liebe Eltern, nächste Woche veranstalten wir ein Gemüsebuffet! 🥗',
            'sender': 'Kindergarten Team',
            'time': '10:00',
            'isCurrentUser': false,
          },
          {
            'message': 'Jede Familie kann eine Gemüseplatte mitbringen.',
            'sender': 'Kindergarten Team',
            'time': '10:01',
            'isCurrentUser': false,
          },
          {
            'message': 'Ich bringe Karotten und Gurken mit!',
            'sender': 'Sarah Müller',
            'time': '10:30',
            'isCurrentUser': false,
          },
          {
            'message': 'Wir machen einen Paprika-Dip dazu!',
            'sender': 'Julia Weber',
            'time': '11:15',
            'isCurrentUser': false,
          },
          {
            'message': 'Super Ideen! Ich kümmere mich um Tomaten und Radieschen.',
            'sender': 'Du',
            'time': '12:00',
            'isCurrentUser': true,
          },
        ];
      case 'Pyjamaparty':
        return [
          {
            'message': 'PYJAMAPARTY am Samstag! 🎉',
            'sender': 'Kindergarten Team',
            'time': '09:00',
            'isCurrentUser': false,
          },
          {
            'message': 'Die Kinder dürfen ihre Lieblingspyjamas und Kuscheltiere mitbringen!',
            'sender': 'Kindergarten Team',
            'time': '09:01',
            'isCurrentUser': false,
          },
          {
            'message': 'Gibt es auch Übernachtung?',
            'sender': 'Thomas Schmidt',
            'time': '09:45',
            'isCurrentUser': false,
          },
          {
            'message': 'Nein, wir feiern von 14:00 bis 18:00 Uhr. Die Kinder können aber im Pyjama kommen! 😊',
            'sender': 'Kindergarten Team',
            'time': '10:00',
            'isCurrentUser': false,
          },
          {
            'message': 'Kevin kann es kaum erwarten! Wir sind dabei! 🎊',
            'sender': 'Du',
            'time': '10:30',
            'isCurrentUser': true,
          },
        ];
      default:
        return [];
    }
  }

  // Generate mockup messages for private chats (with parents)
  List<Map<String, dynamic>> _getPrivateChatMessages(String childName) {
    final parentInfo = _getParentInfo(childName);
    
    switch (childName) {
      case 'Andreas':
        return [
          {
            'message': 'Guten Tag Frau Schmidt! Wie geht es Andreas heute?',
            'sender': 'Du',
            'time': '08:15',
            'isCurrentUser': true,
          },
          {
            'message': 'Hallo! Andreas geht es gut, er hat heute morgen super gefrühstückt. 😊',
            'sender': parentInfo['mother']!,
            'time': '08:20',
            'isCurrentUser': false,
          },
          {
            'message': 'Das freut mich! Er ist heute sehr aktiv und spielt gerade mit den Bauklötzen.',
            'sender': 'Du',
            'time': '10:30',
            'isCurrentUser': true,
          },
          {
            'message': 'Wunderbar! Könnten Sie mir bitte Bescheid geben, wenn er seinen Mittagsschlaf macht?',
            'sender': parentInfo['mother']!,
            'time': '10:35',
            'isCurrentUser': false,
          },
          {
            'message': 'Natürlich, mache ich gerne!',
            'sender': 'Du',
            'time': '10:37',
            'isCurrentUser': true,
          },
        ];
      case 'Barbara':
        return [
          {
            'message': 'Hallo! Barbara hat heute ihr Lieblingsbuch mitgebracht. 📚',
            'sender': parentInfo['mother']!,
            'time': '07:45',
            'isCurrentUser': false,
          },
          {
            'message': 'Oh wie schön! Wir werden es später in der Lesezeit anschauen.',
            'sender': 'Du',
            'time': '08:00',
            'isCurrentUser': true,
          },
          {
            'message': 'Barbara hat gerade ein tolles Bild gemalt! Ich schicke gleich ein Foto. 🎨',
            'sender': 'Du',
            'time': '11:15',
            'isCurrentUser': true,
          },
          {
            'message': 'Vielen Dank! Ich freue mich schon darauf! 😊',
            'sender': parentInfo['mother']!,
            'time': '11:20',
            'isCurrentUser': false,
          },
          {
            'message': 'Können wir morgen etwas früher kommen? Wir haben einen Arzttermin.',
            'sender': parentInfo['father']!,
            'time': '14:30',
            'isCurrentUser': false,
          },
          {
            'message': 'Ja natürlich, kein Problem!',
            'sender': 'Du',
            'time': '14:35',
            'isCurrentUser': true,
          },
        ];
      case 'Kevin':
        return [
          {
            'message': 'Guten Morgen! Kevin war gestern etwas erkältet. Geht es ihm heute besser?',
            'sender': 'Du',
            'time': '08:00',
            'isCurrentUser': true,
          },
          {
            'message': 'Ja, viel besser! Die Nase läuft noch ein bisschen, aber Fieber hat er keines mehr.',
            'sender': parentInfo['mother']!,
            'time': '08:05',
            'isCurrentUser': false,
          },
          {
            'message': 'Gut zu hören! Ich behalte ihn im Auge und gebe Bescheid falls sich etwas ändert.',
            'sender': 'Du',
            'time': '08:10',
            'isCurrentUser': true,
          },
          {
            'message': 'Danke! Kevin hat übrigens seine Taschentücher im Rucksack.',
            'sender': parentInfo['mother']!,
            'time': '08:12',
            'isCurrentUser': false,
          },
          {
            'message': 'Kevin spielt jetzt draußen und hat viel Spaß beim Schaukeln! 😊',
            'sender': 'Du',
            'time': '10:45',
            'isCurrentUser': true,
          },
          {
            'message': 'Das ist schön! Frische Luft tut ihm gut. 🌞',
            'sender': parentInfo['father']!,
            'time': '10:50',
            'isCurrentUser': false,
          },
        ];
      default:
        return [
          {
            'message': 'Hallo! Schön Sie kennenzulernen.',
            'sender': 'Du',
            'time': '09:00',
            'isCurrentUser': true,
          },
        ];
    }
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
                                    emoji: message['icon'],
                                    receivedCount: message['received'],
                                    totalCount: message['total'],
                                    progress: message['progress'],
                                    onTap: () {
                                      // Navigate to group chat with event-specific data
                                      context.push(
                                        '/message/${Uri.encodeComponent(message['name'])}',
                                        extra: {
                                          'groupIcon': message['icon'],
                                          'isGroupChat': true,
                                          'messages': _getGroupChatMessages(message['name']),
                                        },
                                      );
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
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to private chat with parents
                                      final parentInfo = _getParentInfo(chat['name']);
                                      context.push(
                                        '/message/${Uri.encodeComponent('Familie ${chat['name']}')}',
                                        extra: {
                                          'groupIcon': chat['emoji'],
                                          'isGroupChat': false,
                                          'childName': chat['name'],
                                          'parentNames': '${parentInfo['mother']} & ${parentInfo['father']}',
                                          'messages': _getPrivateChatMessages(chat['name']),
                                        },
                                      );
                                    },
                                    child: ChatListItem(
                                      name: chat['name'],
                                      emoji: chat['emoji'],
                                      onCallTap: () => _showPhoneDialog(chat['name']),
                                      onInfoTap: () => _showInfoDialog(
                                        chat['name'],
                                        chat['emoji'],
                                      ),
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
