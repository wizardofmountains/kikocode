import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kikocode/features/auth/presentation/widgets/face_id_indicator.dart';
import 'package:kikocode/features/auth/providers/auth_providers.dart';

/// Screen shown after successful authentication
/// Displays Face ID success indicator, KIKO logo, and personalized greeting
/// Matches the Figma design with smooth animations
class AuthSuccessScreen extends ConsumerStatefulWidget {
  /// The username to display in the greeting
  /// If null, will attempt to fetch from profile
  final String? username;
  
  /// Whether to show Face ID indicator (for biometric auth flow)
  final bool showFaceId;

  const AuthSuccessScreen({
    super.key,
    this.username,
    this.showFaceId = true,
  });

  @override
  ConsumerState<AuthSuccessScreen> createState() => _AuthSuccessScreenState();
}

class _AuthSuccessScreenState extends ConsumerState<AuthSuccessScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _greetingController;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _greetingFadeAnimation;
  late Animation<Offset> _greetingSlideAnimation;
  
  bool _faceIdComplete = false;
  String? _displayName;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _loadUserProfile();
  }

  void _initAnimations() {
    // Logo animation
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

    // Greeting animation
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

    // If not showing Face ID, start animations immediately
    if (!widget.showFaceId) {
      _startContentAnimations();
    }
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
    setState(() {
      _faceIdComplete = true;
    });
    _startContentAnimations();
  }

  void _startContentAnimations() {
    // Stagger the animations
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _logoController.forward();
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _greetingController.forward();
    });

    // Navigate to home after all animations complete
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) {
        context.go('/home');
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _greetingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E7CE), // Beige from Figma
      body: SafeArea(
        child: Column(
          children: [
            // Face ID indicator at the top
            if (widget.showFaceId)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FaceIdIndicator(
                  state: _faceIdComplete 
                      ? FaceIdState.success 
                      : FaceIdState.authenticating,
                  size: 145,
                  onSuccessAnimationComplete: () {
                    // Trigger content animations after Face ID success
                    if (!_faceIdComplete) {
                      _onFaceIdSuccess();
                    }
                  },
                ),
              ),
            
            const Spacer(flex: 1),
            
            // KIKO Logo
            AnimatedBuilder(
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
                'assets/images/LogoLight.svg',
                width: 300,
                height: 120,
              ),
            ),
            
            const SizedBox(height: 80),
            
            // Greeting text
            SlideTransition(
              position: _greetingSlideAnimation,
              child: FadeTransition(
                opacity: _greetingFadeAnimation,
                child: Text(
                  'Hallo ${_displayName ?? 'User'}!',
                  style: GoogleFonts.nunito(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF242424),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
