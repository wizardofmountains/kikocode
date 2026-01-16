import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:kikocode/core/constants/asset_paths.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'package:kikocode/core/components/molecules/molecules.dart';
import '../widgets/groups_section.dart';
import '../widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  final String username;

  const MainScreen({
    super.key,
    required this.username,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? _selectedMoodIndex;

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

                    // Greeting - centered
                    Center(
                      child: Text(
                        'Hallo ${widget.username}, wie geht\'s Dir heute?',
                        style: AppTypography.bodyBase.copyWith(
                          fontWeight: AppTypography.semiBold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    AppSpacing.v3,

                    // Mood emoji selector - centered
                    Center(child: _buildMoodSelector()),
                    AppSpacing.v5,

                    // Events section with border
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.surfaceLow, width: 2),
                        borderRadius: AppBorders.xl2,
                      ),
                      child: AppEventsCard(
                        title: 'Meine Ereignisse',
                        events: [
                          AppEventItem(
                            dateLabel: 'Heute',
                            eventName: 'Laternenwanderung',
                            isActive: true,
                          ),
                          AppEventItem(
                            dateLabel: 'Mi, 10.',
                            eventName: 'Gemüsebuffet',
                          ),
                          AppEventItem(
                            dateLabel: 'Do, 11.',
                            eventName: 'Pyjamaparty',
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.v5,

                    // Groups section
                    const GroupsSection(),
                    AppSpacing.v5,

                    // Bottom action cards with border
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionCard(
                            title: 'Meine\nAufgaben',
                            onTap: () {},
                          ),
                        ),
                        AppSpacing.h4,
                        Expanded(
                          child: _buildActionCard(
                            title: 'Abstimmung &\nUmfrage',
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
      bottomNavigationBar: const BottomNavBar(
        currentIndex: 0,
        messageBadgeCount: 6,
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // KIKO Logo
        SvgPicture.asset(
          AssetPaths.logoLight,
          width: 150,
          height: 60,
        ),
        // Profile photo
        CircleAvatar(
          radius: 37.5,
          backgroundColor: AppColors.surfaceLow,
          backgroundImage: const NetworkImage(
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
          ),
        ),
      ],
    );
  }

  Widget _buildMoodSelector() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildMoodButton(0, FeatherIcons.frown), // sad face
        const SizedBox(width: 20),
        _buildMoodButton(1, FeatherIcons.meh), // neutral/meh face
        const SizedBox(width: 20),
        _buildMoodButton(2, FeatherIcons.smile), // happy face
      ],
    );
  }

  Widget _buildMoodButton(int index, IconData icon) {
    final isSelected = _selectedMoodIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMoodIndex = index;
        });
      },
      child: Icon(
        icon,
        size: 25,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.surfaceHighest,
          borderRadius: AppBorders.xl2,
          border: Border.all(color: AppColors.surfaceLow, width: 2),
          boxShadow: AppShadows.md,
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: AppTypography.bodyBase.copyWith(
              fontWeight: AppTypography.semiBold,
            ),
          ),
        ),
      ),
    );
  }
}

