import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Enum representing the state of Face ID authentication
enum FaceIdState {
  /// Face ID is scanning/authenticating
  authenticating,
  /// Face ID authentication succeeded
  success,
}

/// A widget that displays the Face ID indicator with animation between states
/// Matches the Figma design with a black rounded rectangle bezel and
/// either a Face ID symbol or a green checkmark
class FaceIdIndicator extends StatefulWidget {
  /// The current state of Face ID authentication
  final FaceIdState state;
  
  /// Size of the indicator (width and height)
  final double size;
  
  /// Callback when the success animation completes
  final VoidCallback? onSuccessAnimationComplete;

  const FaceIdIndicator({
    super.key,
    required this.state,
    this.size = 145,
    this.onSuccessAnimationComplete,
  });

  @override
  State<FaceIdIndicator> createState() => _FaceIdIndicatorState();
}

class _FaceIdIndicatorState extends State<FaceIdIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    if (widget.state == FaceIdState.success) {
      _playSuccessAnimation();
    }
  }

  @override
  void didUpdateWidget(FaceIdIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state && 
        widget.state == FaceIdState.success) {
      _playSuccessAnimation();
    }
  }

  void _playSuccessAnimation() {
    debugPrint('FaceIdIndicator: Playing success animation');
    _controller.forward().then((_) {
      debugPrint('FaceIdIndicator: Animation complete, calling callback');
      widget.onSuccessAnimationComplete?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(widget.size * 0.28), // ~40px for 145px
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 74,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Center(
        child: widget.state == FaceIdState.success
            ? _buildSuccessIndicator()
            : _buildAuthenticatingIndicator(),
      ),
    );
  }

  Widget _buildAuthenticatingIndicator() {
    // Face ID symbol using SF Symbols-like icon
    return SizedBox(
      width: widget.size * 0.48, // ~70px for 145px
      height: widget.size * 0.48,
      child: CustomPaint(
        painter: _FaceIdPainter(color: Colors.white),
      ),
    );
  }

  Widget _buildSuccessIndicator() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
        );
      },
      child: Container(
        width: widget.size * 0.48, // ~70px for 145px
        height: widget.size * 0.48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF87FA89), // Green success color
            width: 3,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.check,
            color: const Color(0xFF87FA89),
            size: widget.size * 0.28,
          ),
        ),
      ),
    );
  }
}

/// Custom painter for the Face ID symbol
class _FaceIdPainter extends CustomPainter {
  final Color color;

  _FaceIdPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.05
      ..strokeCap = StrokeCap.round;

    final double cornerRadius = size.width * 0.15;
    final double cornerLength = size.width * 0.25;

    // Top-left corner
    canvas.drawPath(
      Path()
        ..moveTo(0, cornerLength)
        ..lineTo(0, cornerRadius)
        ..arcToPoint(
          Offset(cornerRadius, 0),
          radius: Radius.circular(cornerRadius),
        )
        ..lineTo(cornerLength, 0),
      paint,
    );

    // Top-right corner
    canvas.drawPath(
      Path()
        ..moveTo(size.width - cornerLength, 0)
        ..lineTo(size.width - cornerRadius, 0)
        ..arcToPoint(
          Offset(size.width, cornerRadius),
          radius: Radius.circular(cornerRadius),
        )
        ..lineTo(size.width, cornerLength),
      paint,
    );

    // Bottom-left corner
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height - cornerLength)
        ..lineTo(0, size.height - cornerRadius)
        ..arcToPoint(
          Offset(cornerRadius, size.height),
          radius: Radius.circular(cornerRadius),
        )
        ..lineTo(cornerLength, size.height),
      paint,
    );

    // Bottom-right corner
    canvas.drawPath(
      Path()
        ..moveTo(size.width - cornerLength, size.height)
        ..lineTo(size.width - cornerRadius, size.height)
        ..arcToPoint(
          Offset(size.width, size.height - cornerRadius),
          radius: Radius.circular(cornerRadius),
        )
        ..lineTo(size.width, size.height - cornerLength),
      paint,
    );

    // Face elements
    final double eyeY = size.height * 0.35;
    final double eyeHeight = size.height * 0.15;
    
    // Left eye
    canvas.drawLine(
      Offset(size.width * 0.28, eyeY),
      Offset(size.width * 0.28, eyeY + eyeHeight),
      paint,
    );

    // Right eye
    canvas.drawLine(
      Offset(size.width * 0.72, eyeY),
      Offset(size.width * 0.72, eyeY + eyeHeight),
      paint,
    );

    // Nose
    final nosePath = Path()
      ..moveTo(size.width * 0.5, size.height * 0.4)
      ..lineTo(size.width * 0.5, size.height * 0.55)
      ..lineTo(size.width * 0.42, size.height * 0.58);
    canvas.drawPath(nosePath, paint);

    // Mouth
    final mouthPath = Path()
      ..moveTo(size.width * 0.35, size.height * 0.7)
      ..quadraticBezierTo(
        size.width * 0.5, size.height * 0.78,
        size.width * 0.65, size.height * 0.7,
      );
    canvas.drawPath(mouthPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
