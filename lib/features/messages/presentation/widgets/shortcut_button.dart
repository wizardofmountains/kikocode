import 'package:flutter/material.dart';
import 'package:coolicons/coolicons.dart';
import '../../../../core/design_system/colors.dart';

/// Combined Call + Info shortcut button
/// Green background with phone and info icons separated by a divider
class ShortcutButton extends StatelessWidget {
  final VoidCallback? onCallTap;
  final VoidCallback? onInfoTap;

  const ShortcutButton({
    super.key,
    this.onCallTap,
    this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 94,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.secondaryKiko,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Phone button
          Expanded(
            child: GestureDetector(
              onTap: onCallTap,
              behavior: HitTestBehavior.opaque,
              child: const Center(
                child: Icon(
                  Coolicons.phone_outline,
                  color: AppColors.surfaceHighest,
                  size: 22,
                ),
              ),
            ),
          ),
          // Divider
          Container(
            width: 1,
            height: 28,
            color: AppColors.surfaceHighest,
          ),
          // Info button
          Expanded(
            child: GestureDetector(
              onTap: onInfoTap,
              behavior: HitTestBehavior.opaque,
              child: const Center(
                child: Icon(
                  Coolicons.info_circle_outline,
                  color: AppColors.surfaceHighest,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
