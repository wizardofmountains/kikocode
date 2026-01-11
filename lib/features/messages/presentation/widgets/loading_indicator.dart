import 'package:flutter/material.dart';
import '../../../../core/design_system/colors.dart';

/// Circular progress indicator with percentage variants
/// Used to show message delivery status (25%, 50%, 75%)
class LoadingIndicator extends StatelessWidget {
  final double progress; // 0.0 to 1.0

  const LoadingIndicator({
    super.key,
    required this.progress,
  });

  // Named constructors for common percentages
  const LoadingIndicator.percent25({super.key}) : progress = 0.25;
  const LoadingIndicator.percent50({super.key}) : progress = 0.50;
  const LoadingIndicator.percent75({super.key}) : progress = 0.75;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: CustomPaint(
        painter: _LoadingIndicatorPainter(progress: progress),
      ),
    );
  }
}

class _LoadingIndicatorPainter extends CustomPainter {
  final double progress;

  _LoadingIndicatorPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background circle (gray)
    final backgroundPaint = Paint()
      ..color = AppColors.gray200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - 1.5, backgroundPaint);

    // Progress arc (green)
    final progressPaint = Paint()
      ..color = AppColors.successGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    // Draw arc from top (270 degrees / -90 degrees) clockwise
    final sweepAngle = 2 * 3.141592653589793 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 1.5),
      -3.141592653589793 / 2, // Start at top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_LoadingIndicatorPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
