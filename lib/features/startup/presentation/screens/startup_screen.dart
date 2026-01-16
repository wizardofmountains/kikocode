import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kikocode/core/constants/asset_paths.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'package:kikocode/features/startup/presentation/providers/startup_providers.dart';
import 'package:kikocode/features/auth/providers/auth_providers.dart';

/// Startup screen that initializes the app and checks authentication status
/// 
/// This screen:
/// - Displays the KIKO logo (pixel-perfect from Figma: 299.52 x 120)
/// - Shows the colorful tagline "Kommunikation kinderleicht!"
/// - Shows a subtle loading indicator while initializing
/// - Checks authentication status via Supabase
/// - Checks biometric preference for returning users
/// - Routes to appropriate screen:
///   - Authenticated + Biometric enabled → /biometric
///   - Authenticated + Biometric disabled → /auth-success
///   - Not authenticated → /welcome
///   - Error → /welcome (fail-safe)
class StartupScreen extends ConsumerStatefulWidget {
  const StartupScreen({super.key});

  @override
  ConsumerState<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends ConsumerState<StartupScreen> {
  bool _hasNavigated = false;

  /// Builds the colorful tagline "Kommunikation kinderleicht!"
  /// with specific letters colored to match the KIKO brand
  Widget _buildTagline() {
    return RichText(
      text: TextSpan(
        style: AppTypography.title2.copyWith(
          color: AppColors.textPrimary,
        ),
        children: const [
          TextSpan(
            text: 'K',
            style: TextStyle(color: AppColors.primary), // Purple
          ),
          TextSpan(
            text: 'o',
            style: TextStyle(color: AppColors.accent), // Blue
          ),
          TextSpan(text: 'mmunikation '),
          TextSpan(
            text: 'k',
            style: TextStyle(color: AppColors.accentYellow), // Yellow
          ),
          TextSpan(
            text: 'i',
            style: TextStyle(color: AppColors.secondary), // Mint/Teal
          ),
          TextSpan(text: 'nderleicht!'),
        ],
      ),
    );
  }

  Future<void> _handleNavigation(dynamic user) async {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;

    final biometricService = ref.read(biometricServiceProvider);
    final secureCredentialService = ref.read(secureCredentialServiceProvider);

    final isBiometricEnabled = await biometricService.isBiometricEnabled();
    final isBiometricAvailable = await biometricService.isBiometricAvailable();
    final hasStoredCredentials = await secureCredentialService.hasStoredCredentials();

    // Debug logging
    debugPrint('StartupScreen: user authenticated = ${user != null}');
    debugPrint('StartupScreen: isBiometricEnabled = $isBiometricEnabled');
    debugPrint('StartupScreen: isBiometricAvailable = $isBiometricAvailable');
    debugPrint('StartupScreen: hasStoredCredentials = $hasStoredCredentials');

    if (!mounted) return;

    if (user != null) {
      // User is authenticated - check biometric preference
      final hasBiometricsEnrolled = await biometricService.hasBiometricsEnrolled();
      debugPrint('StartupScreen: hasBiometricsEnrolled = $hasBiometricsEnrolled');

      if (!mounted) return;

      if (isBiometricEnabled && isBiometricAvailable) {
        // User has biometric enabled → go to biometric auth screen
        debugPrint('StartupScreen: Navigating to /biometric (active session)');
        context.go('/biometric');
      } else {
        // User is authenticated but biometric not enabled → go to success screen
        // Fetch profile for username
        final profile = await ref.read(profileRepositoryProvider).getCurrentProfile();
        if (!mounted) return;

        context.go('/auth-success', extra: {
          'username': profile?.name,
          'showFaceId': false,
        });
      }
    } else if (hasStoredCredentials && isBiometricEnabled && isBiometricAvailable) {
      // No active session but has stored credentials and biometric enabled
      // Show biometric screen which will auto-login on success
      debugPrint('StartupScreen: Navigating to /biometric (stored credentials)');
      context.go('/biometric');
    } else {
      // User is not authenticated and no stored credentials → go to welcome
      debugPrint('StartupScreen: Navigating to /welcome');
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final startupState = ref.watch(appStartupProvider);

    // Handle navigation based on startup state
    startupState.whenOrNull(
      data: (user) {
        // Use addPostFrameCallback to avoid navigation during build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleNavigation(user);
        });
      },
      error: (error, stack) {
        // Error during initialization → fail-safe to welcome screen
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted || _hasNavigated) return;
          _hasNavigated = true;
          context.go('/');
        });
      },
    );

    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // KIKO Logo - pixel-perfect dimensions from Figma
              SvgPicture.asset(
                AssetPaths.logoLight,
                width: 299.52,
                height: 120,
              ),
              
              const SizedBox(height: 14),
              
              // Tagline: "Kommunikation kinderleicht!" with colored letters
              _buildTagline(),
              
              const SizedBox(height: 48),
              
              // Loading indicator - subtle and minimal
              SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary.withValues(alpha: 0.6)),
                  strokeWidth: 2.5,
                ),
              ),
              
              // Optional: Show error message if initialization failed
              if (startupState.hasError) ...[
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Initialisierung fehlgeschlagen',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
