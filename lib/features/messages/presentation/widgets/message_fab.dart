import 'package:flutter/material.dart';
import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/kiko_typography.dart';

/// Floating Action Button for creating new messages
/// Based on Figma Design (Node 610-2744)
/// - Size: 30x37px (elliptical)
/// - Background: Surface Highest (#FBF7EF)
/// - Border: Surface Low (#EFDFBD) 2px
/// - Plus Symbol: Primary Color (#A974C7)
/// - Font: Nunito Bold 28px
class MessageFab extends StatelessWidget {
  final VoidCallback onPressed;

  const MessageFab({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 30,
        height: 37, // Full container height as in Figma
        child: Stack(
          children: [
            // Circle background (30x30px, positioned)
            Positioned(
              top: 5, // 13.51% of 37px ≈ 5px
              left: 0,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.surfaceHighest,
                  border: Border.all(
                    color: AppColors.surfaceLow,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),

            // Plus symbol (full height, horizontally inset)
            Positioned(
              top: 0,
              bottom: 0, // Full 37px height
              left: 6, // 20% of 30px
              right: 6, // 20% of 30px
              child: Center(
                child: Text(
                  '+',
                  style: KikoTypography.appTitle1.copyWith(
                    color: AppColors.primaryKiko,
                    height: 1.0, // lineHeight 100% as in Figma
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
