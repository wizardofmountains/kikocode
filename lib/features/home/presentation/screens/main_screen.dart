import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kikocode/core/constants/asset_paths.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import '../widgets/news_card.dart';
import '../widgets/groups_section.dart';
import '../widgets/action_card.dart';
import '../widgets/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  final String username;
  
  const MainScreen({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.all5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with logo and profile
                    _buildHeader(),
                    AppSpacing.v5,
                    
                    // Greeting
                    Text(
                      'Hallo $username, wie geht\'s Dir heute?',
                      style: AppTypography.bodyBase.copyWith(
                        fontWeight: AppTypography.medium,
                      ),
                    ),
                    AppSpacing.v5,
                    
                    // News section
                    const NewsCard(),
                    AppSpacing.v5,
                    
                    // Groups section
                    const GroupsSection(),
                    AppSpacing.v5,
                    
                    // Bottom action cards
                    Row(
                      children: [
                        Expanded(
                          child: ActionCard(
                            title: 'Meine Aufgaben',
                            onTap: () {},
                          ),
                        ),
                        AppSpacing.h4,
                        Expanded(
                          child: ActionCard(
                            title: 'Abstimmung/\nUmfrage',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.v20, // Space for bottom nav
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
          AssetPaths.logoLight,
          width: 120,
          height: 60,
        ),
        // Profile photo
        CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.background,
          child: Text(
            'A',
            style: AppTypography.bodyLarge.copyWith(
              fontSize: AppTypography.xl,
              fontWeight: AppTypography.semiBold,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

