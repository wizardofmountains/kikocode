# Simple Screen Example: User Profile

This example shows how to implement a simple user profile screen from Figma mockup to Flutter code.

## Figma Design

**Design Overview:**
- Profile screen with header, avatar, user info, and action buttons
- Simple single-column layout
- Uses standard components from design system

## Step-by-Step Implementation

### Step 1: Analyze the Design

**Components identified:**
- App bar with back button and edit action
- Circular avatar (96x96)
- User name (Heading 3)
- Email address (Body text, secondary color)
- Bio text (Body text)
- Stats row (3 stat cards)
- Action buttons (2 buttons)

**Colors used:**
- Primary: #8B5CF6 (existing)
- Surface: #FFFFFF (existing)
- Text Primary: #1F2937 (existing)
- Text Secondary: #6B7280 (existing)

**Spacing:**
- Card padding: 24px (AppSpacing.spacing6)
- Section gap: 24px (AppSpacing.v6)
- Stat card gap: 12px (AppSpacing.h3)

### Step 2: Create the Screen Structure

```dart
import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'package:kikocode/core/components/components.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: 'Profile',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.all6,
        child: Column(
          children: [
            _buildHeader(),
            AppSpacing.v6,
            _buildStats(),
            AppSpacing.v6,
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AppCard(
      child: Column(
        children: [
          // Avatar
          CircleAvatar(
            radius: 48,
            backgroundColor: AppColors.primary100,
            child: Icon(
              Icons.person,
              size: 48,
              color: AppColors.primary700,
            ),
          ),
          AppSpacing.v4,
          // Name
          Text(
            'John Doe',
            style: AppTypography.h3,
          ),
          AppSpacing.v2,
          // Email
          Text(
            'john.doe@example.com',
            style: AppTypography.bodyBase.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          AppSpacing.v4,
          // Bio
          Text(
            'Flutter developer passionate about creating beautiful, performant mobile applications.',
            style: AppTypography.bodyBase,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('42', 'Posts', Icons.article)),
        AppSpacing.h3,
        Expanded(child: _buildStatCard('1.2K', 'Followers', Icons.people)),
        AppSpacing.h3,
        Expanded(child: _buildStatCard('328', 'Following', Icons.person_add)),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return AppCard(
      elevation: AppCardElevation.low,
      child: Column(
        children: [
          Icon(icon, size: 32, color: AppColors.primary),
          AppSpacing.v2,
          Text(value, style: AppTypography.h4),
          AppSpacing.v1,
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        AppButton(
          label: 'Edit Profile',
          onPressed: () {
            // Navigate to edit screen
          },
          fullWidth: true,
          icon: Icons.edit,
        ),
        AppSpacing.v3,
        AppButton(
          label: 'Settings',
          onPressed: () {
            // Navigate to settings
          },
          variant: AppButtonVariant.outline,
          fullWidth: true,
          icon: Icons.settings,
        ),
      ],
    );
  }
}
```

### Step 3: Extract Reusable Components

The stat card is reusable, so let's extract it:

```dart
/// A card displaying a statistic value with icon and label
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String value;
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      elevation: AppCardElevation.low,
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 32, color: AppColors.primary),
          AppSpacing.v2,
          Text(value, style: AppTypography.h4),
          AppSpacing.v1,
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// Usage
Row(
  children: [
    Expanded(child: StatCard(value: '42', label: 'Posts', icon: Icons.article)),
    AppSpacing.h3,
    Expanded(child: StatCard(value: '1.2K', label: 'Followers', icon: Icons.people)),
    AppSpacing.h3,
    Expanded(child: StatCard(value: '328', label: 'Following', icon: Icons.person_add)),
  ],
)
```

### Step 4: Add State Management

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// User model
class User {
  final String name;
  final String email;
  final String bio;
  final int postsCount;
  final int followersCount;
  final int followingCount;
  final String? avatarUrl;

  const User({
    required this.name,
    required this.email,
    required this.bio,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
    this.avatarUrl,
  });
}

// Provider
final userProvider = FutureProvider<User>((ref) async {
  // Fetch user data from API
  return const User(
    name: 'John Doe',
    email: 'john.doe@example.com',
    bio: 'Flutter developer...',
    postsCount: 42,
    followersCount: 1200,
    followingCount: 328,
  );
});

// Updated screen with state
class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return Scaffold(
      appBar: AppHeader(
        title: 'Profile',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: userAsync.when(
        data: (user) => _buildContent(user),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(error),
      ),
    );
  }

  Widget _buildContent(User user) {
    return SingleChildScrollView(
      padding: AppSpacing.all6,
      child: Column(
        children: [
          _buildHeader(user),
          AppSpacing.v6,
          _buildStats(user),
          AppSpacing.v6,
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildError(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: AppColors.error),
          AppSpacing.v4,
          Text('Failed to load profile', style: AppTypography.h4),
          AppSpacing.v2,
          Text(error.toString(), style: AppTypography.bodyBase),
        ],
      ),
    );
  }

  // Rest of the implementation...
}
```

### Step 5: Handle Different States

```dart
Widget _buildHeader(User user) {
  return AppCard(
    child: Column(
      children: [
        // Avatar with loading state
        if (user.avatarUrl != null)
          CircleAvatar(
            radius: 48,
            backgroundImage: NetworkImage(user.avatarUrl!),
          )
        else
          CircleAvatar(
            radius: 48,
            backgroundColor: AppColors.primary100,
            child: Text(
              _getInitials(user.name),
              style: AppTypography.h2.copyWith(
                color: AppColors.primary700,
              ),
            ),
          ),
        AppSpacing.v4,
        Text(user.name, style: AppTypography.h3),
        AppSpacing.v2,
        Text(
          user.email,
          style: AppTypography.bodyBase.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        if (user.bio.isNotEmpty) ...[
          AppSpacing.v4,
          Text(
            user.bio,
            style: AppTypography.bodyBase,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    ),
  );
}

String _getInitials(String name) {
  final parts = name.split(' ');
  if (parts.length >= 2) {
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
  return name[0].toUpperCase();
}
```

## Key Takeaways

1. **Start Simple:** Build the basic structure first
2. **Use Components:** Leverage existing components from the library
3. **Design Tokens:** Always use design system values
4. **Extract Reusable:** Identify and extract reusable components
5. **Add State:** Integrate state management for dynamic data
6. **Handle States:** Implement loading, error, and empty states
7. **Iterate:** Refine based on feedback

## Testing

```dart
// Widget test
testWidgets('UserProfileScreen displays user information', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        home: UserProfileScreen(),
      ),
    ),
  );

  // Wait for data to load
  await tester.pumpAndSettle();

  // Verify user info is displayed
  expect(find.text('John Doe'), findsOneWidget);
  expect(find.text('john.doe@example.com'), findsOneWidget);
  
  // Verify stats are displayed
  expect(find.text('42'), findsOneWidget);
  expect(find.text('Posts'), findsOneWidget);
});
```

---

**Next:** See [Complex Layout Example](complex-layout.md) for more advanced patterns
