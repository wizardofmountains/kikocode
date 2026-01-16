import 'package:flutter/material.dart';
import 'package:coolicons/coolicons.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/spacing.dart';
import '../../../../core/design_system/kiko_typography.dart';

/// Dropdown field for group or subject selection
/// Features rounded corners, border, info icon, and dropdown arrow
class SelectionField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final VoidCallback? onInfoTap;

  const SelectionField({
    super.key,
    required this.label,
    this.value,
    required this.items,
    this.onChanged,
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
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  hint: Text(
                    label,
                    style: KikoTypography.withColor(
                      KikoTypography.appBody,
                      AppColors.captionKiko,
                    ),
                  ),
                  isExpanded: true,
                  icon: const Icon(
                    Coolicons.chevron_down,
                    size: 18,
                  ),
                  style: KikoTypography.withColor(
                    KikoTypography.appBody,
                    AppColors.textPrimaryKiko,
                  ),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: onChanged,
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
