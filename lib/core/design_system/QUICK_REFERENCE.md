# Design System Quick Reference

A cheat sheet for the most commonly used design system tokens.

## Colors

### Semantic Colors
```dart
AppColors.primary           // Purple 500
AppColors.secondary         // Indigo 500
AppColors.success          // Green 500
AppColors.warning          // Amber 500
AppColors.error            // Red 500
AppColors.info             // Sky 500

AppColors.textPrimary      // Gray 900
AppColors.textSecondary    // Gray 700
AppColors.textTertiary     // Gray 500

AppColors.border           // Gray 300
AppColors.background       // Beige #F5EFE0
AppColors.surface          // White
```

### Color Shades (50-950)
```dart
AppColors.purple50   // Lightest
AppColors.purple100
AppColors.purple200
AppColors.purple300
AppColors.purple400
AppColors.purple500  // Base
AppColors.purple600
AppColors.purple700
AppColors.purple800
AppColors.purple900
AppColors.purple950  // Darkest
```

## Typography

### Headings
```dart
AppTypography.h1  // 36px, bold
AppTypography.h2  // 30px, bold
AppTypography.h3  // 24px, semibold
AppTypography.h4  // 20px, semibold
AppTypography.h5  // 18px, semibold
AppTypography.h6  // 16px, semibold
```

### Body
```dart
AppTypography.bodyLarge   // 18px
AppTypography.bodyBase    // 16px
AppTypography.bodySmall   // 14px
AppTypography.bodyXSmall  // 12px
```

### Buttons & Labels
```dart
AppTypography.buttonBase  // 16px, semibold
AppTypography.labelBase   // 14px, medium
AppTypography.caption     // 12px, regular
```

## Spacing

### Scale (in pixels)
```dart
AppSpacing.spacing1   // 4px
AppSpacing.spacing2   // 8px
AppSpacing.spacing3   // 12px
AppSpacing.spacing4   // 16px
AppSpacing.spacing6   // 24px
AppSpacing.spacing8   // 32px
AppSpacing.spacing12  // 48px
AppSpacing.spacing16  // 64px
```

### Aliases
```dart
AppSpacing.xs   // 8px
AppSpacing.sm   // 12px
AppSpacing.md   // 16px
AppSpacing.lg   // 24px
AppSpacing.xl   // 32px
```

### EdgeInsets
```dart
AppSpacing.all4       // EdgeInsets.all(16)
AppSpacing.all6       // EdgeInsets.all(24)
AppSpacing.h4v2       // horizontal: 16, vertical: 8
AppSpacing.h6v3       // horizontal: 24, vertical: 12
```

### SizedBox
```dart
AppSpacing.h4   // Horizontal spacing (width: 16)
AppSpacing.v4   // Vertical spacing (height: 16)
```

## Borders

### Border Radius
```dart
AppBorders.sm      // 2px
AppBorders.base    // 4px
AppBorders.md      // 6px
AppBorders.lg      // 8px
AppBorders.xl      // 12px
AppBorders.xl2     // 16px
AppBorders.xl3     // 24px
AppBorders.full    // 9999px (circular)
```

### Border Width
```dart
AppBorders.widthThin  // 1px
AppBorders.width2     // 2px
AppBorders.width4     // 4px
```

### Quick Borders
```dart
AppBorders.all()                    // All sides
AppBorders.topBorder()              // Top only
AppBorders.bottomBorder()           // Bottom only
AppBorders.inputBorderDefault       // For text fields
AppBorders.inputBorderFocused       // Focused state
```

## Shadows

```dart
AppShadows.none   // No shadow
AppShadows.sm     // Subtle
AppShadows.base   // Default
AppShadows.md     // Medium (dropdowns)
AppShadows.lg     // Large (modals)
AppShadows.xl     // Extra large
AppShadows.xl2    // Maximum

// Colored shadows
AppShadows.primary
AppShadows.success
AppShadows.error
```

## Breakpoints

### Screen Checks
```dart
AppBreakpoints.isMobile(context)   // < 768px
AppBreakpoints.isTablet(context)   // 768px - 1024px
AppBreakpoints.isDesktop(context)  // >= 1024px
```

### Responsive Values
```dart
AppBreakpoints.value(
  context,
  xs: 8.0,
  sm: 12.0,
  md: 16.0,
  lg: 24.0,
)

AppBreakpoints.device(
  context,
  mobile: 1,
  tablet: 2,
  desktop: 3,
)
```

### Responsive Widgets
```dart
AppBreakpoints.responsive(
  context,
  mobile: MobileWidget(),
  desktop: DesktopWidget(),
)
```

## Common Patterns

### Button
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
  child: Text('Button', style: AppTypography.buttonBase),
)
```

### Card
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
    children: [
      Text('Title', style: AppTypography.h4),
      AppSpacing.v2,
      Text('Content', style: AppTypography.bodyBase),
    ],
  ),
)
```

### Input Field
```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Label',
    hintText: 'Placeholder',
    prefixIcon: Icon(Icons.email),
    border: AppBorders.inputBorderDefault,
    focusedBorder: AppBorders.inputBorderFocused,
  ),
  style: AppTypography.bodyBase,
)
```

### Alert/Banner
```dart
Container(
  padding: AppSpacing.all4,
  decoration: BoxDecoration(
    color: AppColors.error50,
    borderRadius: AppBorders.lg,
    border: AppBorders.all(color: AppColors.error200),
  ),
  child: Row(
    children: [
      Icon(Icons.error_outline, color: AppColors.error),
      AppSpacing.h3,
      Expanded(
        child: Text(
          'Error message',
          style: AppTypography.bodyBase.copyWith(
            color: AppColors.error700,
          ),
        ),
      ),
    ],
  ),
)
```

### Responsive Grid
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: AppBreakpoints.device(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    ),
    crossAxisSpacing: AppSpacing.spacing4,
    mainAxisSpacing: AppSpacing.spacing4,
  ),
  itemBuilder: (context, index) => YourWidget(),
)
```

### Status Badge
```dart
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
    'Active',
    style: AppTypography.labelSmall.copyWith(
      color: AppColors.success700,
    ),
  ),
)
```

## Pro Tips

1. **Import once**: `import 'package:kikocode/core/design_system/design_system.dart';`
2. **Use semantic colors**: Prefer `AppColors.primary` over `AppColors.purple500`
3. **Use spacing constants**: Never use magic numbers like `8.0` or `16.0`
4. **Consistent shadows**: Stick to predefined shadow levels
5. **Responsive by default**: Use breakpoint utilities for better UX
6. **Theme-aware**: Most widgets inherit from theme automatically
7. **Combine utilities**: Mix spacing, colors, borders, and shadows for rich UI

