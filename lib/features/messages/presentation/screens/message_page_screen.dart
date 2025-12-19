import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';
import '../widgets/conversation_preview.dart';

class MessagePageScreen extends StatelessWidget {
  const MessagePageScreen({super.key});

  // Mock data for conversations
  static final List<Map<String, dynamic>> _conversations = [
    {
      'groupName': 'Sonnenscheingruppe',
      'groupIcon': '☀️',
      'lastMessage': 'Anna: Bis morgen!',
      'time': '14:32',
      'unreadCount': 3,
    },
    {
      'groupName': 'Regenbogengruppe',
      'groupIcon': '🌈',
      'lastMessage': 'David: Die Fotos vom Ausflug sind online',
      'time': '12:15',
      'unreadCount': 1,
    },
    {
      'groupName': 'Sternengruppe',
      'groupIcon': '⭐',
      'lastMessage': 'Maria: Danke für die Info!',
      'time': '10:45',
      'unreadCount': 0,
    },
    {
      'groupName': 'Mondgruppe',
      'groupIcon': '🌙',
      'lastMessage': 'Thomas: Gerne, bis bald',
      'time': 'Gestern',
      'unreadCount': 0,
    },
    {
      'groupName': 'Wolkengruppe',
      'groupIcon': '☁️',
      'lastMessage': 'Lisa: Alles klar 👍',
      'time': 'Gestern',
      'unreadCount': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Coolicons.chevron_left, color: Colors.black87),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          'Nachrichten',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Coolicons.plus_circle, color: Colors.black87),
            onPressed: () => context.push('/group-selection'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey.shade200,
            height: 1,
          ),
        ),
      ),
      body: _conversations.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              itemCount: _conversations.length,
              itemBuilder: (context, index) {
                final conversation = _conversations[index];
                return ConversationPreview(
                  groupName: conversation['groupName'],
                  groupIcon: conversation['groupIcon'],
                  lastMessage: conversation['lastMessage'],
                  time: conversation['time'],
                  unreadCount: conversation['unreadCount'],
                  onTap: () => context.push(
                    '/message/${conversation['groupName']}',
                    extra: {
                      'groupName': conversation['groupName'],
                      'groupIcon': conversation['groupIcon'],
                    },
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Coolicons.message_circle,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Noch keine Nachrichten',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Starte eine neue Unterhaltung',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}

