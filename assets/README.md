# Assets Directory

This directory contains all static assets used in the KIKO Flutter application, organized by type and purpose.

## Directory Structure

```
assets/
├── images/              # Raster images (PNG, JPG, WebP)
│   ├── logos/          # Brand logos in multiple resolutions
│   ├── icons/          # Custom raster icons
│   ├── illustrations/  # Illustrations and graphics
│   ├── backgrounds/    # Background images
│   └── avatars/        # User avatars and placeholders
├── vectors/            # Vector files (SVG)
│   ├── icons/         # SVG icons from Figma
│   ├── logos/         # Vector logos
│   └── illustrations/ # Vector illustrations
├── fonts/             # Custom fonts
│   └── [font-family]/ # Organized by font family
└── animations/        # Animation files (Lottie, Rive)
```

## Naming Conventions

### General Rules
- Use **lowercase** with **underscores** (snake_case)
- Be descriptive but concise
- Include size/variant in the name when applicable
- Use consistent prefixes for related assets

### Examples

**Good:**
- `logo_primary_light.svg`
- `icon_settings_24.png`
- `illustration_onboarding_welcome.svg`
- `bg_gradient_purple.png`
- `avatar_placeholder_round.png`

**Bad:**
- `Logo1.svg` (not descriptive)
- `settings-icon.png` (use underscores, not dashes)
- `img.png` (too generic)
- `background.PNG` (use lowercase extensions)

## Image Export Guidelines

### Raster Images (PNG, JPG)

Export in **three resolutions** for different pixel densities:

- **1x** - Base resolution (e.g., `icon_home.png`)
- **2x** - 2x resolution (e.g., `icon_home@2x.png`)
- **3x** - 3x resolution (e.g., `icon_home@3x.png`)

**Note:** Flutter automatically selects the appropriate resolution based on device pixel ratio.

#### Resolution Examples
| Asset Type | 1x Size | 2x Size | 3x Size |
|-----------|---------|---------|---------|
| Small Icon | 24×24 | 48×48 | 72×72 |
| Medium Icon | 48×48 | 96×96 | 144×144 |
| Large Icon | 64×64 | 128×128 | 192×192 |
| Button Image | 120×40 | 240×80 | 360×120 |

### Vector Images (SVG)

SVGs are resolution-independent and only need **one file**.

**Best Practices:**
- Optimize SVGs before export (remove unnecessary metadata)
- Use `flutter_svg` package for rendering
- Prefer SVG for icons and simple graphics
- Keep file sizes small (<50KB when possible)

**Export Settings:**
- Outline strokes (convert to paths)
- Flatten layers when possible
- Remove hidden layers
- Minify/compress the SVG

### Fonts

**Organization:**
```
fonts/
├── Roboto/
│   ├── Roboto-Regular.ttf
│   ├── Roboto-Bold.ttf
│   ├── Roboto-Italic.ttf
│   └── Roboto-BoldItalic.ttf
└── CustomFont/
    └── CustomFont-Regular.ttf
```

**Supported Formats:**
- `.ttf` (TrueType Font) - Recommended
- `.otf` (OpenType Font) - Also supported

**Registration:**
Fonts must be registered in `pubspec.yaml`:
```yaml
flutter:
  fonts:
    - family: Roboto
      fonts:
        - asset: assets/fonts/Roboto/Roboto-Regular.ttf
        - asset: assets/fonts/Roboto/Roboto-Bold.ttf
          weight: 700
```

### Animations

**Lottie Files (.json):**
- Export from After Effects or Figma via Lottie plugin
- Keep file size under 200KB when possible
- Test on actual devices for performance

**Rive Files (.riv):**
- Export from Rive editor
- Preferred for interactive animations
- Better performance than Lottie for complex animations

## Figma Export Workflow

### Step 1: Prepare Assets in Figma

1. **Name layers properly** - Layer names become file names
2. **Mark for export** - Select layer → Export settings
3. **Set export format** - PNG for raster, SVG for vectors
4. **Configure resolution** - 1x, 2x, 3x for raster images

### Step 2: Export from Figma

**For Icons/Images:**
1. Select the asset layer
2. Click "Export" in the right panel
3. Add export settings: PNG @1x, @2x, @3x or SVG
4. Click "Export [name]"

**Bulk Export:**
1. Select multiple layers
2. Right-click → "Export selected"
3. Choose destination folder

### Step 3: Organize in Project

1. Place files in appropriate directory
2. Follow naming conventions
3. Add reference in `lib/core/constants/asset_paths.dart`
4. Update `pubspec.yaml` if needed

## File Size Guidelines

### Target Sizes
- **Icons:** <10KB per file
- **Illustrations:** <100KB per file
- **Backgrounds:** <200KB per file
- **Animations:** <200KB per file

### Optimization Tools
- **PNG:** TinyPNG, ImageOptim
- **SVG:** SVGO, SVGOMG
- **JPG:** JPEGmini, ImageOptim

## Color & Format Guidelines

### When to Use PNG
- Images with transparency
- Icons and UI elements
- Sharp graphics with text

### When to Use JPG
- Photographs
- Complex images without transparency
- Larger background images

### When to Use WebP
- Modern alternative to PNG/JPG
- Better compression with quality
- Not universally supported yet

### When to Use SVG
- Icons and simple graphics
- Logos and brand marks
- Scalable UI elements
- Illustrations with solid colors

## Accessibility

### Alt Text & Semantics
When using images, always provide semantic labels:

```dart
Image.asset(
  AssetPaths.iconHome,
  semanticLabel: 'Home icon',
)
```

### Color Contrast
- Ensure sufficient contrast for icon overlays
- Test with grayscale to verify visibility
- Follow WCAG 2.1 guidelines (4.5:1 for normal text)

## Usage in Code

### Raster Images
```dart
import 'package:kikocode/core/constants/asset_paths.dart';

Image.asset(
  AssetPaths.logoLight,
  width: 120,
  height: 40,
)
```

### SVG Images
```dart
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kikocode/core/constants/asset_paths.dart';

SvgPicture.asset(
  AssetPaths.iconSettings,
  width: 24,
  height: 24,
  colorFilter: ColorFilter.mode(
    Colors.blue,
    BlendMode.srcIn,
  ),
)
```

### Fonts
```dart
import 'package:kikocode/core/design_system/design_system.dart';

Text(
  'Hello World',
  style: AppTypography.h1, // Uses design system
)
```

### Animations
```dart
import 'package:lottie/lottie.dart';
import 'package:kikocode/core/constants/asset_paths.dart';

Lottie.asset(
  AssetPaths.animationLoading,
  width: 200,
  height: 200,
)
```

## Checklist for Adding New Assets

- [ ] Asset is properly named (snake_case, descriptive)
- [ ] Image is optimized for file size
- [ ] Multiple resolutions exported (1x, 2x, 3x) if raster
- [ ] SVG is optimized and paths are outlined
- [ ] File is placed in correct directory
- [ ] Constant added to `asset_paths.dart`
- [ ] Asset path added to `pubspec.yaml` if needed
- [ ] Semantic label added in code
- [ ] Tested on multiple screen sizes/densities

## Common Issues & Solutions

### Issue: Image not found
**Solution:** Ensure path is registered in `pubspec.yaml` and app is restarted (hot reload insufficient for asset changes)

### Issue: Blurry images on high-DPI screens
**Solution:** Export and include @2x and @3x versions

### Issue: Large APK size
**Solution:** 
- Optimize images before adding
- Use vector formats when possible
- Consider lazy loading for large assets
- Use WebP format for photos

### Issue: SVG not rendering correctly
**Solution:**
- Ensure text is outlined (converted to paths)
- Remove filters/effects not supported by `flutter_svg`
- Simplify complex paths

## References

- [Flutter Asset Documentation](https://docs.flutter.dev/development/ui/assets-and-images)
- [flutter_svg Package](https://pub.dev/packages/flutter_svg)
- [Lottie for Flutter](https://pub.dev/packages/lottie)
- [Image Optimization Best Practices](https://web.dev/fast/#optimize-your-images)

---

**Last Updated:** January 2026  
**Maintained by:** Development Team
