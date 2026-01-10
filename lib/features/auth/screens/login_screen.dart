import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kikocode/core/components/atoms/app_button.dart';
import 'package:kikocode/core/components/atoms/app_input.dart';
import 'package:kikocode/core/constants/asset_paths.dart';
import 'package:kikocode/core/design_system/design_system.dart';

/// Login screen with username and password fields
/// 
/// Pixel-perfect implementation matching Figma mockup
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Validation state
  String? _usernameError;
  String? _passwordError;
  
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Reset errors
    setState(() {
      _usernameError = null;
      _passwordError = null;
    });

    // Validate fields
    bool hasError = false;
    
    if (_usernameController.text.isEmpty) {
      setState(() {
        _usernameError = 'Benutzername erforderlich!';
      });
      hasError = true;
    }
    
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Passwort erforderlich!';
      });
      hasError = true;
    }

    // If no errors, proceed
    if (!hasError) {
      context.push('/auth/verification', extra: _usernameController.text);
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
            
            // "Hallo!" - top 263px
            Positioned(
              top: 263,
              left: 0,
              right: 0,
              child: Text(
                'Hallo!',
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
                _usernameError ?? 'Benutzername',
                style: AppTypography.caption2.copyWith(
                  color: _usernameError != null ? AppColors.error : AppColors.textTertiary,
                ),
              ),
            ),
            
            // Username field - top 342px, left 22px
            Positioned(
              top: 342,
              left: 22,
              right: 22,
              child: AppInput(
                controller: _usernameController,
                hintText: 'Benutzername',
                errorText: _usernameError != null ? '' : null,
                size: AppInputSize.medium,
              ),
            ),
            
            // Password label - top 398px, left 42px
            Positioned(
              top: 398,
              left: 42,
              child: Text(
                _passwordError ?? 'Passwort',
                style: AppTypography.caption2.copyWith(
                  color: _passwordError != null ? AppColors.error : AppColors.textTertiary,
                ),
              ),
            ),
            
            // Password field - top 415px, left 22px
            Positioned(
              top: 415,
              left: 22,
              right: 22,
              child: AppInput(
                controller: _passwordController,
                hintText: 'Passwort',
                obscureText: true,
                errorText: _passwordError != null ? '' : null,
                size: AppInputSize.medium,
              ),
            ),
            
            // "Passwort vergessen?" - top calc(50% + 55px)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 + 55,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // Handle forgot password
                },
                child: Text(
                  'Passwort vergessen?',
                  style: AppTypography.footnote.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            
            // "Anmelden" button - top 550px, centered, 120x50
            Positioned(
              top: 550,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 120,
                  child: AppButton(
                    label: 'Anmelden',
                    onPressed: _handleLogin,
                    variant: AppButtonVariant.primary,
                    size: AppButtonSize.medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
