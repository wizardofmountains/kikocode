import 'package:flutter/material.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/kiko_typography.dart';

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
      padding: const EdgeInsets.all(21),
      decoration: const BoxDecoration(
        color: AppColors.surfaceBase,
      ),
      child: SafeArea(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.surfaceHighest,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 23),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Meine Nachricht ...',
                      hintStyle: KikoTypography.withColor(
                        KikoTypography.appBody,
                        AppColors.captionKiko,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: KikoTypography.withColor(
                      KikoTypography.appBody,
                      AppColors.textPrimaryKiko,
                    ),
                    maxLines: 1,
                    textInputAction: TextInputAction.send,
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
              Padding(
                padding: const EdgeInsets.all(3),
                child: GestureDetector(
                  onTap: _hasText ? _handleSend : null,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _hasText 
                          ? AppColors.primaryKiko 
                          : AppColors.captionKiko,
                    ),
                    child: const Icon(
                      Icons.arrow_upward_rounded,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

