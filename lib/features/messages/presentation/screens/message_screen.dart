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

  const MessageScreen({
    super.key,
    required this.groupName,
    required this.groupIcon,
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final List<Map<String, dynamic>> _messages = [
    {
      'message': 'Hallo zusammen! Wie geht es euch?',
      'sender': 'David',
      'time': '09:15',
      'isCurrentUser': false,
    },
    {
      'message': 'Hallo David! Mir geht es gut, danke! 😊',
      'sender': 'Anna',
      'time': '09:17',
      'isCurrentUser': true,
    },
    {
      'message': 'Super! Hat jemand die Fotos vom letzten Ausflug?',
      'sender': 'David',
      'time': '09:18',
      'isCurrentUser': false,
    },
    {
      'message': 'Ja, ich lade sie gleich hoch!',
      'sender': 'Maria',
      'time': '09:20',
      'isCurrentUser': false,
    },
    {
      'message': 'Danke Maria! Das wäre toll.',
      'sender': 'Anna',
      'time': '09:22',
      'isCurrentUser': true,
    },
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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
              child: Text(
                widget.groupName,
                style: KikoTypography.withColor(
                  KikoTypography.appBody,
                  AppColors.textPrimaryKiko,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Coolicons.info_circle, color: AppColors.textPrimaryKiko),
            onPressed: () => context.push('/message-status'),
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

