import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE0), // Beige background
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // KIKO Logo
              _buildKikoLogo(),
              const SizedBox(height: 24),
              // Tagline
              Text(
                'Kommunikation kinderleicht!',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 60),
              // Get Started Button (optional - for navigation)
              GestureDetector(
                onTap: () => context.go('/login'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB794F6), // Purple color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Los geht\'s',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKikoLogo() {
    return SvgPicture.asset(
      'assets/images/LogoLight.svg',
      width: 250,  // Adjust size as needed
      height: 250,
    );
  }
}

