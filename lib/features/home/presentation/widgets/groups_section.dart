import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';

class GroupsSection extends StatelessWidget {
  const GroupsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gruppen',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildGroupItem(
            context,
            emoji: '🦋',
            name: 'Schmetterling',
            color: const Color(0xFF7DD3C0),
          ),
          const SizedBox(height: 12),
          _buildGroupItem(
            context,
            emoji: '🐞',
            name: 'Marienkäfer',
            color: const Color(0xFFFF9999),
          ),
          const SizedBox(height: 12),
          _buildGroupItem(
            context,
            emoji: '🦜',
            name: 'Papagei',
            color: const Color(0xFF92C6E8),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupItem(
    BuildContext context, {
    required String emoji,
    required String name,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Emoji icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Group name
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          // Action buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => context.go('/messages'),
                  child: Icon(
                    Coolicons.message_circle,
                    size: 18,
                    color: color.withOpacity(0.8),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Coolicons.calendar,
                  size: 18,
                  color: color.withOpacity(0.8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

