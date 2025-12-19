import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coolicons/coolicons.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({super.key});

  @override
  ConsumerState<VerificationScreen> createState() =>
      _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE0), // Beige background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // KIKO Logo
                  _buildKikoLogo(),
                  const SizedBox(height: 32),
                  // Greeting
                  Text(
                    'Halllo!',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Verification Form
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Username Field
                        _buildInputField(
                          controller: _usernameController,
                          label: 'Benutzername',
                          hint: 'annagruber1',
                        ),
                        const SizedBox(height: 16),
                        // Password Field
                        _buildInputField(
                          controller: _passwordController,
                          label: 'Passwort',
                          hint: '••••••••',
                          isPassword: true,
                        ),
                        const SizedBox(height: 32),
                        // Verification Button
                        _buildVerificationButton(),
                      ],
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

  Widget _buildKikoLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLetter('K', const Color(0xFFF4D06F)), // Yellow
        const SizedBox(width: 2),
        _buildLetter('I', const Color(0xFF7DD3C0)), // Teal
        const SizedBox(width: 2),
        _buildLetter('K', const Color(0xFFB794F6)), // Purple
        const SizedBox(width: 2),
        _buildLetter('O', const Color(0xFF92C6E8)), // Blue
      ],
    );
  }

  Widget _buildLetter(String letter, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.black,
          width: 2.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Text(
        letter,
        style: GoogleFonts.fredoka(
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          height: 1.0,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword && !_isPasswordVisible,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.black26,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Coolicons.hide
                          : Coolicons.show,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )
                : null,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Bitte ausfüllen';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildVerificationButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Handle verification logic here
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Verification erfolgreich!'),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFB794F6), // Purple color
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: Text(
        'Anmelden',
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

