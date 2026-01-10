# Design Token Extraction from Figma

Guide for extracting and documenting design tokens from Figma designs for use in Flutter.

## What are Design Tokens?

Design tokens are the visual design atoms of the design system — specifically, they are named entities that store visual design attributes. They're used in place of hard-coded values to ensure consistency and maintainability.

## Token Categories

### 1. Color Tokens

#### Extracting Colors from Figma

1. **Open Figma Design**
2. **Enable Dev Mode** (top-right toggle)
3. **Select any element** with a color
4. **View color in Inspector:**
   - Fill color
   - Stroke color
   - Text color
   - Background color

#### Color Documentation Template

```dart
// Primary Colors
const Color primary50 = Color(0xFFF5F3FF);   // Lightest
const Color primary100 = Color(0xFFEDE9FE);
const Color primary200 = Color(0xFFDDD6FE);
const Color primary300 = Color(0xFFC4B5FD);
const Color primary400 = Color(0xFFA78BFA);
const Color primary500 = Color(0xFF8B5CF6);  // Base
const Color primary600 = Color(0xFF7C3AED);
const Color primary700 = Color(0xFF6D28D9);
const Color primary800 = Color(0xFF5B21B6);
const Color primary900 = Color(0xFF4C1D95);
const Color primary950 = Color(0xFF2E1065);  // Darkest

// Semantic Colors
const Color success = Color(0xFF10B981);
const Color warning = Color(0xFFF59E0B);
const Color error = Color(0xFFEF4444);
const Color info = Color(0xFF3B82F6);

// Text Colors
const Color textPrimary = Color(0xFF1F2937);
const Color textSecondary = Color(0xFF6B7280);
const Color textTertiary = Color(0xFF9CA3AF);

// Background Colors
const Color background = Color(0xFFFFFFFF);
const Color backgroundSecondary = Color(0xFFF9FAFB);
const Color surface = Color(0xFFFFFFFF);

// Border Colors
const Color border = Color(0xFFE5E7EB);
const Color borderLight = Color(0xFFF3F4F6);
```

#### Color Naming Convention

Use descriptive, semantic names:

```dart
// ✅ GOOD: Semantic names
AppColors.primary
AppColors.success
AppColors.textPrimary
AppColors.border

// ❌ BAD: Non-descriptive names
AppColors.purple
AppColors.green
AppColors.gray1
AppColors.gray2
```

### 2. Typography Tokens

#### Extracting Typography from Figma

1. **Select text layer**
2. **View in Inspector:**
   - Font family
   - Font weight
   - Font size
   - Line height
   - Letter spacing

#### Typography Documentation Template

```dart
// Display Styles (Hero text)
static final TextStyle display1 = TextStyle(
  fontFamily: 'Inter',
  fontSize: 72,      // 72px
  fontWeight: FontWeight.w700,  // Bold
  height: 1.2,       // 120% line height
  letterSpacing: -0.02,  // -2%
);

// Heading Styles
static final TextStyle h1 = TextStyle(
  fontFamily: 'Inter',
  fontSize: 36,
  fontWeight: FontWeight.w700,
  height: 1.2,
  letterSpacing: -0.01,
);

static final TextStyle h2 = TextStyle(
  fontFamily: 'Inter',
  fontSize: 30,
  fontWeight: FontWeight.w700,
  height: 1.3,
);

static final TextStyle h3 = TextStyle(
  fontFamily: 'Inter',
  fontSize: 24,
  fontWeight: FontWeight.w600,
  height: 1.3,
);

// Body Styles
static final TextStyle bodyLarge = TextStyle(
  fontFamily: 'Inter',
  fontSize: 18,
  fontWeight: FontWeight.w400,
  height: 1.5,
);

static final TextStyle bodyBase = TextStyle(
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w400,
  height: 1.5,
);

static final TextStyle bodySmall = TextStyle(
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.w400,
  height: 1.5,
);

// Label Styles
static final TextStyle labelBase = TextStyle(
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.w500,
  height: 1.4,
);

static final TextStyle caption = TextStyle(
  fontFamily: 'Inter',
  fontSize: 12,
  fontWeight: FontWeight.w400,
  height: 1.4,
);
```

#### Font Weight Reference

| Figma Weight | Flutter Weight | Value |
|--------------|----------------|-------|
| Thin | FontWeight.w100 | 100 |
| Extra Light | FontWeight.w200 | 200 |
| Light | FontWeight.w300 | 300 |
| Regular | FontWeight.w400 | 400 |
| Medium | FontWeight.w500 | 500 |
| Semi Bold | FontWeight.w600 | 600 |
| Bold | FontWeight.w700 | 700 |
| Extra Bold | FontWeight.w800 | 800 |
| Black | FontWeight.w900 | 900 |

### 3. Spacing Tokens

#### Extracting Spacing from Figma

1. **Select element**
2. **View padding/margin** in Inspector
3. **Measure distances** between elements
4. **Identify patterns** (4px, 8px, 16px, etc.)

#### Spacing Documentation Template

```dart
class AppSpacing {
  // Base spacing scale (4px increments)
  static const double spacing0 = 0;
  static const double spacing1 = 4;
  static const double spacing2 = 8;
  static const double spacing3 = 12;
  static const double spacing4 = 16;
  static const double spacing5 = 20;
  static const double spacing6 = 24;
  static const double spacing8 = 32;
  static const double spacing10 = 40;
  static const double spacing12 = 48;
  static const double spacing16 = 64;
  static const double spacing20 = 80;
  static const double spacing24 = 96;
  
  // Semantic aliases
  static const double xs = spacing1;   // 4px
  static const double sm = spacing2;   // 8px
  static const double md = spacing4;   // 16px
  static const double lg = spacing6;   // 24px
  static const double xl = spacing8;   // 32px
  static const double xxl = spacing12; // 48px
}
```

### 4. Border Radius Tokens

#### Extracting Border Radius from Figma

1. **Select element with rounded corners**
2. **View border radius** in Inspector
3. **Document all unique values**

#### Border Radius Documentation Template

```dart
class AppBorders {
  // Border radius values
  static final BorderRadius none = BorderRadius.circular(0);
  static final BorderRadius sm = BorderRadius.circular(4);
  static final BorderRadius base = BorderRadius.circular(8);
  static final BorderRadius md = BorderRadius.circular(12);
  static final BorderRadius lg = BorderRadius.circular(16);
  static final BorderRadius xl = BorderRadius.circular(20);
  static final BorderRadius xl2 = BorderRadius.circular(24);
  static final BorderRadius xl3 = BorderRadius.circular(32);
  static final BorderRadius full = BorderRadius.circular(9999);
}
```

### 5. Shadow/Elevation Tokens

#### Extracting Shadows from Figma

1. **Select element with shadow**
2. **View Effects** in Inspector
3. **Note:** X, Y, Blur, Spread, Color

#### Shadow Documentation Template

```dart
class AppShadows {
  // Shadow definitions
  static final List<BoxShadow> none = [];
  
  static final List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0D000000),  // 5% black
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];
  
  static final List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x14000000),  // 8% black
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x1A000000),  // 10% black
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];
  
  static final List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
    ),
  ];
}
```

## Figma Dev Mode Tips

### Measurements

1. **Select element** to see dimensions
2. **Hold Option/Alt** to see spacing to other elements
3. **Use ruler tool** for precise measurements

### Colors

1. **Click any fill** to copy hex code
2. **View opacity** in effects panel
3. **Check color styles** for reusable colors

### Typography

1. **Line height:** Often shown as percentage (150% = 1.5)
2. **Letter spacing:** Convert from pixels or percentage
3. **Font weight:** Match to Flutter constants

### Effects

1. **Multiple shadows:** Document all layers
2. **Blur:** Converts to blurRadius
3. **Spread:** Use spreadRadius parameter

## Creating Design Token Files

### Step 1: Analyze Figma Design

Go through entire design and identify:
- All unique colors used
- All text styles
- All spacing values
- All border radius values
- All shadow effects

### Step 2: Group and Name

Create semantic groups:
- Primary, secondary, accent colors
- Heading, body, label text styles
- Small, medium, large spacing
- Success, warning, error states

### Step 3: Create Constants

Add to design system:

```dart
// lib/core/design_system/colors.dart
class AppColors {
  // Document all colors
}

// lib/core/design_system/typography.dart
class AppTypography {
  // Document all text styles
}

// lib/core/design_system/spacing.dart
class AppSpacing {
  // Document all spacing values
}
```

### Step 4: Document Usage

Add examples and documentation:

```dart
/// Primary brand color
/// 
/// Used for:
/// - Primary buttons
/// - Links
/// - Active navigation items
/// - Key call-to-action elements
/// 
/// Example:
/// ```dart
/// Container(
///   color: AppColors.primary,
///   child: Text('Click me'),
/// )
/// ```
static const Color primary = Color(0xFF8B5CF6);
```

## Token Extraction Checklist

- [ ] All colors extracted and documented
- [ ] Color shades/variants included
- [ ] Typography styles extracted
- [ ] Font weights mapped correctly
- [ ] Line heights converted (% to multiplier)
- [ ] Spacing scale identified
- [ ] Common spacing values documented
- [ ] Border radius values extracted
- [ ] Shadow effects documented
- [ ] All tokens added to design system files
- [ ] Usage examples provided
- [ ] Semantic names used

## Tools

**Figma Plugins:**
- **Design Tokens** - Export tokens as JSON
- **Figma Tokens** - Sync tokens with code
- **Style Dictionary** - Generate code from tokens

**Conversion Tools:**
- Figma pixel values → Flutter logical pixels (1:1 ratio)
- Figma % line height → Flutter height multiplier (150% = 1.5)
- Figma letter spacing → Flutter letterSpacing value

## Best Practices

1. **Use Dev Mode:** Always use Figma Dev Mode for accurate values
2. **Document Everything:** Include comments explaining token usage
3. **Semantic Names:** Use descriptive names, not visual attributes
4. **Consistency:** Maintain consistent naming across all tokens
5. **Version Control:** Track token changes in version control
6. **Collaborate:** Work with designers to verify accuracy

## Example Token File

Complete example of a token file:

```dart
/// Design tokens extracted from Figma
/// Last updated: 2026-01-10
/// Design file: https://figma.com/file/...

import 'package:flutter/material.dart';

class DesignTokens {
  // Colors
  static const Color primary = Color(0xFF8B5CF6);
  static const Color secondary = Color(0xFF3B82F6);
  
  // Typography
  static const TextStyle h1 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );
  
  // Spacing
  static const double spacingSm = 8;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  
  // Borders
  static final BorderRadius radiusSm = BorderRadius.circular(4);
  static final BorderRadius radiusMd = BorderRadius.circular(8);
  
  // Shadows
  static final List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 4),
      blurRadius: 6,
    ),
  ];
}
```

---

**Last Updated:** January 2026  
**Version:** 1.0.0
