import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'package:kikocode/core/components/components.dart';

/// Component showcase screen for testing and documentation
/// 
/// Displays all available components with examples.
class ComponentShowcaseScreen extends StatefulWidget {
  const ComponentShowcaseScreen({super.key});

  @override
  State<ComponentShowcaseScreen> createState() =>
      _ComponentShowcaseScreenState();
}

class _ComponentShowcaseScreenState extends State<ComponentShowcaseScreen> {
  int _selectedTab = 0;
  int _bottomNavIndex = 0;
  bool _switchValue = false;
  bool _checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: 'Component Showcase',
        showBackButton: true,
      ),
      body: ListView(
        padding: AppSpacing.all6,
        children: [
          _buildSection(
            'Atoms',
            [
              _buildSubsection('Buttons', _buildButtons()),
              _buildSubsection('Inputs', _buildInputs()),
              _buildSubsection('Icons', _buildIcons()),
              _buildSubsection('Badges', _buildBadges()),
              _buildSubsection('Avatars', _buildAvatars()),
            ],
          ),
          AppSpacing.v8,
          _buildSection(
            'Molecules',
            [
              _buildSubsection('Cards', _buildCards()),
              _buildSubsection('List Tiles', _buildListTiles()),
              _buildSubsection('Form Fields', _buildFormFields()),
            ],
          ),
          AppSpacing.v8,
          _buildSection(
            'Organisms',
            [
              _buildSubsection('Headers', _buildHeaders()),
              _buildSubsection('Navigation', _buildNavigation()),
            ],
          ),
          AppSpacing.v16, // Extra space at bottom
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.h2),
        AppSpacing.v4,
        ...children,
      ],
    );
  }

  Widget _buildSubsection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.h4.copyWith(color: AppColors.primary),
        ),
        AppSpacing.v3,
        content,
        AppSpacing.v6,
      ],
    );
  }

  // ATOMS

  Widget _buildButtons() {
    return Wrap(
      spacing: AppSpacing.spacing3,
      runSpacing: AppSpacing.spacing3,
      children: [
        AppButton(
          label: 'Primary',
          onPressed: () {},
          variant: AppButtonVariant.primary,
        ),
        AppButton(
          label: 'Secondary',
          onPressed: () {},
          variant: AppButtonVariant.secondary,
        ),
        AppButton(
          label: 'Outline',
          onPressed: () {},
          variant: AppButtonVariant.outline,
        ),
        AppButton(
          label: 'Ghost',
          onPressed: () {},
          variant: AppButtonVariant.ghost,
        ),
        AppButton(
          label: 'Danger',
          onPressed: () {},
          variant: AppButtonVariant.danger,
        ),
        AppButton(
          label: 'With Icon',
          icon: Icons.add,
          onPressed: () {},
        ),
        AppButton(
          label: 'Loading',
          onPressed: () {},
          loading: true,
        ),
        AppButton(
          label: 'Disabled',
          onPressed: () {},
          enabled: false,
        ),
      ],
    );
  }

  Widget _buildInputs() {
    return Column(
      children: [
        AppInput(
          label: 'Email',
          hintText: 'Enter your email',
          prefixIcon: Icons.email,
        ),
        AppSpacing.v3,
        AppInput(
          label: 'Password',
          hintText: 'Enter password',
          prefixIcon: Icons.lock,
          obscureText: true,
        ),
        AppSpacing.v3,
        AppInput(
          label: 'Disabled',
          hintText: 'This is disabled',
          enabled: false,
        ),
      ],
    );
  }

  Widget _buildIcons() {
    return Wrap(
      spacing: AppSpacing.spacing4,
      runSpacing: AppSpacing.spacing4,
      children: [
        AppIcon(
          icon: Icons.home,
          size: AppIconSize.small,
          color: AppColors.primary,
        ),
        AppIcon(
          icon: Icons.search,
          size: AppIconSize.medium,
          color: AppColors.secondary,
        ),
        AppIcon(
          icon: Icons.favorite,
          size: AppIconSize.large,
          color: AppColors.error,
        ),
        AppIconCircle(
          icon: Icons.person,
          backgroundColor: AppColors.primary100,
          iconColor: AppColors.primary700,
        ),
        AppIconSquare(
          icon: Icons.settings,
          backgroundColor: AppColors.secondary100,
          iconColor: AppColors.secondary700,
        ),
      ],
    );
  }

  Widget _buildBadges() {
    return Wrap(
      spacing: AppSpacing.spacing3,
      runSpacing: AppSpacing.spacing3,
      children: [
        const AppBadge(
          label: 'Primary',
          variant: AppBadgeVariant.primary,
        ),
        const AppBadge(
          label: 'Success',
          variant: AppBadgeVariant.success,
        ),
        const AppBadge(
          label: 'Warning',
          variant: AppBadgeVariant.warning,
        ),
        const AppBadge(
          label: 'Error',
          variant: AppBadgeVariant.error,
        ),
        const AppBadge(
          label: 'With Icon',
          icon: Icons.check,
          variant: AppBadgeVariant.success,
        ),
        AppBadge(
          label: 'Deletable',
          variant: AppBadgeVariant.neutral,
          onDelete: () {},
        ),
        const AppNotificationBadge(count: 5),
        const AppNotificationBadge(count: 99),
        const AppNotificationBadge(showDot: true),
      ],
    );
  }

  Widget _buildAvatars() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Size variants
        Text('Sizes:', style: AppTypography.bodySmall),
        AppSpacing.v2,
        Wrap(
          spacing: AppSpacing.spacing3,
          runSpacing: AppSpacing.spacing3,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: const [
            AppAvatar(
              initials: 'SM',
              size: AppAvatarSize.small,
            ),
            AppAvatar(
              initials: 'MD',
              size: AppAvatarSize.medium,
            ),
            AppAvatar(
              initials: 'LG',
              size: AppAvatarSize.large,
            ),
            AppAvatar(
              initials: 'XL',
              size: AppAvatarSize.xlarge,
            ),
            AppAvatar(
              initials: 'XXL',
              size: AppAvatarSize.xxlarge,
            ),
          ],
        ),
        AppSpacing.v4,

        // Network image
        Text('Network Image:', style: AppTypography.bodySmall),
        AppSpacing.v2,
        const AppAvatar(
          imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
          size: AppAvatarSize.xlarge,
        ),
        AppSpacing.v4,

        // With online indicator
        Text('Online Indicator:', style: AppTypography.bodySmall),
        AppSpacing.v2,
        Wrap(
          spacing: AppSpacing.spacing3,
          children: const [
            AppAvatar(
              initials: 'ON',
              size: AppAvatarSize.large,
              showOnlineIndicator: true,
              isOnline: true,
            ),
            AppAvatar(
              initials: 'OFF',
              size: AppAvatarSize.large,
              showOnlineIndicator: true,
              isOnline: false,
            ),
          ],
        ),
        AppSpacing.v4,

        // Editable avatar
        Text('Editable:', style: AppTypography.bodySmall),
        AppSpacing.v2,
        AppAvatarEditable(
          avatar: const AppAvatar(
            initials: 'ED',
            size: AppAvatarSize.xlarge,
          ),
          onEditTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Edit avatar tapped')),
            );
          },
        ),
        AppSpacing.v4,

        // Avatar group
        Text('Avatar Group:', style: AppTypography.bodySmall),
        AppSpacing.v2,
        const AppAvatarGroup(
          avatars: [
            AppAvatarConfig(initials: 'AB'),
            AppAvatarConfig(initials: 'CD'),
            AppAvatarConfig(initials: 'EF'),
            AppAvatarConfig(initials: 'GH'),
            AppAvatarConfig(initials: 'IJ'),
            AppAvatarConfig(initials: 'KL'),
          ],
          maxDisplay: 4,
          size: AppAvatarSize.medium,
        ),
      ],
    );
  }

  // MOLECULES

  Widget _buildCards() {
    return Column(
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Simple Card', style: AppTypography.h5),
              AppSpacing.v2,
              Text(
                'This is a simple card with some content.',
                style: AppTypography.bodyBase,
              ),
            ],
          ),
        ),
        AppSpacing.v4,
        AppCardSection(
          header: Text('Card with Sections', style: AppTypography.h5),
          body: const Text('This card has header, body, and footer sections.'),
          footer: AppButton(
            label: 'Action',
            onPressed: () {},
            size: AppButtonSize.small,
          ),
          showDividers: true,
        ),
        AppSpacing.v4,
        AppImageCard(
          title: 'Image Card',
          description: 'A card with an image placeholder',
          imageHeight: 150,
          footer: Row(
            children: [
              const Icon(Icons.favorite_border, size: 20),
              AppSpacing.h2,
              const Text('24'),
              AppSpacing.h4,
              const Icon(Icons.comment_outlined, size: 20),
              AppSpacing.h2,
              const Text('8'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListTiles() {
    return Column(
      children: [
        const AppListTile(
          leading: Icon(Icons.person),
          title: 'John Doe',
          subtitle: 'Software Developer',
          trailing: Icon(Icons.chevron_right),
        ),
        const Divider(height: 1),
        AppAvatarListTile(
          avatar: const CircleAvatar(child: Text('JD')),
          title: 'Jane Doe',
          subtitle: 'Designer',
          trailing: const AppBadge(
            label: 'Online',
            variant: AppBadgeVariant.success,
            size: AppBadgeSize.small,
          ),
        ),
        const Divider(height: 1),
        AppCheckboxListTile(
          title: 'Checkbox List Tile',
          subtitle: 'With subtitle',
          value: _checkboxValue,
          onChanged: (value) {
            setState(() => _checkboxValue = value!);
          },
        ),
        const Divider(height: 1),
        AppSwitchListTile(
          title: 'Switch List Tile',
          subtitle: 'Toggle me',
          value: _switchValue,
          onChanged: (value) {
            setState(() => _switchValue = value);
          },
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        const AppFormField(
          label: 'Username',
          hintText: 'Enter your username',
          required: true,
        ),
        AppSpacing.v4,
        AppFormField(
          label: 'Email',
          hintText: 'Enter your email',
          prefixIcon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Email is required';
            return null;
          },
        ),
        AppSpacing.v4,
        const AppTextAreaFormField(
          label: 'Message',
          hintText: 'Enter your message',
          minLines: 3,
          maxLines: 5,
        ),
      ],
    );
  }

  // ORGANISMS

  Widget _buildHeaders() {
    return Column(
      children: [
        Text(
          'Standard header shown at top of screen',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        AppSpacing.v4,
        const AppLargeHeader(
          title: 'Large Header',
          subtitle: 'With subtitle and actions',
          actions: [Icon(Icons.settings)],
        ),
      ],
    );
  }

  Widget _buildNavigation() {
    return Column(
      children: [
        Text(
          'Bottom navigation examples:',
          style: AppTypography.bodyBase.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        AppSpacing.v3,
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: AppBorders.lg,
          ),
          child: AppCustomBottomNav(
            currentIndex: _bottomNavIndex,
            onTap: (index) {
              setState(() => _bottomNavIndex = index);
            },
            items: const [
              AppBottomNavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
              ),
              AppBottomNavItem(
                icon: Icons.search_outlined,
                activeIcon: Icons.search,
                label: 'Search',
              ),
              AppBottomNavItem(
                icon: Icons.favorite_outline,
                activeIcon: Icons.favorite,
                label: 'Favorites',
              ),
              AppBottomNavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
