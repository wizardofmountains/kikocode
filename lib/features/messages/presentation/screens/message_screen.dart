import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/kiko_typography.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

class MessageScreen extends StatefulWidget {
  final String groupName;
  final String groupIcon;
  final List<Map<String, dynamic>>? initialMessages;
  final bool isGroupChat;
  final String? childName;
  final String? parentNames;

  const MessageScreen({
    super.key,
    required this.groupName,
    required this.groupIcon,
    this.initialMessages,
    this.isGroupChat = true,
    this.childName,
    this.parentNames,
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late List<Map<String, dynamic>> _messages;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initialize messages from widget or use default
    _messages = widget.initialMessages ?? [
      {
        'message': 'Hallo! Willkommen im Chat.',
        'sender': 'Kindergarten Team',
        'time': '09:00',
        'isCurrentUser': false,
      },
    ];
    // Scroll to bottom after frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

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

  void _handleSendMessage(String message) {
    setState(() {
      _messages.add({
        'message': message,
        'sender': 'Anna',
        'time': _getCurrentTime(),
        'isCurrentUser': true,
      });
    });
    
    // Scroll to bottom after message is added
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollToBottom();
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  Map<String, String> _getEventInfo(String eventName) {
    // Mock event data based on event/group name
    switch (eventName) {
      case 'Laternenwanderung':
        return {
          'name': 'Laternenwanderung',
          'date': 'Freitag, 15. November 2024',
          'time': '18:00 - 20:00 Uhr',
          'location': 'Kindergarten Eingang',
          'description': 'Gemeinsame Laternenwanderung durch den Park mit anschließendem Punsch und Lebkuchen.',
          'bring': 'Laternen, warme Kleidung, gute Laune',
          'contact': 'Frau Müller (Leitung)',
          'phone': '+43 664 789 0123',
        };
      case 'Gemüsebuffet':
        return {
          'name': 'Gesundes Gemüsebuffet',
          'date': 'Mittwoch, 20. November 2024',
          'time': '10:00 - 12:00 Uhr',
          'location': 'Kindergarten Gruppenraum',
          'description': 'Die Kinder lernen verschiedene Gemüsesorten kennen und bereiten gemeinsam ein buntes Buffet vor.',
          'bring': 'Gemüseplatte oder Dip nach Wahl',
          'contact': 'Frau Weber (Pädagogin)',
          'phone': '+43 664 890 1234',
        };
      case 'Pyjamaparty':
        return {
          'name': 'Pyjamaparty',
          'date': 'Samstag, 25. November 2024',
          'time': '14:00 - 18:00 Uhr',
          'location': 'Kindergarten Turnraum',
          'description': 'Eine gemütliche Pyjamaparty mit Spielen, Geschichten und einer kleinen Jause. Die Kinder dürfen im Pyjama kommen!',
          'bring': 'Pyjama, Kuscheltier, Hausschuhe',
          'contact': 'Frau Schmidt (Pädagogin)',
          'phone': '+43 664 901 2345',
        };
      default:
        return {
          'name': eventName,
          'date': 'Termin wird noch bekannt gegeben',
          'time': 'Uhrzeit wird noch bekannt gegeben',
          'location': 'Kindergarten',
          'description': 'Weitere Informationen folgen in Kürze.',
          'bring': 'Wird noch bekannt gegeben',
          'contact': 'Kindergarten Team',
          'phone': '+43 664 123 4567',
        };
    }
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

  void _showEventInfoDialog() {
    // Extract event name from groupName (remove "Familie" prefix if present)
    final eventName = widget.groupName.startsWith('Familie ') 
        ? widget.groupName.substring(8) 
        : widget.groupName;
    
    final eventInfo = _getEventInfo(eventName);
    
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
                              eventInfo['name']!,
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
                    value: eventInfo['date']!,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    icon: Icons.access_time,
                    label: 'Uhrzeit',
                    value: eventInfo['time']!,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    icon: Icons.location_on,
                    label: 'Ort',
                    value: eventInfo['location']!,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    icon: Icons.description,
                    label: 'Beschreibung',
                    value: eventInfo['description']!,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    icon: Icons.shopping_bag,
                    label: 'Bitte mitbringen',
                    value: eventInfo['bring']!,
                  ),
                  const SizedBox(height: 16),
                  
                  // Contact information
                  Container(
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
                              'Kontaktperson',
                              style: KikoTypography.withColor(
                                KikoTypography.appFootnote,
                                AppColors.captionKiko,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          eventInfo['contact']!,
                          style: KikoTypography.withColor(
                            KikoTypography.appBody,
                            AppColors.textPrimaryKiko,
                          ),
                        ),
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
                              eventInfo['phone']!,
                              style: KikoTypography.withColor(
                                KikoTypography.appFootnote,
                                AppColors.textPrimaryKiko,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

  void _showPhoneDialog() {
    if (widget.childName == null) return;
    
    final parentInfo = _getParentInfo(widget.childName!);
    
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
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
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
                        onPressed: () {
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

  void _showInfoDialog() {
    if (widget.childName == null) return;
    
    final parentInfo = _getParentInfo(widget.childName!);
    
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
                  _buildInfoRow(
                    icon: Icons.location_on,
                    label: 'Adresse',
                    value: parentInfo['address']!,
                  ),
                  const SizedBox(height: 24),
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
              const Icon(
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
              const Icon(
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
              const Icon(
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
          if (!widget.isGroupChat && widget.childName != null)
            IconButton(
              icon: const Icon(Icons.phone, color: AppColors.textPrimaryKiko),
              onPressed: _showPhoneDialog,
            ),
          // Info button (for both group and private chats)
          IconButton(
            icon: const Icon(Coolicons.info_circle, color: AppColors.textPrimaryKiko),
            onPressed: widget.isGroupChat ? _showEventInfoDialog : _showInfoDialog,
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
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return MessageBubble(
                  message: message['message'],
                  sender: message['sender'],
                  time: message['time'],
                  isCurrentUser: message['isCurrentUser'],
                );
              },
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
}

