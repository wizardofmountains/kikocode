# Design System Documentation

## Overview

This project includes a Figma-based Kiko design system for iOS-focused Flutter UIs, plus the legacy Tailwind-inspired system.

## Kiko Design System (Figma)

### What’s Included
- **Colors**: `AppColors.*Kiko` tokens (primary, secondary, surfaces, text)
- **Typography**: `KikoTypography` (Nunito / Nunito Sans)
- **Components**: `KikoPrimaryButton`, `KikoSecondaryButton`, `KikoTextField`, `KikoSearchField`, `KikoTabIcon`, `KikoShortcutButton`, `KikoLoadingIndicator`
- **Theme**: `AppTheme.lightTheme` aligned to the Figma palette

### Quick Usage
```dart
import 'package:kikocode/core/design_system/design_system.dart';

KikoPrimaryButton(label: 'Standard', onPressed: () {});
KikoTextField(hintText: 'Ich bin ein Textfeld.');
KikoSearchField(hintText: 'Ich bin eine Suchanfrage.', isActive: true);
```

## What's Included

### 📁 Core Design System Files

All design system files are located in `/lib/core/design_system/`:

1. **`colors.dart`** - Complete Tailwind color palette with 400+ colors
   - Grayscale (slate, gray, zinc)
   - Primary colors (purple, violet, indigo, blue)
   - Success/Error/Warning colors (green, red, amber, orange)
   - Info colors (cyan, sky, teal)
   - Semantic aliases (primary, secondary, success, error, etc.)

2. **`typography.dart`** - Typography system with proper hierarchy
   - Display styles (display5-9) for hero text
   - Headings (h1-h6)
   - Body text (bodyLarge, bodyBase, bodySmall)
   - Labels and buttons
   - Monospace for code
   - Helper methods for text manipulation

3. **`spacing.dart`** - Consistent spacing scale (4px based)
   - Spacing values from 0-96 (0px to 384px)
   - EdgeInsets helpers
   - SizedBox helpers
   - Semantic aliases (xs, sm, md, lg, xl)

4. **`borders.dart`** - Border radius and border utilities
   - Border radius (sm, base, md, lg, xl, xl2, xl3, full)
   - Border widths (thin, 2, 4, 8)
   - Border utilities (all, symmetric, only)
   - Input border styles
   - Divider helpers

5. **`shadows.dart`** - Box shadow system
   - Shadow levels (none, sm, base, md, lg, xl, xl2)
   - Colored shadows (primary, success, error, etc.)
   - Drop shadows for images
   - Elevation helpers

6. **`breakpoints.dart`** - Responsive design utilities
   - Breakpoint values (xs, sm, md, lg, xl, xl2)
   - Screen type checks (isMobile, isTablet, isDesktop)
   - Responsive value selection
   - Responsive widget builders

7. **`theme.dart`** - Complete Material 3 theme integration
   - Light theme with design system colors
   - Dark theme support
   - Pre-configured component themes
   - System overlay styles

8. **`design_system.dart`** - Main export file
   - Single import for all design system modules
   - Comprehensive documentation

### 📚 Documentation Files

1. **`README.md`** - Complete documentation with examples
2. **`QUICK_REFERENCE.md`** - Cheat sheet for common patterns
3. **`examples.dart`** - Working example widgets

### 🎨 Integration

The design system has been integrated into the main app:

**`/lib/main.dart`**
- Now uses `AppTheme.lightTheme` and `AppTheme.darkTheme`
- Supports theme mode switching
- All Material components automatically styled

## Getting Started

### 1. Import the Design System

In any Dart file where you need design system utilities:

```dart
import 'package:kikocode/core/design_system/design_system.dart';
```

This single import gives you access to:
- `AppColors`
- `AppTypography`
- `AppSpacing`
- `AppBorders`
- `AppShadows`
- `AppBreakpoints`
- `AppTheme`

### 2. Use Design Tokens

Replace hardcoded values with design system tokens:

#### Before:
```dart
Container(
  color: Color(0xFFA855F7),
  padding: EdgeInsets.all(16.0),
  child: Text(
    'Hello',
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
)
```

#### After:
```dart
Container(
  color: AppColors.primary,
  padding: AppSpacing.all4,
  child: Text(
    'Hello',
    style: AppTypography.h3,
  ),
)
```

### 3. Build Responsive UIs

Use breakpoint utilities for responsive designs:

```dart
AppBreakpoints.responsive(
  context,
  mobile: _buildMobileLayout(),
  tablet: _buildTabletLayout(),
  desktop: _buildDesktopLayout(),
)
```

## Common Use Cases

### Creating a Button

```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    padding: AppSpacing.h6v3,
    shape: RoundedRectangleBorder(
      borderRadius: AppBorders.lg,
    ),
  ),
  child: Text('Click Me', style: AppTypography.buttonBase),
)
```

### Creating a Card

```dart
Container(
  padding: AppSpacing.all6,
  decoration: BoxDecoration(
    color: AppColors.surface,
    borderRadius: AppBorders.xl,
    boxShadow: AppShadows.md,
    border: AppBorders.all(color: AppColors.borderLight),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Card Title', style: AppTypography.h4),
      AppSpacing.v2,
      Text('Card content goes here', style: AppTypography.bodyBase),
    ],
  ),
)
```

### Creating an Input Field

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'Enter your email',
    prefixIcon: Icon(Icons.email),
    border: AppBorders.inputBorderDefault,
    focusedBorder: AppBorders.inputBorderFocused,
  ),
  style: AppTypography.bodyBase,
)
```

### Creating Status Badges

```dart
// Success badge
Container(
  padding: AppSpacing.symmetric(
    horizontal: AppSpacing.spacing3,
    vertical: AppSpacing.spacing1,
  ),
  decoration: BoxDecoration(
    color: AppColors.success100,
    borderRadius: AppBorders.full,
  ),
  child: Text(
    'Success',
    style: AppTypography.labelSmall.copyWith(
      color: AppColors.success700,
    ),
  ),
)

// Error badge
Container(
  padding: AppSpacing.symmetric(
    horizontal: AppSpacing.spacing3,
    vertical: AppSpacing.spacing1,
  ),
  decoration: BoxDecoration(
    color: AppColors.error100,
    borderRadius: AppBorders.full,
  ),
  child: Text(
    'Error',
    style: AppTypography.labelSmall.copyWith(
      color: AppColors.error700,
    ),
  ),
)
```

## Theme Integration

The app now uses the design system theme by default. All Material components are automatically styled:

- **AppBar**: Styled with proper elevation and colors
- **Buttons**: ElevatedButton, TextButton, OutlinedButton all pre-styled
- **Cards**: Default card styling with shadows and borders
- **Inputs**: TextField and TextFormField with consistent styling
- **Dialogs**: Modal dialogs with proper shadows and borders
- **Chips**: Chip widgets with consistent styling
- **And more**: ListTiles, Tooltips, Snackbars, etc.

## Color System

### Semantic Colors

Always prefer semantic colors for better maintainability:

```dart
AppColors.primary        // Main brand color
AppColors.secondary      // Secondary brand color
AppColors.success        // Success states
AppColors.warning        // Warning states
AppColors.error          // Error states
AppColors.info           // Information states

AppColors.textPrimary    // Main text
AppColors.textSecondary  // Secondary text
AppColors.textTertiary   // Tertiary text

AppColors.border         // Default borders
AppColors.background     // Page background
AppColors.surface        // Card/surface background
```

### Color Shades

Each color family has 11 shades (50-950):

```dart
AppColors.purple50   // Lightest
AppColors.purple100
AppColors.purple200
AppColors.purple300
AppColors.purple400
AppColors.purple500  // Base shade
AppColors.purple600
AppColors.purple700
AppColors.purple800
AppColors.purple900
AppColors.purple950  // Darkest
```

## Typography Scale

### Headings
- `h1` - 36px, bold - Page titles
- `h2` - 30px, bold - Section titles
- `h3` - 24px, semibold - Subsection titles
- `h4` - 20px, semibold - Card titles
- `h5` - 18px, semibold - Small card titles
- `h6` - 16px, semibold - List item titles

### Body Text
- `bodyLarge` - 18px - Large body text
- `bodyBase` - 16px - Default body text
- `bodySmall` - 14px - Secondary text
- `bodyXSmall` - 12px - Captions

### Specialized
- `buttonBase` - Button text
- `labelBase` - Form labels
- `caption` - Small annotations
- `codeBase` - Code/monospace text

## Spacing System

Based on 4px increments (Tailwind-style):

- `spacing1` = 4px
- `spacing2` = 8px
- `spacing3` = 12px
- `spacing4` = 16px (most common)
- `spacing6` = 24px (cards, sections)
- `spacing8` = 32px (large sections)

### Common Patterns

```dart
// Padding
Padding(padding: AppSpacing.all4)    // 16px all sides
Padding(padding: AppSpacing.all6)    // 24px all sides
Padding(padding: AppSpacing.h6v3)    // 24px horizontal, 12px vertical

// Spacing between widgets
Column(
  children: [
    Widget1(),
    AppSpacing.v4,  // 16px vertical gap
    Widget2(),
  ],
)

Row(
  children: [
    Widget1(),
    AppSpacing.h4,  // 16px horizontal gap
    Widget2(),
  ],
)
```

## Responsive Design

### Breakpoints

- **xs**: 0px - Small phones
- **sm**: 640px - Large phones
- **md**: 768px - Tablets
- **lg**: 1024px - Laptops
- **xl**: 1280px - Desktops
- **2xl**: 1536px - Large desktops

### Responsive Utilities

```dart
// Check screen type
if (AppBreakpoints.isMobile(context)) {
  // Mobile layout
} else if (AppBreakpoints.isTablet(context)) {
  // Tablet layout
} else {
  // Desktop layout
}

// Responsive values
final columns = AppBreakpoints.device(
  context,
  mobile: 1,
  tablet: 2,
  desktop: 3,
);

// Responsive widgets
AppBreakpoints.responsive(
  context,
  mobile: MobileWidget(),
  tablet: TabletWidget(),
  desktop: DesktopWidget(),
)
```

## Best Practices

1. ✅ **Always use design tokens** instead of hardcoded values
2. ✅ **Use semantic colors** (`AppColors.primary` not `AppColors.purple500`)
3. ✅ **Use spacing constants** (`AppSpacing.spacing4` not `16.0`)
4. ✅ **Use typography styles** (`AppTypography.h1` not custom TextStyle)
5. ✅ **Build responsive** by default using breakpoint utilities
6. ✅ **Leverage the theme** - Material widgets inherit styles automatically
7. ✅ **Be consistent** - use the same patterns throughout the app

## Anti-Patterns to Avoid

1. ❌ Don't use magic numbers: `padding: EdgeInsets.all(16.0)`
2. ❌ Don't use hex colors directly: `color: Color(0xFFA855F7)`
3. ❌ Don't create custom TextStyles: `TextStyle(fontSize: 24, ...)`
4. ❌ Don't ignore responsive design
5. ❌ Don't mix design systems (e.g., using both Tailwind values and custom values)

## Migration Guide

To migrate existing widgets to the design system:

1. **Replace colors**: `Color(0xFF...)` → `AppColors.*`
2. **Replace padding/margins**: `EdgeInsets.all(16)` → `AppSpacing.all4`
3. **Replace TextStyles**: `TextStyle(...)` → `AppTypography.*`
4. **Replace border radius**: `BorderRadius.circular(8)` → `AppBorders.lg`
5. **Add shadows**: `boxShadow: AppShadows.md`
6. **Make responsive**: Wrap in responsive utilities

## Examples

See `/lib/core/design_system/examples.dart` for complete working examples of:
- Buttons
- Cards
- Input fields
- Typography showcase
- Color palette showcase
- Spacing examples
- Responsive layouts

## Support

For questions or issues with the design system:
1. Check `README.md` for detailed documentation
2. Check `QUICK_REFERENCE.md` for common patterns
3. Check `examples.dart` for working code examples
4. Review existing screen implementations for real-world usage

## Future Enhancements

Potential additions to the design system:
- Animation utilities (durations, curves)
- Icon size constants
- Z-index system
- Transition utilities
- More specialized components
- Storybook integration
- Theme customization utilities

---

**Version**: 1.0.0  
**Last Updated**: December 19, 2025  
**Maintainer**: Development Team

