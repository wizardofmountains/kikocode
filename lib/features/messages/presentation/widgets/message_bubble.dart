import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String sender;
  final String time;
  final bool isCurrentUser;
  final Color? senderColor;

  const MessageBubble({
    super.key,
    required this.message,
    required this.sender,
    required this.time,
    this.isCurrentUser = false,
    this.senderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: senderColor ?? const Color(0xFFE9D5FF),
              child: Text(
                sender.isNotEmpty ? sender[0].toUpperCase() : '?',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF9333EA),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCurrentUser
                    ? const Color(0xFFB794F6)
                    : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isCurrentUser ? 12 : 4),
                  topRight: Radius.circular(isCurrentUser ? 4 : 12),
                  bottomLeft: const Radius.circular(12),
                  bottomRight: const Radius.circular(12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isCurrentUser)
                    Text(
                      sender,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF9333EA),
                      ),
                    ),
                  if (!isCurrentUser) const SizedBox(height: 4),
                  Text(
                    message,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isCurrentUser ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: isCurrentUser
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

