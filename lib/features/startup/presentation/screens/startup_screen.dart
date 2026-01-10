import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kikocode/core/constants/asset_paths.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'package:kikocode/features/startup/presentation/providers/startup_providers.dart';

/// Startup screen that initializes the app and checks authentication status
/// 
/// This screen:
/// - Displays the KIKO logo (pixel-perfect from Figma: 299.52 x 120)
/// - Shows the colorful tagline "Kommunikation kinderleicht!"
/// - Shows a subtle loading indicator while initializing
/// - Checks authentication status via Supabase
/// - Routes to appropriate screen:
///   - Authenticated → /home
///   - Not authenticated → /welcome
///   - Error → /welcome (fail-safe)
class StartupScreen extends ConsumerWidget {
  const StartupScreen({super.key});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startupState = ref.watch(appStartupProvider);

    // Handle navigation based on startup state
    startupState.whenOrNull(
      data: (user) {
        // Use addPostFrameCallback to avoid navigation during build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!context.mounted) return;
          
          if (user != null) {
            // User is authenticated → go to home
            context.go('/home');
          } else {
            // User is not authenticated → go to welcome
            context.go('/');
          }
        });
      },
      error: (error, stack) {
        // Error during initialization → fail-safe to welcome screen
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!context.mounted) return;
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
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary.withOpacity(0.6)),
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
