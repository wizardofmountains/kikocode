import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kikocode/core/constants/asset_paths.dart';
import 'package:kikocode/core/design_system/design_system.dart';

/// Welcome/Splash screen with KIKO logo and tagline
/// 
/// First screen shown when app launches.
/// Shows colorful KIKO branding and tagline.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to login screen after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/auth/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      body: Stack(
        children: [
          // KIKO Logo - positioned exactly as in Figma
          Positioned(
            top: 158,
            left: 0,
            right: 0,
            child: Center(
              child: SvgPicture.asset(
                AssetPaths.logoLight,
                width: 299.522,
                height: 120,
              ),
            ),
          ),
          
          // Tagline with colorful letters - positioned exactly as in Figma
          Positioned(
            top: 292,
            left: 0,
            right: 0,
            child: _buildTagline(),
          ),
        ],
      ),
    );
  }

  /// Build the tagline "Kommunikation kinderleicht!" with colored letters
  /// K = purple, o = blue, k = yellow, i = mint green
  Widget _buildTagline() {
    return RichText(
      text: TextSpan(
        style: AppTypography.title2.copyWith(
          color: AppColors.textPrimary,
        ),
        children: const [
          TextSpan(
            text: 'K',
            style: TextStyle(color: AppColors.primary), // Purple K
          ),
          TextSpan(
            text: 'o',
            style: TextStyle(color: AppColors.accent), // Blue o
          ),
          TextSpan(text: 'mmunikation '),
          TextSpan(
            text: 'k',
            style: TextStyle(color: AppColors.accentYellow), // Yellow k
          ),
          TextSpan(
            text: 'i',
            style: TextStyle(color: AppColors.secondary), // Mint i
          ),
          TextSpan(text: 'nderleicht!'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
