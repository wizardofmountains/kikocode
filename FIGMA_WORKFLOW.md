# Figma to Flutter Workflow Guide

Complete guide for converting Figma designs into production-ready Flutter applications.

## Table of Contents

1. [Overview](#overview)
2. [Pre-Development Phase](#pre-development-phase)
3. [Design Handoff](#design-handoff)
4. [Development Phase](#development-phase)
5. [Quality Assurance](#quality-assurance)
6. [Best Practices](#best-practices)

## Overview

This document outlines the complete workflow for transforming Figma designs into Flutter code, ensuring consistency, quality, and maintainability.

### Key Principles

- **Design Tokens First**: Extract all design tokens before coding
- **Component-Based**: Build reusable components following atomic design
- **Responsive by Default**: Consider all screen sizes from the start
- **Accessibility**: Ensure WCAG compliance throughout

## Pre-Development Phase

### 1. Design Review

Before starting development, review the design with the team:

**Checklist:**
- [ ] Design is complete and approved
- [ ] All screens/states are documented
- [ ] Interactive prototype available
- [ ] Edge cases covered (empty, loading, error states)
- [ ] Accessibility considerations documented
- [ ] Responsive behavior specified

### 2. Design System Audit

Compare Figma design with existing design system:

```dart
// Check if colors match design system
Figma: #A855F7 → AppColors.primary ✓
Figma: #3B82F6 → AppColors.secondary ✓
Figma: Custom color → Need to add to design system?

// Check if typography matches
Figma: 24px Bold → AppTypography.h3 ✓
Figma: Custom font → Need to add custom font?
```

**Action Items:**
- Identify new design tokens needed
- Update design system if required
- Document deviations from current system

### 3. Component Mapping

Map Figma components to Flutter components:

| Figma Component | Flutter Component | Status |
|----------------|-------------------|--------|
| Primary Button | AppButton(variant: primary) | ✓ Exists |
| Card | AppCard | ✓ Exists |
| Custom Slider | - | ❌ Need to build |

## Design Handoff

### 1. Figma Dev Mode

Enable Dev Mode in Figma for accurate measurements:

1. Click "Dev Mode" toggle (top right)
2. Select any layer to view:
   - Dimensions (width, height)
   - Spacing (padding, margins)
   - Colors (hex values)
   - Typography (font, size, weight, line height)
   - Effects (shadows, blur)

### 2. Asset Export

Export all required assets according to specifications:

**Images (PNG/JPG):**
```bash
# Export at multiple resolutions
image_name.png       # 1x
image_name@2x.png    # 2x
image_name@3x.png    # 3x
```

**Vectors (SVG):**
```bash
# Single resolution, optimize before export
icon_name.svg
```

**Fonts:**
- Export font files (.ttf or .otf)
- Include all weights used
- Verify licensing

**See:** [Asset Export Guide](ASSET_EXPORT_GUIDE.md) for detailed instructions

### 3. Extract Design Tokens

Document all design tokens from Figma:

**Colors:**
```dart
// Primary colors
Primary 500: #A855F7
Primary 600: #9333EA
Primary 700: #7E22CE

// Semantic colors
Success: #10B981
Warning: #F59E0B
Error: #EF4444
```

**Typography:**
```dart
// Heading 1
Font: Inter
Size: 36px
Weight: 700 (Bold)
Line Height: 44px
Letter Spacing: -0.02em

// Maps to: AppTypography.h1
```

**Spacing:**
```dart
// Common spacing values
xs: 4px
sm: 8px
md: 16px
lg: 24px
xl: 32px
```

**See:** [docs/figma/design-tokens.md](docs/figma/design-tokens.md)

## Development Phase

### 1. Setup

Create feature branch and set up development environment:

```bash
# Create feature branch
git checkout -b feature/user-profile-screen

# Ensure dependencies are up to date
flutter pub get

# Run app
flutter run
```

### 2. Build Layout Structure

Start with the overall layout structure:

```dart
class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: 'Profile',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.all6,
        child: Column(
          children: [
            _buildHeader(),
            AppSpacing.v6,
            _buildStats(),
            AppSpacing.v6,
            _buildSettings(),
          ],
        ),
      ),
    );
  }
}
```

### 3. Implement Components

Build UI using existing components:

```dart
Widget _buildHeader() {
  return AppCard(
    child: Column(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundColor: AppColors.primary100,
          child: Icon(Icons.person, size: 48),
        ),
        AppSpacing.v4,
        Text('John Doe', style: AppTypography.h3),
        AppSpacing.v2,
        Text(
          'john.doe@example.com',
          style: AppTypography.bodyBase.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    ),
  );
}
```

### 4. Extract Design Values

Reference Figma for exact values:

```dart
// ✅ GOOD: Use design system
Container(
  padding: AppSpacing.all6,  // 24px from Figma
  decoration: BoxDecoration(
    color: AppColors.surface,
    borderRadius: AppBorders.xl,  // 16px from Figma
    boxShadow: AppShadows.md,
  ),
)

// ❌ BAD: Hardcode values
Container(
  padding: EdgeInsets.all(24.0),
  decoration: BoxDecoration(
    color: Color(0xFFFFFFFF),
    borderRadius: BorderRadius.circular(16),
  ),
)
```

### 5. Handle Responsive Design

Implement responsive behavior:

```dart
Widget build(BuildContext context) {
  return AppBreakpoints.responsive(
    context,
    mobile: _buildMobileLayout(),
    tablet: _buildTabletLayout(),
    desktop: _buildDesktopLayout(),
  );
}

Widget _buildMobileLayout() {
  return Column(
    children: [
      _buildHeader(),
      _buildContent(),
    ],
  );
}

Widget _buildDesktopLayout() {
  return Row(
    children: [
      Expanded(flex: 1, child: _buildHeader()),
      Expanded(flex: 2, child: _buildContent()),
    ],
  );
}
```

### 6. Implement States

Add loading, error, and empty states:

```dart
Widget build(BuildContext context) {
  if (isLoading) {
    return Center(child: CircularProgressIndicator());
  }
  
  if (error != null) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: AppColors.error),
          AppSpacing.v4,
          Text('Something went wrong', style: AppTypography.h4),
          AppSpacing.v2,
          Text(error!, style: AppTypography.bodyBase),
          AppSpacing.v4,
          AppButton(
            label: 'Retry',
            onPressed: _retry,
          ),
        ],
      ),
    );
  }
  
  if (items.isEmpty) {
    return Center(
      child: Text('No items found', style: AppTypography.bodyBase),
    );
  }
  
  return _buildContent();
}
```

### 7. Add Interactions

Implement user interactions from prototype:

```dart
AppButton(
  label: 'Save Changes',
  onPressed: () async {
    // Show loading state
    setState(() => isLoading = true);
    
    try {
      await _saveProfile();
      
      // Show success feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: AppColors.success,
        ),
      );
      
      // Navigate back
      context.pop();
    } catch (e) {
      // Show error feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  },
)
```

## Quality Assurance

### 1. Visual Comparison

Compare implementation with Figma design:

**Tools:**
- Figma Mirror (mobile preview)
- Side-by-side comparison
- Pixel Perfect overlay tools

**Check:**
- [ ] Colors match exactly
- [ ] Typography is consistent
- [ ] Spacing is accurate
- [ ] Alignment is correct
- [ ] Shadows/elevation match
- [ ] Border radius matches

### 2. Responsive Testing

Test on multiple screen sizes:

```bash
# Run on different devices
flutter run -d iphone-14-pro
flutter run -d pixel-7
flutter run -d ipad-pro

# Or use Flutter DevTools
flutter run --observatory-port=9200
```

**Test:**
- [ ] Mobile portrait (320px - 480px)
- [ ] Mobile landscape
- [ ] Tablet portrait (768px - 1024px)
- [ ] Desktop (1280px+)

### 3. Accessibility Testing

Ensure WCAG compliance:

```dart
// Add semantic labels
Image.asset(
  AssetPaths.logoLight,
  semanticLabel: 'KIKO logo',
)

// Ensure sufficient touch targets (44x44 minimum)
IconButton(
  icon: Icon(Icons.close),
  iconSize: 24,
  padding: EdgeInsets.all(10), // Total: 44x44
  onPressed: () {},
)

// Provide alternative text
Semantics(
  label: 'Profile picture',
  child: CircleAvatar(...),
)
```

**Check:**
- [ ] Color contrast ratios (4.5:1 minimum)
- [ ] Touch targets (44x44 minimum)
- [ ] Semantic labels present
- [ ] Screen reader compatible
- [ ] Keyboard navigation (web/desktop)

### 4. Performance Testing

Verify performance:

```bash
# Profile widget rebuilds
flutter run --profile

# Check app size
flutter build apk --analyze-size
```

**Check:**
- [ ] No unnecessary rebuilds
- [ ] Images optimized
- [ ] Smooth animations (60fps)
- [ ] Fast initial load

## Best Practices

### 1. Code Organization

```dart
// ✅ GOOD: Clear structure
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
  
  Widget _buildAppBar() { /* ... */ }
  Widget _buildBody() { /* ... */ }
  Widget _buildHeader() { /* ... */ }
}

// ❌ BAD: Everything in build method
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(/* 50 lines */),
      body: Column(/* 200 lines */),
    );
  }
}
```

### 2. Component Reusability

```dart
// ✅ GOOD: Extract reusable components
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  
  const StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });
  
  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Icon(icon, size: 32, color: AppColors.primary),
          AppSpacing.v2,
          Text(value, style: AppTypography.h3),
          Text(label, style: AppTypography.bodySmall),
        ],
      ),
    );
  }
}

// Usage
Row(
  children: [
    StatCard(label: 'Posts', value: '42', icon: Icons.article),
    StatCard(label: 'Followers', value: '1.2K', icon: Icons.people),
  ],
)
```

### 3. Design System Consistency

Always use design system tokens:

```dart
// Colors
AppColors.primary, AppColors.surface, AppColors.error

// Typography
AppTypography.h1, AppTypography.bodyBase

// Spacing
AppSpacing.all4, AppSpacing.v6

// Borders
AppBorders.lg, AppBorders.full

// Shadows
AppShadows.md, AppShadows.lg
```

### 4. Documentation

Document complex components:

```dart
/// User profile header component
/// 
/// Displays user avatar, name, and bio with edit button.
/// 
/// Example:
/// ```dart
/// ProfileHeader(
///   user: currentUser,
///   onEdit: () => context.push('/profile/edit'),
/// )
/// ```
class ProfileHeader extends StatelessWidget {
  /// The user to display
  final User user;
  
  /// Callback when edit button is pressed
  final VoidCallback? onEdit;
  
  const ProfileHeader({
    required this.user,
    this.onEdit,
  });
  
  // ...
}
```

## Additional Resources

- [Asset Export Guide](ASSET_EXPORT_GUIDE.md)
- [Design Token Extraction](docs/figma/design-tokens.md)
- [Component Mapping](docs/figma/component-mapping.md)
- [Handoff Template](docs/figma/handoff-template.md)
- [Design System Documentation](DESIGN_SYSTEM.md)

## Support

For questions or issues:
1. Check documentation in `/docs/`
2. Review component showcase at `/showcase/components`
3. Consult with design team
4. Refer to Flutter documentation

---

**Last Updated:** January 2026  
**Version:** 1.0.0  
**Maintainer:** Development Team
