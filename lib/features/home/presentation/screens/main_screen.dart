import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/news_card.dart';
import '../widgets/groups_section.dart';
import '../widgets/action_card.dart';
import '../widgets/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE0), // Beige background
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with logo and profile
                    _buildHeader(),
                    const SizedBox(height: 20),
                    
                    // Greeting
                    Text(
                      'Hallo Anna, wie geht\'s Dir heute?',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // News section
                    const NewsCard(),
                    const SizedBox(height: 20),
                    
                    // Groups section
                    const GroupsSection(),
                    const SizedBox(height: 20),
                    
                    // Bottom action cards
                    Row(
                      children: [
                        Expanded(
                          child: ActionCard(
                            title: 'Meine Aufgaben',
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ActionCard(
                            title: 'Abstimmung/\nUmfrage',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 80), // Space for bottom nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // KIKO Logo
        SvgPicture.asset(
          'assets/images/LogoLight.svg',
          width: 120,
          height: 60,
        ),
        // Profile photo
        CircleAvatar(
          radius: 25,
          backgroundColor: const Color(0xFFE9D5FF),
          child: Text(
            'A',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF9333EA),
            ),
          ),
        ),
      ],
    );
  }
}

