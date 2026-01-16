import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kikocode/core/services/biometric_service.dart';
import 'package:kikocode/features/auth/presentation/widgets/face_id_indicator.dart';
import 'package:kikocode/features/auth/providers/auth_providers.dart';

/// Maximum number of failed biometric attempts before temporary lockout
const int _maxFailedAttempts = 3;

/// Lockout duration in seconds after max failed attempts
const int _lockoutDurationSeconds = 30;

/// Screen that prompts for biometric authentication (Face ID / Touch ID)
/// This is shown to returning users who have enabled biometric auth.
///
/// UX flow (iOS-optimised):
/// - As soon as the screen is visible, the system Face ID sheet appears.
/// - On success → play the Face ID success animation, then route to
///   `/auth-success` so the dedicated success screen owns the greeting + logo
///   animations.
/// - On failure/cancel → keep the user on this screen, offer a retry button
///   and a "Mit Passwort anmelden" fallback to the email/password login.
/// - After 3 failed attempts → temporarily lock out biometric retry and show countdown
class BiometricAuthScreen extends ConsumerStatefulWidget {
  const BiometricAuthScreen({super.key});

  @override
  ConsumerState<BiometricAuthScreen> createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends ConsumerState<BiometricAuthScreen> {
  FaceIdState _faceIdState = FaceIdState.authenticating;
  bool _isAuthenticating = false;
  int _failedAttempts = 0;
  bool _isLockedOut = false;
  int _lockoutSecondsRemaining = 0;
  Timer? _lockoutTimer;
  String? _errorMessage;
  bool _allowDeviceCredential = false;

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

  @override
  void dispose() {
    _lockoutTimer?.cancel();
    super.dispose();
  }

  void _startLockoutTimer() {
    setState(() {
      _isLockedOut = true;
      _lockoutSecondsRemaining = _lockoutDurationSeconds;
    });

    _lockoutTimer?.cancel();
    _lockoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        _lockoutSecondsRemaining--;
      });

      if (_lockoutSecondsRemaining <= 0) {
        timer.cancel();
        setState(() {
          _isLockedOut = false;
          _failedAttempts = 0;
          _errorMessage = null;
        });
      }
    });
  }

  Future<void> _authenticateWithBiometrics() async {
    if (_isAuthenticating || _isLockedOut || !mounted) return;

    setState(() {
      _isAuthenticating = true;
      _errorMessage = null;
      _faceIdState = FaceIdState.authenticating;
    });

    final biometricService = ref.read(biometricServiceProvider);

    // Use change detection for security
    final result = await biometricService.authenticateWithChangeDetection(
      localizedReason: 'Bitte authentifizieren Sie sich, um fortzufahren',
      allowDeviceCredential: _allowDeviceCredential,
    );

    if (!mounted) return;

    if (result.isSuccess) {
      debugPrint('BiometricAuthScreen: Biometric authentication SUCCESS');
      setState(() {
        _faceIdState = FaceIdState.success;
        _failedAttempts = 0;
      });
      debugPrint('BiometricAuthScreen: State set to success, waiting for animation callback');
    } else {
      debugPrint('BiometricAuthScreen: Biometric authentication FAILED: ${result.error}');
      _handleAuthFailure(result);
    }
  }

  void _handleAuthFailure(BiometricResult result) {
    setState(() {
      _isAuthenticating = false;
      _faceIdState = FaceIdState.authenticating;
    });

    // Handle specific error types
    switch (result.error) {
      case BiometricError.cancelled:
        // User cancelled - don't count as a failed attempt
        setState(() {
          _errorMessage = null;
        });
        break;

      case BiometricError.lockedOut:
      case BiometricError.permanentlyLocked:
        // System lockout - redirect to password login
        setState(() {
          _errorMessage = result.errorMessage;
          _isLockedOut = true;
        });
        break;

      case BiometricError.biometricsChanged:
        // Security concern - force password login
        setState(() {
          _errorMessage = result.errorMessage;
        });
        // Auto-navigate to login after a short delay
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            context.go('/login');
          }
        });
        break;

      case BiometricError.notEnrolled:
        setState(() {
          _errorMessage = result.errorMessage;
        });
        break;

      case BiometricError.notAvailable:
      case BiometricError.unknown:
      case null:
        // Count as failed attempt
        _failedAttempts++;
        if (_failedAttempts >= _maxFailedAttempts) {
          _startLockoutTimer();
          setState(() {
            _errorMessage = 'Zu viele fehlgeschlagene Versuche. Bitte warten Sie $_lockoutDurationSeconds Sekunden.';
            // After lockout, allow device credential fallback
            _allowDeviceCredential = true;
          });
        } else {
          final remainingAttempts = _maxFailedAttempts - _failedAttempts;
          setState(() {
            _errorMessage = result.errorMessage ??
                'Authentifizierung fehlgeschlagen. Noch $remainingAttempts ${remainingAttempts == 1 ? 'Versuch' : 'Versuche'}.';
          });
        }
        break;
    }
  }

  /// Called when the Face ID success animation in the indicator completes.
  /// We then transition into the shared `AuthSuccessScreen` to keep all
  /// greeting/home navigation logic in one place.
  ///
  /// If there's no active session but we have stored credentials, this will
  /// auto-login using the stored credentials before navigating.
  Future<void> _onFaceIdSuccessAnimationComplete() async {
    debugPrint('BiometricAuthScreen: Success animation complete callback triggered');
    if (!mounted) return;

    // Check if we have an active session
    final authRepository = ref.read(authRepositoryProvider);
    final currentUser = authRepository.currentUser;
    debugPrint('BiometricAuthScreen: currentUser = ${currentUser?.id}');

    if (currentUser == null) {
      // No active session - try to auto-login with stored credentials
      debugPrint('BiometricAuthScreen: No active session, attempting auto-login');

      final secureCredentialService = ref.read(secureCredentialServiceProvider);
      final credentials = await secureCredentialService.getCredentials();

      if (credentials != null) {
        try {
          // Sign in with stored credentials
          await ref.read(authStateProvider.notifier).signIn(
            email: credentials.email,
            password: credentials.password,
          );
          debugPrint('BiometricAuthScreen: Auto-login successful');
        } catch (e) {
          debugPrint('BiometricAuthScreen: Auto-login failed: $e');
          // If auto-login fails, clear credentials and go to login
          await secureCredentialService.clearCredentials();
          if (!mounted) return;
          context.go('/login');
          return;
        }
      } else {
        // No credentials stored - shouldn't happen, but go to login
        debugPrint('BiometricAuthScreen: No stored credentials found');
        if (!mounted) return;
        context.go('/login');
        return;
      }
    }

    if (!mounted) return;

    String? username;
    try {
      debugPrint('BiometricAuthScreen: Fetching profile...');
      // Fetch profile directly from repository to avoid StreamProvider blocking
      final profileRepository = ref.read(profileRepositoryProvider);
      final profile = await profileRepository.getCurrentProfile();
      username = profile?.name;
      debugPrint('BiometricAuthScreen: Profile fetched, username=$username');
    } catch (e) {
      debugPrint('BiometricAuthScreen: Profile fetch error: $e');
      // Ignore profile load errors and fall back to null/default username.
    }

    if (!mounted) {
      debugPrint('BiometricAuthScreen: Widget unmounted after profile fetch');
      return;
    }

    debugPrint('BiometricAuthScreen: Navigating to /auth-success with username=$username');
    context.go(
      '/auth-success',
      extra: <String, dynamic>{
        'username': username,
        'showFaceId': false, // Already showed success animation in BiometricAuthScreen
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final showRetryButton = !_isAuthenticating && !_isLockedOut && _failedAttempts > 0;
    final showLockoutMessage = _isLockedOut && _lockoutSecondsRemaining > 0;

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
              child: Consumer(
                builder: (context, ref, child) {
                  final biometricTypeName = ref.watch(biometricTypeNameProvider);
                  final typeName = biometricTypeName.valueOrNull ?? 'Biometrie';
                  return Text(
                    'Mit $typeName anmelden, um Kikocode zu öffnen.',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF242424),
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),

            // Error message display
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  _errorMessage!,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFD32F2F),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],

            // Lockout countdown
            if (showLockoutMessage) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Erneuter Versuch in $_lockoutSecondsRemaining Sekunden',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF757575),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],

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

            // Retry button (only visible if auth previously failed and not locked out)
            if (showRetryButton)
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
