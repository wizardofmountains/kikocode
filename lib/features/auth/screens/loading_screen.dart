import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kikocode/core/constants/asset_paths.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'package:kikocode/features/auth/presentation/widgets/face_id_indicator.dart';
import 'package:kikocode/features/auth/providers/auth_providers.dart';

/// Unified Loading/Success screen for authentication flows
///
/// This screen serves multiple purposes:
/// - Shows loading state during authentication
/// - Displays Face ID authentication indicator
/// - Shows success state with animated greeting
///
/// Features:
/// - Responsive layout for mobile, tablet, and desktop
/// - Staggered animations for visual polish
/// - Accessibility support with reduced motion preference
/// - Safe area handling for notches/status bars
class LoadingScreen extends ConsumerStatefulWidget {
  /// The username to display in the greeting
  /// If null, will attempt to fetch from profile
  final String? username;

  /// Whether to show Face ID indicator (for biometric auth flow)
  final bool showFaceId;

  /// Whether to show a loading phase before success
  final bool showLoadingPhase;

  /// Duration to show the success state before navigating
  final Duration successDuration;

  const LoadingScreen({
    super.key,
    this.username,
    this.showFaceId = false,
    this.showLoadingPhase = false,
    this.successDuration = const Duration(milliseconds: 1800),
  });

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen>
    with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _indicatorController;
  late AnimationController _logoController;
  late AnimationController _greetingController;
  late AnimationController _rotationController;

  // Indicator animations
  late Animation<double> _indicatorScaleAnimation;
  late Animation<double> _indicatorOpacityAnimation;

  // Logo animations
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;

  // Greeting animations
  late Animation<double> _greetingFadeAnimation;
  late Animation<Offset> _greetingSlideAnimation;

  // State
  bool _faceIdComplete = false;
  String? _displayName;
  bool _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _loadUserProfile();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check for reduced motion preference
    _reduceMotion = MediaQuery.of(context).disableAnimations;

    if (_reduceMotion) {
      _skipAnimations();
    }
  }

  void _initAnimations() {
    // Indicator animation (500ms, elasticOut)
    _indicatorController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _indicatorScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _indicatorController,
        curve: Curves.elasticOut,
      ),
    );

    _indicatorOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _indicatorController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Rotation animation (continuous spinning)
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Start rotation animation and repeat
    _rotationController.repeat();

    // Logo animation (600ms, easeOut)
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    // Greeting animation (500ms, easeOut)
    _greetingController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _greetingFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _greetingController,
        curve: Curves.easeOut,
      ),
    );

    _greetingSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _greetingController,
        curve: Curves.easeOut,
      ),
    );

    // Start animations based on configuration
    if (!widget.showFaceId) {
      _startContentAnimations();
    }
  }

  void _skipAnimations() {
    // Skip to final state for reduced motion
    _indicatorController.value = 1.0;
    _logoController.value = 1.0;
    _greetingController.value = 1.0;
    _faceIdComplete = true;

    // Navigate after a brief pause
    Future.delayed(widget.successDuration, _navigateToHome);
  }

  Future<void> _loadUserProfile() async {
    if (widget.username != null) {
      setState(() {
        _displayName = widget.username;
      });
      return;
    }

    // Try to fetch from profile
    try {
      final profile = await ref.read(currentProfileProvider.future);
      if (profile != null && mounted) {
        setState(() {
          _displayName = profile.name;
        });
      }
    } catch (e) {
      // Fallback to a default name
      if (mounted) {
        setState(() {
          _displayName = 'User';
        });
      }
    }
  }

  void _onFaceIdSuccess() {
    if (_reduceMotion) return;

    setState(() {
      _faceIdComplete = true;
    });
    _startContentAnimations();
  }

  void _startContentAnimations() {
    if (_reduceMotion) {
      _skipAnimations();
      return;
    }

    // Animation sequence:
    // 0ms: Indicator appears
    _indicatorController.forward();

    // 100ms: Logo fades in + scales
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _logoController.forward();
    });

    // 400ms: Greeting slides up + fades in
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _greetingController.forward();
    });

    // Navigate to home after all animations complete
    Future.delayed(widget.successDuration, _navigateToHome);
  }

  void _navigateToHome() {
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  void dispose() {
    _indicatorController.dispose();
    _logoController.dispose();
    _greetingController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: _getMaxContentWidth(context),
            ),
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  double _getMaxContentWidth(BuildContext context) {
    // Desktop: centered with ~600px max-width
    // Tablet: 768px max-width
    // Mobile: full width
    return AppBreakpoints.value(
      context,
      xs: double.infinity,
      md: 768,
      lg: 600,
    );
  }

  Widget _buildContent(BuildContext context) {
    final isDesktop = AppBreakpoints.isDesktop(context);

    Widget content = Padding(
      padding: AppBreakpoints.device(
        context,
        mobile: AppSpacing.h6v0,
        tablet: AppSpacing.h8v0,
        desktop: AppSpacing.horizontalOnly(AppSpacing.spacing12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLogo(context),
          SizedBox(height: _getLogoTextSpacing(context)),
          _buildGreeting(context),
          SizedBox(height: _getTextRingSpacing(context)),
          _buildPulsingRingIndicator(context),
        ],
      ),
    );

    // Desktop: wrap content in a subtle card
    if (isDesktop) {
      content = Container(
        padding: AppSpacing.all12,
        decoration: BoxDecoration(
          color: AppColors.surfaceHighest.withValues(alpha: 0.3),
          borderRadius: AppBorders.xl2,
        ),
        child: content,
      );
    }

    return content;
  }

  double _getLogoTextSpacing(BuildContext context) {
    return AppBreakpoints.device(
      context,
      mobile: 24.0,
      tablet: 32.0,
      desktop: 40.0,
    );
  }

  double _getTextRingSpacing(BuildContext context) {
    return AppBreakpoints.device(
      context,
      mobile: 32.0,
      tablet: 40.0,
      desktop: 48.0,
    );
  }

  Widget _buildPulsingRingIndicator(BuildContext context) {
    final ringSize = AppBreakpoints.device(
      context,
      mobile: 120.0,
      tablet: 150.0,
      desktop: 180.0,
    );

    if (widget.showFaceId) {
      return Semantics(
        label: _faceIdComplete
            ? 'Anmeldung erfolgreich'
            : 'Face ID wird authentifiziert',
        child: FaceIdIndicator(
          state: _faceIdComplete
              ? FaceIdState.success
              : FaceIdState.authenticating,
          size: ringSize,
          onSuccessAnimationComplete: () {
            if (!_faceIdComplete) {
              _onFaceIdSuccess();
            }
          },
        ),
      );
    }

    // Rotating dash indicator
    return Semantics(
      label: 'Wird geladen',
      child: AnimatedBuilder(
        animation: _indicatorController,
        builder: (context, child) {
          return Opacity(
            opacity: _indicatorOpacityAnimation.value,
            child: Transform.scale(
              scale: _indicatorScaleAnimation.value,
              child: child,
            ),
          );
        },
        child: AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationController.value * 2 * math.pi,
              child: child,
            );
          },
          child: CustomPaint(
            size: Size(ringSize, ringSize),
            painter: _RotatingDashPainter(
              color: AppColors.primary,
              strokeWidth: 3,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    final logoSize = _getLogoSize(context);

    return Semantics(
      label: 'KIKO Logo',
      child: AnimatedBuilder(
        animation: _logoController,
        builder: (context, child) {
          return Opacity(
            opacity: _logoFadeAnimation.value,
            child: Transform.scale(
              scale: _logoScaleAnimation.value,
              child: child,
            ),
          );
        },
        child: SvgPicture.asset(
          AssetPaths.logoLight,
          width: logoSize.width,
          height: logoSize.height,
        ),
      ),
    );
  }

  Size _getLogoSize(BuildContext context) {
    return AppBreakpoints.device(
      context,
      mobile: const Size(200, 80),
      tablet: const Size(250, 100),
      desktop: const Size(300, 120),
    );
  }

  Widget _buildGreeting(BuildContext context) {
    final greetingStyle = _getGreetingStyle(context);
    final displayName = _displayName ?? 'User';

    return Semantics(
      label: 'Hallo $displayName',
      child: SlideTransition(
        position: _greetingSlideAnimation,
        child: FadeTransition(
          opacity: _greetingFadeAnimation,
          child: Text(
            'Hallo $displayName!',
            style: greetingStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  TextStyle _getGreetingStyle(BuildContext context) {
    final baseFontSize = AppBreakpoints.device(
      context,
      mobile: 28.0,
      tablet: 34.0,
      desktop: 40.0,
    );

    return AppTypography.largeTitle.copyWith(
      color: AppColors.textPrimary,
      fontSize: baseFontSize,
    );
  }
}

/// Custom painter for the rotating dash loading indicator
class _RotatingDashPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _RotatingDashPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw an arc that covers about 270 degrees (3/4 of the circle)
    // leaving a gap of 90 degrees
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0, // start angle
      math.pi * 1.5, // sweep angle (270 degrees)
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_RotatingDashPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}
