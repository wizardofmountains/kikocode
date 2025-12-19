# Design System

A comprehensive Tailwind-inspired design system for Flutter, providing a complete set of design tokens and utilities for building consistent, beautiful UIs.

## Table of Contents

- [Installation](#installation)
- [Colors](#colors)
- [Typography](#typography)
- [Spacing](#spacing)
- [Borders](#borders)
- [Shadows](#shadows)
- [Breakpoints](#breakpoints)
- [Theme](#theme)

## Installation

Import the design system in your Flutter files:

```dart
import 'package:kikocode/core/design_system/design_system.dart';
```

## Colors

The design system includes a comprehensive color palette inspired by Tailwind CSS, with shades from 50 (lightest) to 950 (darkest).

### Color Families

- **Grayscale**: `slate`, `gray`, `zinc`
- **Primary**: `purple`, `violet`, `indigo`
- **Accent**: `blue`, `cyan`, `sky`, `teal`
- **Success**: `green`, `emerald`
- **Warning**: `yellow`, `amber`, `orange`
- **Error**: `red`, `rose`
- **Info**: `cyan`, `sky`
- **Special**: `pink`

### Usage

```dart
// Using color shades
Container(color: AppColors.purple500)
Container(color: AppColors.gray100)

// Using semantic colors
Container(color: AppColors.primary)
Container(color: AppColors.success)
Container(color: AppColors.error)

// Text colors
Text('Hello', style: TextStyle(color: AppColors.textPrimary))
Text('Secondary', style: TextStyle(color: AppColors.textSecondary))

// Border colors
border: Border.all(color: AppColors.border)

// With opacity
Container(color: AppColors.withOpacity(AppColors.primary, 0.5))
```

### Semantic Colors

- `primary` / `primaryLight` / `primaryDark` - Purple shades for primary actions
- `secondary` / `secondaryLight` / `secondaryDark` - Indigo shades for secondary actions
- `success` / `successLight` / `successDark` - Green for success states
- `warning` / `warningLight` / `warningDark` - Amber for warnings
- `error` / `errorLight` / `errorDark` - Red for errors
- `info` / `infoLight` / `infoDark` - Sky blue for information

### Text Colors

- `textPrimary` - Main text color
- `textSecondary` - Secondary text color
- `textTertiary` - Tertiary text color
- `textDisabled` - Disabled text color
- `textOnPrimary` - Text on primary color backgrounds
- `textOnSecondary` - Text on secondary color backgrounds

## Typography

Typography system with proper font hierarchy, weights, and sizes.

### Font Families

- **Primary Font**: Inter (body text)
- **Display Font**: Poppins (headings)
- **Mono Font**: JetBrains Mono (code)

### Text Styles

#### Display Styles (Hero Text)
```dart
Text('Hero', style: AppTypography.display9) // 128px
Text('Hero', style: AppTypography.display8) // 96px
Text('Hero', style: AppTypography.display7) // 72px
Text('Hero', style: AppTypography.display6) // 60px
Text('Hero', style: AppTypography.display5) // 48px
```

#### Headings
```dart
Text('Heading 1', style: AppTypography.h1) // 36px
Text('Heading 2', style: AppTypography.h2) // 30px
Text('Heading 3', style: AppTypography.h3) // 24px
Text('Heading 4', style: AppTypography.h4) // 20px
Text('Heading 5', style: AppTypography.h5) // 18px
Text('Heading 6', style: AppTypography.h6) // 16px
```

#### Body Text
```dart
Text('Large body', style: AppTypography.bodyLarge)   // 18px
Text('Body text', style: AppTypography.bodyBase)     // 16px
Text('Small text', style: AppTypography.bodySmall)   // 14px
Text('Extra small', style: AppTypography.bodyXSmall) // 12px
```

#### Labels
```dart
Text('Label', style: AppTypography.labelLarge) // 16px, medium weight
Text('Label', style: AppTypography.labelBase)  // 14px, medium weight
Text('Label', style: AppTypography.labelSmall) // 12px, medium weight
```

#### Buttons
```dart
ElevatedButton(
  child: Text('Button', style: AppTypography.buttonBase),
)
```

#### Special Styles
```dart
Text('Caption', style: AppTypography.caption)
Text('OVERLINE', style: AppTypography.overline)
Text('code', style: AppTypography.codeBase)
Text('Link', style: AppTypography.link)
```

### Helper Methods
```dart
// Apply color
AppTypography.withColor(AppTypography.h1, AppColors.primary)

// Apply weight
AppTypography.withWeight(AppTypography.bodyBase, AppTypography.bold)

// Apply styles
AppTypography.italic(AppTypography.bodyBase)
AppTypography.underline(AppTypography.bodyBase)
AppTypography.lineThrough(AppTypography.bodyBase)
```

## Spacing

Consistent spacing system based on a 4px scale (matching Tailwind's spacing).

### Spacing Scale

```dart
AppSpacing.spacing0   // 0px
AppSpacing.spacing1   // 4px
AppSpacing.spacing2   // 8px
AppSpacing.spacing3   // 12px
AppSpacing.spacing4   // 16px
AppSpacing.spacing5   // 20px
AppSpacing.spacing6   // 24px
AppSpacing.spacing8   // 32px
AppSpacing.spacing10  // 40px
AppSpacing.spacing12  // 48px
AppSpacing.spacing16  // 64px
AppSpacing.spacing20  // 80px
AppSpacing.spacing24  // 96px
// ... up to spacing96 (384px)
```

### Semantic Aliases
```dart
AppSpacing.xs    // 8px
AppSpacing.sm    // 12px
AppSpacing.md    // 16px
AppSpacing.lg    // 24px
AppSpacing.xl    // 32px
AppSpacing.xl2   // 40px
```

### EdgeInsets Helpers

```dart
// All sides
Padding(padding: AppSpacing.all4)  // EdgeInsets.all(16)
Padding(padding: AppSpacing.all6)  // EdgeInsets.all(24)

// Symmetric
Padding(padding: AppSpacing.h4v2)  // horizontal: 16, vertical: 8
Padding(padding: AppSpacing.h6v3)  // horizontal: 24, vertical: 12

// Horizontal/Vertical only
Padding(padding: AppSpacing.horizontalOnly(16))
Padding(padding: AppSpacing.verticalOnly(8))

// Specific sides
Padding(padding: AppSpacing.only(top: 16, left: 8))
Padding(padding: AppSpacing.topOnly(16))
```

### SizedBox Helpers

```dart
// Horizontal spacing
Row(children: [
  Text('A'),
  AppSpacing.h4,  // SizedBox(width: 16)
  Text('B'),
])

// Vertical spacing
Column(children: [
  Text('A'),
  AppSpacing.v4,  // SizedBox(height: 16)
  Text('B'),
])
```

## Borders

Border radius and border utilities.

### Border Radius

```dart
// Predefined radius values
AppBorders.radiusNone  // 0px
AppBorders.radiusSm    // 2px
AppBorders.radiusBase  // 4px
AppBorders.radiusMd    // 6px
AppBorders.radiusLg    // 8px
AppBorders.radiusXl    // 12px
AppBorders.radiusXl2   // 16px
AppBorders.radiusXl3   // 24px
AppBorders.radiusFull  // 9999px (circular)

// BorderRadius objects
Container(
  decoration: BoxDecoration(
    borderRadius: AppBorders.lg,    // BorderRadius.circular(8)
    borderRadius: AppBorders.xl2,   // BorderRadius.circular(16)
  ),
)

// Specific corners
Container(
  decoration: BoxDecoration(
    borderRadius: AppBorders.topLg,     // Top corners only
    borderRadius: AppBorders.bottomXl,  // Bottom corners only
  ),
)
```

### Border Widths

```dart
AppBorders.widthNone  // 0px
AppBorders.widthThin  // 1px
AppBorders.width2     // 2px
AppBorders.width4     // 4px
AppBorders.width8     // 8px
```

### Border Utilities

```dart
// All sides
Container(
  decoration: BoxDecoration(
    border: AppBorders.all(),
    border: AppBorders.all(color: AppColors.primary, width: 2),
  ),
)

// Specific sides
Container(
  decoration: BoxDecoration(
    border: AppBorders.topBorder(),
    border: AppBorders.bottomBorder(color: AppColors.border, width: 2),
  ),
)

// Input borders
TextField(
  decoration: InputDecoration(
    border: AppBorders.inputBorderDefault,
    focusedBorder: AppBorders.inputBorderFocused,
    errorBorder: AppBorders.inputBorderError,
  ),
)
```

### Dividers

```dart
AppBorders.dividerThin  // Horizontal divider, 1px
AppBorders.verticalDividerThin  // Vertical divider, 1px

AppBorders.divider(
  thickness: 2,
  color: AppColors.border,
  indent: 16,
  endIndent: 16,
)
```

## Shadows

Box shadow definitions from subtle to prominent.

### Shadow Levels

```dart
Container(
  decoration: BoxDecoration(
    boxShadow: AppShadows.none,  // No shadow
    boxShadow: AppShadows.sm,    // Subtle
    boxShadow: AppShadows.base,  // Default
    boxShadow: AppShadows.md,    // Medium (dropdowns)
    boxShadow: AppShadows.lg,    // Large (modals)
    boxShadow: AppShadows.xl,    // Extra large
    boxShadow: AppShadows.xl2,   // Maximum
  ),
)
```

### Colored Shadows

```dart
Container(
  decoration: BoxDecoration(
    boxShadow: AppShadows.primary,    // Purple shadow
    boxShadow: AppShadows.success,    // Green shadow
    boxShadow: AppShadows.error,      // Red shadow
  ),
)

// Custom colored shadow
Container(
  decoration: BoxDecoration(
    boxShadow: AppShadows.colored(
      color: AppColors.blue500,
      opacity: 0.3,
      blurRadius: 8,
    ),
  ),
)
```

### Elevation Helper

```dart
// Get shadow by elevation level (0-6)
Container(
  decoration: BoxDecoration(
    boxShadow: AppShadows.byElevation(3),
  ),
)
```

## Breakpoints

Responsive design utilities matching Tailwind's breakpoint system.

### Breakpoint Values

```dart
AppBreakpoints.xs    // 0px (phones)
AppBreakpoints.sm    // 640px (large phones)
AppBreakpoints.md    // 768px (tablets)
AppBreakpoints.lg    // 1024px (laptops)
AppBreakpoints.xl    // 1280px (desktops)
AppBreakpoints.xl2   // 1536px (large desktops)
```

### Responsive Checks

```dart
// Check screen size
if (AppBreakpoints.isMobile(context)) {
  // Mobile layout
}

if (AppBreakpoints.isTablet(context)) {
  // Tablet layout
}

if (AppBreakpoints.isDesktop(context)) {
  // Desktop layout
}
```

### Responsive Values

```dart
// Get different values based on breakpoint
final padding = AppBreakpoints.value(
  context,
  xs: 8.0,
  sm: 12.0,
  md: 16.0,
  lg: 24.0,
  xl: 32.0,
);

// Device-based values
final columns = AppBreakpoints.device(
  context,
  mobile: 1,
  tablet: 2,
  desktop: 3,
);
```

### Responsive Widgets

```dart
// Different widgets for different screen sizes
AppBreakpoints.responsive(
  context,
  mobile: MobileLayout(),
  tablet: TabletLayout(),
  desktop: DesktopLayout(),
)

// Builder pattern
AppBreakpoints.builder(
  context,
  builder: (context, breakpoint) {
    if (breakpoint.isDesktop) {
      return DesktopLayout();
    }
    return MobileLayout();
  },
)
```

## Theme

Complete Material 3 theme integration.

### Using the Theme

```dart
// In main.dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system, // or ThemeMode.light / ThemeMode.dark
  // ...
)
```

The theme automatically styles:
- AppBar
- Buttons (Elevated, Text, Outlined)
- Cards
- Input fields
- Dialogs
- Bottom sheets
- Chips
- Checkboxes, Radios, Switches
- Sliders
- Progress indicators
- Snackbars
- And more...

### Accessing Theme Values

```dart
// Get theme colors
final primaryColor = Theme.of(context).colorScheme.primary;

// Get text styles
final headlineStyle = Theme.of(context).textTheme.headlineMedium;

// Or use directly from design system
Text('Title', style: AppTypography.h3)
Container(color: AppColors.primary)
```

## Examples

### Button with Custom Styling

```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.white,
    padding: AppSpacing.symmetric(
      horizontal: AppSpacing.spacing6,
      vertical: AppSpacing.spacing3,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: AppBorders.lg,
    ),
  ),
  onPressed: () {},
  child: Text('Click Me', style: AppTypography.buttonBase),
)
```

### Card with Shadow

```dart
Container(
  padding: AppSpacing.all6,
  decoration: BoxDecoration(
    color: AppColors.surface,
    borderRadius: AppBorders.xl,
    boxShadow: AppShadows.md,
    border: Border.all(
      color: AppColors.borderLight,
      width: AppBorders.widthThin,
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Card Title', style: AppTypography.h4),
      AppSpacing.v2,
      Text('Card content...', style: AppTypography.bodyBase),
    ],
  ),
)
```

### Responsive Layout

```dart
AppBreakpoints.responsive(
  context,
  mobile: Column(
    children: [
      Image(...),
      AppSpacing.v4,
      Text(...),
    ],
  ),
  desktop: Row(
    children: [
      Expanded(child: Image(...)),
      AppSpacing.h8,
      Expanded(child: Text(...)),
    ],
  ),
)
```

### Input Field

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'Enter your email',
    prefixIcon: Icon(Icons.email),
    filled: true,
    fillColor: AppColors.surface,
    border: AppBorders.inputBorderDefault,
    focusedBorder: AppBorders.inputBorderFocused,
  ),
  style: AppTypography.bodyBase,
)
```

## Best Practices

1. **Use semantic colors** when possible (`AppColors.primary` instead of `AppColors.purple500`)
2. **Use spacing constants** instead of magic numbers
3. **Use typography styles** for consistent text appearance
4. **Leverage the theme** - most widgets will automatically use theme values
5. **Use responsive utilities** for different screen sizes
6. **Keep consistency** - stick to the design tokens throughout your app

## Contributing

When adding new design tokens:
1. Follow the existing naming conventions
2. Add documentation
3. Add examples
4. Update this README

