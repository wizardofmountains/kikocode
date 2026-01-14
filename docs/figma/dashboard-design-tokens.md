# Dashboard Design Tokens - Extracted from Figma

**Figma File:** https://www.figma.com/design/5knW5qXCf3yqyA6j6elzeJ/Andi-David?node-id=560-2757&m=dev  
**Extraction Date:** 2026-01-XX  
**Screen:** Dashboard (Main Screen)

## Overview

This document contains all design tokens extracted from the Figma design for the dashboard screen. These tokens should be used to ensure pixel-perfect implementation matching the design.

## Colors

### Background Colors

```dart
// Main background
Background: #F5EFE0 → AppColors.backgroundLight

// Card/Surface backgrounds
Card Background: #FFFFFF → AppColors.surface
Group Item Background: #FBF8F2 → AppColors.surfaceHigh
```

### Text Colors

```dart
// Primary text
Text Primary: #242424 → AppColors.textPrimary

// Secondary text (if different)
Text Secondary: #6B7280 → AppColors.textSecondary
```

### Accent Colors

```dart
// Purple accents (from existing design)
Profile Avatar Background: #E9D5FF → AppColors.primary200
Profile Avatar Text: #9333EA → AppColors.primary600
Bottom Nav Background: #E9D5FF → AppColors.primary200
Active Nav Item: #B794F6 → AppColors.primary400

// Group colors (custom)
Group Teal: #7DD3C0
Group Pink: #FF9999
Group Blue: #92C6E8
```

## Typography

### Headings

```dart
// Section Titles (e.g., "Aktuell", "Gruppen")
Font: Inter (or Nunito Sans from design system)
Size: 18px
Weight: 600 (Semi Bold)
Line Height: 1.5
→ AppTypography.h5

// Greeting Text
Font: Inter
Size: 16px
Weight: 500 (Medium)
Line Height: 1.5
→ AppTypography.bodyBase.copyWith(fontWeight: AppTypography.medium)
```

### Body Text

```dart
// Event items, group names
Font: Inter
Size: 14px
Weight: 400 (Regular)
Line Height: 1.5
→ AppTypography.bodySmall

// Action card text
Font: Inter
Size: 14px
Weight: 600 (Semi Bold)
Line Height: 1.5
→ AppTypography.bodySmall.copyWith(fontWeight: AppTypography.semiBold)
```

## Spacing

### Screen Padding

```dart
Screen Padding: 20px → AppSpacing.spacing5
```

### Section Spacing

```dart
Between Sections: 20px → AppSpacing.v5
Between Group Items: 12px → AppSpacing.v3
Between Event Items: 8px → AppSpacing.v2
```

### Card Padding

```dart
Card Padding: 20px → AppSpacing.all5
Group Item Padding: 16px horizontal, 12px vertical → AppSpacing.h4v3
Action Card Padding: 16px → AppSpacing.all4
```

### Internal Spacing

```dart
Logo to Profile: Auto (spaceBetween)
Header to Greeting: 20px → AppSpacing.v5
Title to Content: 12px → AppSpacing.v3
Icon to Text: 12px → AppSpacing.h3
Action Cards Gap: 16px → AppSpacing.h4
Bottom Nav Spacing: 80px → AppSpacing.v20
```

## Border Radius

```dart
Cards: 16px → AppBorders.xl2
Group Items: 12px → AppBorders.xl
Action Cards: 12px → AppBorders.xl
Emoji Container: 8px → AppBorders.lg
Nav Item Active: 12px → AppBorders.xl
```

## Shadows

```dart
// Card shadows
Shadow: 
  Color: rgba(0, 0, 0, 0.05)
  Offset: (0, 2)
  Blur: 10
  Spread: 0
→ AppShadows.md

// Bottom nav shadow
Shadow:
  Color: rgba(0, 0, 0, 0.1)
  Offset: (0, -2)
  Blur: 10
  Spread: 0
→ AppShadows.lg
```

## Layout

### Dimensions

```dart
// Header
Logo Width: 120px
Logo Height: 60px
Profile Avatar Radius: 25px

// Cards
Action Card Height: 80px
Emoji Container: 40x40px
Nav Item: 56x56px
Bottom Nav Height: 70px

// Icons
Nav Icon Size: 28px
Group Action Icons: 18px
Event Bullet: 6x6px
```

### Grid/Layout

```dart
// Action Cards
Layout: Row with 2 equal columns
Gap: 16px
→ Row(children: [Expanded(...), AppSpacing.h4, Expanded(...)])
```

## Components

### News Card

- **Container**: White background, 16px radius, medium shadow
- **Title**: "Aktuell" - h5 style
- **Items**: Bullet list with 6px circles, 14px text
- **Spacing**: 12px between title and items, 8px between items

### Groups Section

- **Container**: White background, 16px radius, medium shadow
- **Title**: "Gruppen" - h5 style
- **Items**: 
  - Background: #FBF8F2
  - Emoji container: 40x40px white with 8px radius
  - Group name: 16px medium weight
  - Action buttons: Colored background with 30% opacity, 8px radius
- **Spacing**: 16px between title and items, 12px between items

### Action Cards

- **Container**: White background, 12px radius, medium shadow
- **Height**: 80px fixed
- **Text**: 14px semi-bold, centered
- **Layout**: 2 columns with 16px gap

### Bottom Navigation

- **Background**: #E9D5FF (primary200)
- **Height**: 70px
- **Items**: 56x56px
- **Active**: #B794F6 background, white icon
- **Inactive**: Transparent background, #9333EA icon
- **Shadow**: Large shadow on top

## Implementation Notes

1. **Font Family**: Currently using Inter, but design system uses Nunito Sans. Consider updating if design specifies Inter.

2. **Color Mapping**: Some colors (like group colors) are custom and may need to be added to design system if used elsewhere.

3. **Spacing**: All spacing values should use AppSpacing tokens for consistency.

4. **Shadows**: Current implementation uses custom shadows - should use AppShadows tokens.

5. **Border Radius**: All radius values should use AppBorders tokens.

## Next Steps

- [ ] Verify all colors match Figma exactly
- [ ] Confirm typography matches design system or add custom styles
- [ ] Test responsive behavior
- [ ] Verify accessibility (contrast ratios, touch targets)
- [ ] Update design system if new tokens are needed
