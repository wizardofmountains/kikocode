import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kikocode/core/constants/asset_paths.dart';
import 'package:kikocode/core/design_system/design_system.dart';

/// Verification screen showing Face ID authentication
/// 
/// Pixel-perfect implementation matching Figma mockup
class VerificationScreen extends StatefulWidget {
  final String username;
  
  const VerificationScreen({
    super.key,
    required this.username,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate Face ID authentication after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.pushReplacement('/auth/loading', extra: widget.username);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Logo - top 100px
            Positioned(
              top: 100,
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
            
            // "Hallo [username]!" - top 263px
            Positioned(
              top: 263,
              left: 0,
              right: 0,
              child: Text(
                'Hallo ${widget.username}!',
                style: AppTypography.largeTitle.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            // Username label - top 325px, left 42px
            Positioned(
              top: 325,
              left: 42,
              child: Text(
                'Benutzername',
                style: AppTypography.caption2.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            
            // Username field (filled, focused) - top 342px, left 22px
            Positioned(
              top: 342,
              left: 22,
              child: Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.surfaceHighest,
                  border: Border.all(
                    color: AppColors.secondary, // Green border for focused state
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.username,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            
            // Password label - top 398px, left 42px
            Positioned(
              top: 398,
              left: 42,
              child: Text(
                'Passwort',
                style: AppTypography.caption2.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            
            // Password field (filled, focused) - top 415px, left 22px
            Positioned(
              top: 415,
              left: 22,
              child: Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.surfaceHighest,
                  border: Border.all(
                    color: AppColors.secondary, // Green border for focused state
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '••••••••',
                  style: AppTypography.body.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            
            // "Passwort vergessen?" - top calc(50% + 55px)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 + 55,
              left: 0,
              right: 0,
              child: Text(
                'Passwort vergessen?',
                style: AppTypography.footnote.copyWith(
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            // "Anmelden" button - top 550px, centered
            Positioned(
              top: 550,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: AppColors.primaryLight,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryLight,
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Anmelden',
                    style: AppTypography.headline.copyWith(
                      color: AppColors.surfaceHigh,
                    ),
                  ),
                ),
              ),
            ),
            
            // Face ID overlay at top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildFaceIdOverlay(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaceIdOverlay() {
    return Container(
      height: 190,
      color: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            color: Colors.black.withOpacity(0.01),
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 145,
              height: 145,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.22),
                    blurRadius: 74,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AssetPaths.iconFaceId,
                width: 70,
                height: 70,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
