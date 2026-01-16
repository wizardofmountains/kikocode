import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kikocode/core/constants/asset_paths.dart';
import 'package:kikocode/core/design_system/design_system.dart';

/// Loading/Success screen showing successful Face ID authentication
/// 
/// Pixel-perfect implementation matching Figma mockup
class LoadingScreen extends StatefulWidget {
  final String username;
  
  const LoadingScreen({
    super.key,
    required this.username,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Show success state for 1.5 seconds then navigate to main app
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        // Navigate back to welcome (would go to main app in production)
        context.go('/');
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
            // Logo - top 175px (slightly lower than login)
            Positioned(
              top: 175,
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
            
            // "Hallo [username]!" - top 392px
            Positioned(
              top: 392,
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
            
            // Face ID Success overlay at top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildFaceIdSuccessOverlay(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaceIdSuccessOverlay() {
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
              width: 143,
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Green circle background
                  SvgPicture.asset(
                    AssetPaths.iconCheckmarkCircle,
                    width: 70,
                    height: 70,
                  ),
                  // Checkmark symbol
                  Text(
                    '✓',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF87FA89), // Light green
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
