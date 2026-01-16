import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kikocode/core/components/atoms/app_button.dart';
import 'package:kikocode/core/components/atoms/app_input.dart';
import 'package:kikocode/core/constants/asset_paths.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'package:kikocode/features/auth/providers/auth_providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Login screen with username and password fields
/// 
/// Pixel-perfect implementation matching Figma mockup
/// Integrates with Supabase authentication and Face ID setup
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Validation state
  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Reset errors
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    // Validate fields
    bool hasError = false;
    
    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = 'E-Mail/Benutzername erforderlich!';
      });
      hasError = true;
    }
    
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Passwort erforderlich!';
      });
      hasError = true;
    }

    if (hasError) return;

    // Attempt login
    setState(() {
      _isLoading = true;
    });

    try {
      // Sign in using the provider
      await ref.read(authStateProvider.notifier).signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      // Check the repository directly for the current user
      final authRepository = ref.read(authRepositoryProvider);
      final user = authRepository.currentUser;
      
      if (user != null) {
        // Login successful - proceed to biometric setup
        await _promptBiometricSetup();
      } else {
        // No user - check if there was an error in the state
        final authState = ref.read(authStateProvider);
        if (authState.hasError) {
          setState(() {
            _isLoading = false;
            _passwordError = _extractErrorMessage(authState.error);
          });
        } else {
          setState(() {
            _isLoading = false;
            _passwordError = 'Ungültige Anmeldedaten';
          });
        }
      }
    } on AuthException catch (e) {
      if (!mounted) return;
      
      setState(() {
        _isLoading = false;
        _passwordError = _extractErrorMessage(e);
      });
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        _isLoading = false;
        _passwordError = _extractErrorMessage(e);
      });
    }
  }

  String _extractErrorMessage(dynamic error) {
    final errorString = error.toString();
    
    if (error is AuthException) {
      if (error.statusCode == 'invalid_credentials' ||
          error.message.contains('Invalid login credentials')) {
        return 'Ungültige Anmeldedaten';
      } else if (error.statusCode == 'email_not_confirmed' ||
          error.message.contains('Email not confirmed')) {
        return 'Bitte bestätigen Sie Ihre E-Mail';
      }
      return error.message.isNotEmpty ? error.message : 'Anmeldung fehlgeschlagen';
    }
    
    if (errorString.contains('Invalid login credentials') ||
        errorString.contains('Invalid login')) {
      return 'Ungültige Anmeldedaten';
    } else if (errorString.contains('Email not confirmed')) {
      return 'Bitte bestätigen Sie Ihre E-Mail';
    }
    
    return 'Anmeldung fehlgeschlagen';
  }

  Future<void> _promptBiometricSetup() async {
    final biometricService = ref.read(biometricServiceProvider);
    final isAvailable = await biometricService.isBiometricAvailable();
    final isAlreadyEnabled = await biometricService.isBiometricEnabled();

    if (!mounted) return;

    if (isAvailable && !isAlreadyEnabled) {
      // Show dialog to enable biometric
      final biometricName = await biometricService.getBiometricTypeName();
      
      if (!mounted) return;
      
      final shouldEnable = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.surfaceBase,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            '$biometricName aktivieren?',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          content: Text(
            'Möchten Sie $biometricName für die schnelle Anmeldung aktivieren?',
            style: AppTypography.bodyBase.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Nein, danke',
                style: AppTypography.bodyBase.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Aktivieren',
                style: AppTypography.buttonBase,
              ),
            ),
          ],
        ),
      );

      if (shouldEnable == true) {
        // Authenticate once to confirm setup
        debugPrint('LoginScreen: User chose to enable biometric');
        final result = await biometricService.authenticate(
          localizedReason: '$biometricName einrichten',
        );

        debugPrint('LoginScreen: Biometric auth result = ${result.isSuccess}');
        if (result.isSuccess) {
          await biometricService.setBiometricEnabled(true);
          debugPrint('LoginScreen: Biometric enabled and saved!');

          // Verify it was saved
          final verified = await biometricService.isBiometricEnabled();
          debugPrint('LoginScreen: Verification - isBiometricEnabled = $verified');
        }
      }
    }

    if (!mounted) return;

    // Navigate to success screen
    final profile = await ref.read(profileRepositoryProvider).getCurrentProfile();
    
    if (!mounted) return;
    
    context.go('/auth-success', extra: {
      'username': profile?.name ?? _emailController.text.split('@').first,
      'showFaceId': false,
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
            
            // Email/Username field - top 325px, left 22px
            Positioned(
              top: 325,
              left: 22,
              right: 22,
              child: AppInput(
                controller: _emailController,
                label: 'E-Mail/Benutzername',
                hintText: 'E-Mail/Benutzername',
                errorText: _emailError,
                size: AppInputSize.medium,
                enabled: !_isLoading,
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
                enabled: !_isLoading,
              ),
            ),
            
            // "Passwort vergessen?" - top calc(50% + 55px)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 + 55,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: _isLoading ? null : () {
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
                  width: 150,
                  child: AppButton(
                    label: 'Anmelden',
                    onPressed: _isLoading ? () {} : _handleLogin,
                    variant: AppButtonVariant.primary,
                    size: AppButtonSize.medium,
                    loading: _isLoading,
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
