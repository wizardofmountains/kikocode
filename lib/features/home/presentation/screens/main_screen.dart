import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import '../widgets/news_card.dart';
import '../widgets/groups_section.dart';
import '../widgets/action_card.dart';
import '../widgets/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.all5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    AppSpacing.v5,
                    Text(
                      'Hallo Anna, wie geht\'s Dir heute?',
                      style: AppTypography.bodyBase.copyWith(
                        fontWeight: AppTypography.medium,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    AppSpacing.v5,
                    const NewsCard(),
                    AppSpacing.v5,
                    const GroupsSection(),
                    AppSpacing.v5,
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
                    AppSpacing.v20,
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
        SvgPicture.asset(
          'assets/images/LogoLight.svg',
          width: 120,
          height: 60,
        ),
        CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.primary200,
          child: Text(
            'A',
            style: AppTypography.h5.copyWith(
              color: AppColors.purple600,
            ),
          ),
        ),
      ],
    );
  }
}

