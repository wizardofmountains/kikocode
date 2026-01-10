# Complex Layout Example: Dashboard with Responsive Grid

This example demonstrates building a complex, responsive dashboard layout from a Figma design.

## Figma Design Overview

**Desktop Layout (1024px+):**
- 2-column grid for main content
- Sidebar navigation (280px fixed)
- Cards in 3-column grid

**Tablet Layout (768px - 1023px):**
- Single column for main content
- Collapsible sidebar
- Cards in 2-column grid

**Mobile Layout (<768px):**
- Stack layout
- Bottom navigation
- Cards in 1-column

## Implementation

### Step 1: Create Responsive Layout Structure

```dart
import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'package:kikocode/core/components/components.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBreakpoints.responsive(
      context,
      mobile: const _MobileDashboard(),
      tablet: const _TabletDashboard(),
      desktop: const _DesktopDashboard(),
    );
  }
}
```

### Step 2: Mobile Layout

```dart
class _MobileDashboard extends StatefulWidget {
  const _MobileDashboard();

  @override
  State<_MobileDashboard> createState() => _MobileDashboardState();
}

class _MobileDashboardState extends State<_MobileDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: 'Dashboard',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          _DashboardContent(),
          _AnalyticsContent(),
          _SettingsContent(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          AppBottomNavItem(
            icon: Icons.dashboard_outlined,
            activeIcon: Icons.dashboard,
            label: 'Dashboard',
          ),
          AppBottomNavItem(
            icon: Icons.analytics_outlined,
            activeIcon: Icons.analytics,
            label: 'Analytics',
          ),
          AppBottomNavItem(
            icon: Icons.settings_outlined,
            activeIcon: Icons.settings,
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
```

### Step 3: Tablet Layout

```dart
class _TabletDashboard extends StatefulWidget {
  const _TabletDashboard();

  @override
  State<_TabletDashboard> createState() => _TabletDashboardState();
}

class _TabletDashboardState extends State<_TabletDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppHeader(
        title: 'Dashboard',
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: const _DashboardContent(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 32, color: AppColors.primary),
                ),
                AppSpacing.v3,
                Text(
                  'John Doe',
                  style: AppTypography.h5.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.dashboard, 'Dashboard', true),
          _buildDrawerItem(Icons.analytics, 'Analytics', false),
          _buildDrawerItem(Icons.people, 'Users', false),
          _buildDrawerItem(Icons.settings, 'Settings', false),
          const Divider(),
          _buildDrawerItem(Icons.logout, 'Logout', false),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, bool selected) {
    return ListTile(
      leading: Icon(
        icon,
        color: selected ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(
        title,
        style: AppTypography.bodyBase.copyWith(
          color: selected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      selected: selected,
      selectedTileColor: AppColors.primary50,
      onTap: () {},
    );
  }
}
```

### Step 4: Desktop Layout

```dart
class _DesktopDashboard extends StatelessWidget {
  const _DesktopDashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(
                right: BorderSide(color: AppColors.border),
              ),
            ),
            child: _buildSidebar(),
          ),
          // Main content
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                const Expanded(child: _DashboardContent()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Column(
      children: [
        // Logo and profile
        Container(
          padding: AppSpacing.all6,
          child: Row(
            children: [
              Icon(Icons.dashboard, size: 32, color: AppColors.primary),
              AppSpacing.h3,
              Text('Dashboard', style: AppTypography.h5),
            ],
          ),
        ),
        const Divider(height: 1),
        // Navigation items
        Expanded(
          child: ListView(
            padding: AppSpacing.symmetric(vertical: AppSpacing.spacing2),
            children: [
              _buildSidebarItem(Icons.dashboard, 'Dashboard', true),
              _buildSidebarItem(Icons.analytics, 'Analytics', false),
              _buildSidebarItem(Icons.people, 'Users', false),
              _buildSidebarItem(Icons.inventory, 'Products', false),
              _buildSidebarItem(Icons.receipt, 'Orders', false),
              AppSpacing.v4,
              Padding(
                padding: AppSpacing.h4,
                child: Text(
                  'SETTINGS',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
              _buildSidebarItem(Icons.settings, 'Settings', false),
              _buildSidebarItem(Icons.help_outline, 'Help', false),
            ],
          ),
        ),
        // User profile at bottom
        const Divider(height: 1),
        AppListTile(
          leading: const CircleAvatar(child: Text('JD')),
          title: 'John Doe',
          subtitle: 'john@example.com',
          trailing: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, bool selected) {
    return Container(
      margin: AppSpacing.h2,
      decoration: BoxDecoration(
        color: selected ? AppColors.primary50 : Colors.transparent,
        borderRadius: AppBorders.lg,
      ),
      child: AppListTile(
        leading: Icon(
          icon,
          color: selected ? AppColors.primary : AppColors.textSecondary,
        ),
        title: title,
        contentPadding: AppSpacing.symmetric(
          horizontal: AppSpacing.spacing4,
          vertical: AppSpacing.spacing2,
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 64,
      padding: AppSpacing.h6,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: AppBorders.full,
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          AppSpacing.h4,
          IconButton(
            icon: const AppNotificationBadge(
              count: 3,
              showDot: false,
            ),
            onPressed: () {},
          ),
          AppSpacing.h2,
          const CircleAvatar(child: Text('JD')),
        ],
      ),
    );
  }
}
```

### Step 5: Dashboard Content (Shared)

```dart
class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.all6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome back, John!', style: AppTypography.h2),
                  AppSpacing.v2,
                  Text(
                    "Here's what's happening today",
                    style: AppTypography.bodyBase.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              AppButton(
                label: 'New Report',
                icon: Icons.add,
                onPressed: () {},
              ),
            ],
          ),
          AppSpacing.v6,
          // Stats grid
          _buildStatsGrid(context),
          AppSpacing.v6,
          // Charts section
          _buildChartsSection(),
          AppSpacing.v6,
          // Recent activity
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
    final columns = AppBreakpoints.device(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 4,
    );

    final stats = [
      _StatData('Total Revenue', '\$45,231', Icons.attach_money, '+12.5%', true),
      _StatData('New Users', '1,234', Icons.people, '+5.2%', true),
      _StatData('Active Sessions', '542', Icons.show_chart, '-2.1%', false),
      _StatData('Conversion Rate', '3.24%', Icons.trending_up, '+0.8%', true),
    ];

    if (isMobile) {
      return Column(
        children: stats
            .map((stat) => Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.spacing4),
                  child: _buildStatCard(stat),
                ))
            .toList(),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - ((columns - 1) * 16)) / columns;
        return Wrap(
          spacing: AppSpacing.spacing4,
          runSpacing: AppSpacing.spacing4,
          children: stats
              .map((stat) => SizedBox(
                    width: cardWidth,
                    child: _buildStatCard(stat),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildStatCard(_StatData stat) {
    return AppCard(
      elevation: AppCardElevation.low,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIconCircle(
                icon: stat.icon,
                size: 40,
                backgroundColor: AppColors.primary100,
                iconColor: AppColors.primary700,
              ),
              AppBadge(
                label: stat.change,
                variant: stat.isPositive
                    ? AppBadgeVariant.success
                    : AppBadgeVariant.error,
                size: AppBadgeSize.small,
              ),
            ],
          ),
          AppSpacing.v4,
          Text(
            stat.label,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          AppSpacing.v1,
          Text(stat.value, style: AppTypography.h3),
        ],
      ),
    );
  }

  Widget _buildChartsSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Revenue Overview', style: AppTypography.h4),
              AppButton(
                label: 'Last 7 days',
                variant: AppButtonVariant.outline,
                size: AppButtonSize.small,
                icon: Icons.arrow_drop_down,
                iconPosition: IconPosition.right,
                onPressed: () {},
              ),
            ],
          ),
          AppSpacing.v4,
          // Placeholder for chart
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: AppBorders.lg,
            ),
            child: Center(
              child: Text(
                'Chart Placeholder',
                style: AppTypography.bodyBase.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Activity', style: AppTypography.h4),
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
            ],
          ),
          AppSpacing.v4,
          ...[
            _ActivityItem('New order received', '#1234', '2 min ago', Icons.shopping_bag),
            _ActivityItem('User registered', 'john@example.com', '15 min ago', Icons.person_add),
            _ActivityItem('Payment processed', '\$125.00', '1 hour ago', Icons.payment),
            _ActivityItem('Report generated', 'Monthly Report', '3 hours ago', Icons.description),
          ].map((activity) => Column(
                children: [
                  AppListTile(
                    leading: AppIconCircle(
                      icon: activity.icon,
                      size: 40,
                      backgroundColor: AppColors.primary50,
                      iconColor: AppColors.primary,
                    ),
                    title: activity.title,
                    subtitle: '${activity.subtitle} • ${activity.time}',
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  if (activity != _ActivityItem('Report generated', 'Monthly Report', '3 hours ago', Icons.description))
                    const Divider(height: 1),
                ],
              )),
        ],
      ),
    );
  }
}

class _StatData {
  final String label;
  final String value;
  final IconData icon;
  final String change;
  final bool isPositive;

  _StatData(this.label, this.value, this.icon, this.change, this.isPositive);
}

class _ActivityItem {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;

  _ActivityItem(this.title, this.subtitle, this.time, this.icon);
}

// Placeholder for other tabs
class _AnalyticsContent extends StatelessWidget {
  const _AnalyticsContent();
  @override
  Widget build(BuildContext context) => const Center(child: Text('Analytics'));
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent();
  @override
  Widget build(BuildContext context) => const Center(child: Text('Settings'));
}
```

## Key Concepts

### 1. Responsive Design
- Use `AppBreakpoints.responsive()` for different layouts
- Adjust column counts based on screen size
- Adapt navigation patterns (bottom nav vs sidebar)

### 2. Adaptive Layouts
- Mobile: Stack layout with bottom navigation
- Tablet: Drawer navigation with hybrid layout
- Desktop: Fixed sidebar with top search bar

### 3. Grid Systems
- Use `Wrap` with spacing for responsive grids
- Calculate card widths based on columns and gaps
- Stack cards vertically on mobile

### 4. Component Reuse
- Share content widget across layouts
- Extract stat cards as reusable components
- Consistent card styling throughout

## Testing

```dart
testWidgets('Dashboard adapts to screen size', (tester) async {
  // Mobile
  tester.binding.window.physicalSizeTestValue = const Size(375, 667);
  await tester.pumpWidget(MaterialApp(home: DashboardScreen()));
  expect(find.byType(AppBottomNav), findsOneWidget);
  expect(find.byType(Drawer), findsNothing);

  // Desktop
  tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);
  await tester.pumpWidget(MaterialApp(home: DashboardScreen()));
  expect(find.byType(AppBottomNav), findsNothing);
  expect(find.text('Dashboard'), findsWidgets);
});
```

---

**Related:** See [Simple Screen Example](simple-screen.md) for basic patterns
