import 'package:flutter/material.dart';
import 'package:coolicons/coolicons.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/spacing.dart';
import '../../../../core/design_system/kiko_typography.dart';

/// Single-line text input field for subject entry
class SubjectInputField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final VoidCallback? onInfoTap;

  const SubjectInputField({
    super.key,
    required this.controller,
    this.placeholder = 'Betreff',
    this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.surfaceHighest,
        border: Border.all(
          color: AppColors.surfaceLow,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 8),
              child: TextField(
                controller: controller,
                maxLines: 1,
                textInputAction: TextInputAction.next,
                style: KikoTypography.withColor(
                  KikoTypography.appBody,
                  AppColors.textPrimaryKiko,
                ),
                decoration: InputDecoration(
                  hintText: placeholder,
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
              ),
            ),
          ),
          if (onInfoTap != null)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                icon: const Icon(
                  Coolicons.info_circle,
                  size: 20,
                ),
                color: AppColors.textPrimaryKiko,
                onPressed: onInfoTap,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 30,
                  minHeight: 30,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
