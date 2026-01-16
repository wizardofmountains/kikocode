import 'package:flutter/material.dart';
import 'colors.dart';
import 'kiko_typography.dart';
import 'spacing.dart';

class KikoPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;

  const KikoPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.xxl,
      vertical: AppSpacing.md,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryKiko,
          foregroundColor: AppColors.surfaceHigh,
          disabledBackgroundColor: AppColors.primaryLightKiko,
          disabledForegroundColor: AppColors.surfaceHigh,
          elevation: 0,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.tabBarItemRadius),
            side: const BorderSide(
              color: AppColors.primaryLightKiko,
              width: 2,
            ),
          ),
          textStyle: KikoTypography.appHeadline,
        ),
        child: Text(label),
      ),
    );
  }
}

class KikoSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;

  const KikoSecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.xxl,
      vertical: AppSpacing.md,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryKiko,
          foregroundColor: AppColors.textPrimaryKiko,
          disabledBackgroundColor: AppColors.secondaryLightKiko,
          disabledForegroundColor: AppColors.textPrimaryKiko,
          elevation: 0,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.tabBarItemRadius),
            side: const BorderSide(
              color: AppColors.secondaryLightKiko,
              width: 2,
            ),
          ),
          textStyle: KikoTypography.appHeadline,
        ),
        child: Text(label),
      ),
    );
  }
}

class KikoTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;

  const KikoTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.onChanged,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        style: KikoTypography.withColor(
          KikoTypography.appBody,
          AppColors.textPrimaryKiko,
        ),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: AppColors.surfaceHighest,
          hintText: hintText,
          hintStyle: KikoTypography.withColor(
            KikoTypography.appBody,
            AppColors.captionKiko,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
            borderSide: const BorderSide(
              color: AppColors.surfaceLow,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
            borderSide: const BorderSide(
              color: AppColors.secondaryKiko,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class KikoSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final bool isActive;
  final VoidCallback? onIconTap;

  const KikoSearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.isActive = false,
    this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: KikoTypography.withColor(
          KikoTypography.appBody,
          AppColors.textPrimaryKiko,
        ),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: AppColors.surfaceHighest,
          hintText: hintText,
          hintStyle: KikoTypography.withColor(
            KikoTypography.appBody,
            AppColors.captionKiko,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
            borderSide: const BorderSide(
              color: AppColors.surfaceLow,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
            borderSide: const BorderSide(
              color: AppColors.secondaryKiko,
              width: 2,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(6),
            child: InkWell(
              onTap: onIconTap,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primaryKiko : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.search_rounded,
                  color: isActive ? AppColors.surfaceHighest : AppColors.primaryKiko,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KikoTabIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;

  const KikoTabIcon({
    super.key,
    required this.icon,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryKiko : AppColors.primaryLightKiko,
          borderRadius: BorderRadius.circular(AppSpacing.tabBarItemRadius),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.surfaceHigh : AppColors.primaryKiko,
          size: 24,
        ),
      ),
    );
  }
}

class KikoShortcutButton extends StatelessWidget {
  final IconData leftIcon;
  final IconData rightIcon;
  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;

  const KikoShortcutButton({
    super.key,
    required this.leftIcon,
    required this.rightIcon,
    this.onLeftTap,
    this.onRightTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 94,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.secondaryKiko,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onLeftTap,
              behavior: HitTestBehavior.opaque,
              child: Center(
                child: Icon(
                  leftIcon,
                  color: AppColors.surfaceHighest,
                  size: 22,
                ),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 28,
            color: AppColors.surfaceHighest,
          ),
          Expanded(
            child: GestureDetector(
              onTap: onRightTap,
              behavior: HitTestBehavior.opaque,
              child: Center(
                child: Icon(
                  rightIcon,
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

class KikoLoadingIndicator extends StatelessWidget {
  final double progress;

  const KikoLoadingIndicator({
    super.key,
    required this.progress,
  });

  const KikoLoadingIndicator.percent25({super.key}) : progress = 0.25;
  const KikoLoadingIndicator.percent50({super.key}) : progress = 0.50;
  const KikoLoadingIndicator.percent75({super.key}) : progress = 0.75;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: CustomPaint(
        painter: _KikoLoadingIndicatorPainter(progress: progress),
      ),
    );
  }
}

class _KikoLoadingIndicatorPainter extends CustomPainter {
  final double progress;

  _KikoLoadingIndicatorPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final backgroundPaint = Paint()
      ..color = AppColors.surfaceBase
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - 1.5, backgroundPaint);

    final progressPaint = Paint()
      ..color = AppColors.successGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * 3.141592653589793 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 1.5),
      -3.141592653589793 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_KikoLoadingIndicatorPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
