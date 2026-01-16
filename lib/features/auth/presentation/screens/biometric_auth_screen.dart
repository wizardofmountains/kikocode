import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kikocode/features/auth/presentation/widgets/face_id_indicator.dart';
import 'package:kikocode/features/auth/providers/auth_providers.dart';

/// Screen that prompts for biometric authentication (Face ID / Touch ID)
/// This is shown to returning users who have enabled biometric auth.
///
/// UX flow (iOS-optimised):
/// - As soon as the screen is visible, the system Face ID sheet appears.
/// - On success → play the Face ID success animation, then route to
///   `/auth/success` so the dedicated success screen owns the greeting + logo
///   animations.
/// - On failure/cancel → keep the user on this screen, offer a retry button
///   and a "Mit Passwort anmelden" fallback to the email/password login.
class BiometricAuthScreen extends ConsumerStatefulWidget {
  const BiometricAuthScreen({super.key});

  @override
  ConsumerState<BiometricAuthScreen> createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends ConsumerState<BiometricAuthScreen> {
  FaceIdState _faceIdState = FaceIdState.authenticating;
  bool _isAuthenticating = false;
  bool _authFailed = false;

  @override
  void initState() {
    super.initState();
    // Start biometric auth shortly after first frame to avoid layout jank
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _authenticateWithBiometrics();
        }
      });
    });
  }

  Future<void> _authenticateWithBiometrics() async {
    if (_isAuthenticating || !mounted) return;

    setState(() {
      _isAuthenticating = true;
      _authFailed = false;
      _faceIdState = FaceIdState.authenticating;
    });

    final biometricService = ref.read(biometricServiceProvider);
    final success = await biometricService.authenticate(
      localizedReason: 'Bitte authentifizieren Sie sich, um fortzufahren',
    );

    if (!mounted) return;

    if (success) {
      setState(() {
        _faceIdState = FaceIdState.success;
      });
    } else {
      // Authentication failed or was cancelled (including system errors).
      // Follow iOS patterns: stay on this screen and offer retry + password.
      setState(() {
        _isAuthenticating = false;
        _authFailed = true;
        _faceIdState = FaceIdState.authenticating;
      });
    }
  }

  /// Called when the Face ID success animation in the indicator completes.
  /// We then transition into the shared `AuthSuccessScreen` to keep all
  /// greeting/home navigation logic in one place.
  Future<void> _onFaceIdSuccessAnimationComplete() async {
    if (!mounted) return;

    String? username;
    try {
      final profile = await ref.read(currentProfileProvider.future);
      username = profile?.name;
    } catch (_) {
      // Ignore profile load errors and fall back to null/default username.
    }

    if (!mounted) return;

    context.go(
      '/auth-success',
      extra: <String, dynamic>{
        'username': username,
        'showFaceId': true,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E7CE), // Beige from Figma
      body: SafeArea(
        child: Column(
          children: [
            // Face ID indicator at the top
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FaceIdIndicator(
                state: _faceIdState,
                size: 145,
                onSuccessAnimationComplete: _onFaceIdSuccessAnimationComplete,
              ),
            ),

            const Spacer(flex: 1),

            // KIKO Logo (static on this screen – success screen owns animations)
            SvgPicture.asset(
              'assets/images/LogoLight.svg',
              width: 300,
              height: 120,
            ),

            const SizedBox(height: 40),

            // Instructional copy to match iOS-style biometric prompts
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Mit Face ID anmelden, um Kikocode zu öffnen.',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF242424),
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const Spacer(flex: 2),

            // "Use password" fallback is always available while on this screen.
            TextButton(
              onPressed: () => context.go('/login'),
              child: Text(
                'Mit Passwort anmelden',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFB794F6),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Retry button (only visible if auth previously failed or was cancelled)
            if (_authFailed && !_isAuthenticating)
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: ElevatedButton(
                  onPressed: _authenticateWithBiometrics,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB794F6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Erneut versuchen',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            else
              const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
