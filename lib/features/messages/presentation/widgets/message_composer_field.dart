import 'package:flutter/material.dart';
import 'package:coolicons/coolicons.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/spacing.dart';
import '../../../../core/design_system/kiko_typography.dart';

/// Text area for composing messages with send button
class MessageComposerField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onSend;
  final String placeholder;

  const MessageComposerField({
    super.key,
    required this.controller,
    this.onSend,
    this.placeholder = 'Meine Nachricht ...',
  });

  @override
  State<MessageComposerField> createState() => _MessageComposerFieldState();
}

class _MessageComposerFieldState extends State<MessageComposerField> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 50,
        maxHeight: 150,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceHighest,
        border: Border.all(
          color: AppColors.surfaceLow,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 14,
              ),
              child: TextField(
                controller: widget.controller,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                style: KikoTypography.withColor(
                  KikoTypography.appBody,
                  AppColors.textPrimaryKiko,
                ),
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  hintStyle: KikoTypography.withColor(
                    KikoTypography.appBody,
                    AppColors.captionKiko,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3, bottom: 3),
            child: GestureDetector(
              onTap: _hasText ? widget.onSend : null,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _hasText
                      ? AppColors.primaryKiko
                      : AppColors.captionKiko,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                      Icons.send_rounded,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
