import 'package:flutter/material.dart';
import '../../features/messages/presentation/widgets/custom_tab_bar.dart';
import '../../features/home/presentation/screens/main_screen.dart';
import '../../features/messages/presentation/screens/message_status_screen.dart';
import '../design_system/colors.dart';

/// Main scaffold with bottom navigation
/// Manages navigation between main app sections
class MainScaffold extends StatefulWidget {
  final int initialTab;

  const MainScaffold({
    super.key,
    this.initialTab = 0,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
  }

  // Placeholder screens for tabs that aren't implemented yet
  Widget _buildCalendarScreen() {
    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceHighest,
        elevation: 0,
        title: const Text('Kalender'),
      ),
      body: const Center(
        child: Text('Kalender Screen - Coming Soon'),
      ),
    );
  }

  Widget _buildTeamScreen() {
    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceHighest,
        elevation: 0,
        title: const Text('Team'),
      ),
      body: const Center(
        child: Text('Team Screen - Coming Soon'),
      ),
    );
  }

  Widget _buildSettingsScreen() {
    return Scaffold(
      backgroundColor: AppColors.surfaceBase,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceHighest,
        elevation: 0,
        title: const Text('Einstellungen'),
      ),
      body: const Center(
        child: Text('Einstellungen Screen - Coming Soon'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define the screens for each tab
    final List<Widget> screens = [
      const MainScreen(), // Tab 0: Home
      _buildCalendarScreen(), // Tab 1: Kalender
      _buildTeamScreen(), // Tab 2: Team
      const MessageStatusScreen(), // Tab 3: Nachrichten
      _buildSettingsScreen(), // Tab 4: Einstellungen
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomTabBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        badgeCount: 3, // Example badge count for messages
      ),
    );
  }
}
