import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kikocode/core/components/atoms/app_button.dart';
import 'package:kikocode/core/components/atoms/app_input.dart';
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
  late final TextEditingController _usernameController;
  final _passwordController = TextEditingController();
  
  // Validation state
  String? _passwordError;
  
  @override
  void initState() {
    super.initState();
    // Pre-fill username from route parameter
    _usernameController = TextEditingController(text: widget.username);
  }
  
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  void _handleVerification() {
    // Reset errors
    setState(() {
      _passwordError = null;
    });

    // Validate fields
    bool hasError = false;
    
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Passwort erforderlich!';
      });
      hasError = true;
    }

    // If no errors, proceed
    if (!hasError) {
      context.pushReplacement('/loading', extra: widget.username);
    }
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
            
            // Username field (read-only, prefilled) - top 325px, left 22px
            Positioned(
              top: 325,
              left: 22,
              right: 22,
              child: AppInput(
                controller: _usernameController,
                label: 'Benutzername',
                hintText: 'Benutzername',
                readOnly: true,
                size: AppInputSize.medium,
              ),
            ),
            
            // Password field - top 398px, left 22px
            Positioned(
              top: 398,
              left: 22,
              right: 22,
              child: AppInput(
                controller: _passwordController,
                label: 'Passwort',
                hintText: 'Passwort',
                obscureText: true,
                errorText: _passwordError,
                size: AppInputSize.medium,
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
                child: SizedBox(
                  width: 140,
                  child: AppButton(
                    label: 'Anmelden',
                    onPressed: _handleVerification,
                    variant: AppButtonVariant.primary,
                    size: AppButtonSize.medium,
                  ),
                ),
              ),
            ),
            
            // Face ID overlay at top - only show on mobile
            if (!kIsWeb)
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
