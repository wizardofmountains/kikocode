import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coolicons/coolicons.dart';

class MessageInput extends StatefulWidget {
  final Function(String) onSendMessage;

  const MessageInput({
    super.key,
    required this.onSendMessage,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSendMessage(_controller.text.trim());
      _controller.clear();
      setState(() {
        _hasText = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5EFE0),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Nachricht schreiben...',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) {
                    setState(() {
                      _hasText = value.trim().isNotEmpty;
                    });
                  },
                  onSubmitted: (_) => _handleSend(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _hasText ? _handleSend : null,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _hasText
                      ? const Color(0xFFB794F6)
                      : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Coolicons.chevron_right,
                  color: _hasText ? Colors.white : Colors.grey.shade500,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

