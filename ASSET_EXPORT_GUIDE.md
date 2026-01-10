# Asset Export Guide for Figma to Flutter

Complete guide for exporting and preparing assets from Figma for use in Flutter applications.

## Table of Contents

1. [Image Assets](#image-assets)
2. [Vector Assets (SVG)](#vector-assets-svg)
3. [Fonts](#fonts)
4. [Animations](#animations)
5. [Icons](#icons)
6. [Optimization](#optimization)

## Image Assets

### Export Settings

**For raster images (photos, complex graphics):**

1. Select the layer/frame in Figma
2. In the right panel, scroll to "Export"
3. Click "+" to add export settings
4. Configure as follows:

```
Format: PNG or JPG
Size: 1x, 2x, 3x (export all three)
```

### Naming Convention

Use descriptive, lowercase names with underscores:

```bash
# Good
user_avatar_placeholder.png
background_gradient_purple.png
logo_primary_light.png

# Bad
Image1.png
bg.PNG
avatar.png
```

### Resolution Guide

| Device | Multiplier | Example |
|--------|------------|---------|
| Standard | 1x | 100×100px |
| iPhone Retina | 2x | 200×200px |
| iPhone Plus/Pro | 3x | 300×300px |

### File Formats

**PNG:**
- Use for: Images with transparency, UI elements, icons
- Supports: Transparency, lossless compression
- Best for: Graphics, logos, buttons

**JPG:**
- Use for: Photographs, complex images without transparency
- Supports: Lossy compression
- Best for: Background images, photos
- Quality: 80-90% recommended

**WebP:**
- Use for: Modern apps (requires plugin)
- Supports: Transparency, better compression than PNG/JPG
- Best for: All use cases on modern devices

### Figma Export Steps

1. **Select Asset:**
   - Click on the layer you want to export
   - Or select the frame containing multiple assets

2. **Add Export Settings:**
   ```
   Click "+" in Export section
   Choose PNG or JPG
   Add suffix: @2x, @3x
   ```

3. **Batch Export:**
   - Select multiple layers
   - Right-click → "Export as..."
   - Or use Export shortcut: Cmd/Ctrl + Shift + E

4. **Organize:**
   ```
   Place in project:
   assets/images/[category]/
   
   Example:
   assets/images/logos/logo_light.png
   assets/images/logos/logo_light@2x.png
   assets/images/logos/logo_light@3x.png
   ```

## Vector Assets (SVG)

### When to Use SVG

Use SVG for:
- Icons and simple graphics
- Logos
- Illustrations with solid colors
- Any asset that needs to scale infinitely

### Export Steps

1. **Select Layer:**
   - Click on the vector layer/frame

2. **Prepare for Export:**
   - Flatten layers if needed
   - Outline strokes (convert to fills)
   - Remove hidden layers
   - Simplify paths if possible

3. **Export Settings:**
   ```
   Format: SVG
   Size: 1x (SVG is resolution-independent)
   Include: ID attribute
   Outline: Outline text
   ```

4. **Export:**
   - Click "Export [name]"
   - Save to appropriate directory

### SVG Optimization

Before using SVG files, optimize them:

**Manual Review:**
- Remove `<title>` and `<desc>` tags if not needed
- Remove `id` attributes if not used
- Remove comments
- Simplify paths

**Automated Tools:**
- [SVGOMG](https://jakearchibald.github.io/svgomg/) (web-based)
- [SVGO](https://github.com/svg/svgo) (CLI tool)

**Example optimization:**

```xml
<!-- Before (from Figma) -->
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <title>Icon</title>
  <desc>A simple icon</desc>
  <g id="layer1" opacity="1">
    <path id="path1" d="M12 2L2 7v10l10 5 10-5V7z" fill="#000000"/>
  </g>
</svg>

<!-- After (optimized) -->
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M12 2L2 7v10l10 5 10-5V7z" fill="#000"/>
</svg>
```

### Using SVG in Flutter

```dart
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kikocode/core/constants/asset_paths.dart';

// Basic usage
SvgPicture.asset(
  AssetPaths.iconHome,
  width: 24,
  height: 24,
)

// With color
SvgPicture.asset(
  AssetPaths.iconSettings,
  width: 24,
  height: 24,
  colorFilter: ColorFilter.mode(
    AppColors.primary,
    BlendMode.srcIn,
  ),
)

// Or use AppIcon wrapper
AppIcon.svg(
  assetPath: AssetPaths.iconHome,
  size: AppIconSize.medium,
  color: AppColors.primary,
)
```

## Fonts

### Finding Font Files

1. **Google Fonts:**
   - Already integrated via `google_fonts` package
   - No need to export files
   - Use in code: `GoogleFonts.inter()`

2. **Custom Fonts:**
   - Ask designer for font files
   - Obtain: .ttf (TrueType) or .otf (OpenType)
   - Verify licensing rights

### Adding Custom Fonts to Flutter

1. **Create Directory:**
   ```bash
   assets/fonts/[FontFamily]/
   ```

2. **Add Font Files:**
   ```bash
   assets/fonts/Roboto/
   ├── Roboto-Regular.ttf
   ├── Roboto-Medium.ttf
   ├── Roboto-Bold.ttf
   └── Roboto-Italic.ttf
   ```

3. **Register in pubspec.yaml:**
   ```yaml
   flutter:
     fonts:
       - family: Roboto
         fonts:
           - asset: assets/fonts/Roboto/Roboto-Regular.ttf
           - asset: assets/fonts/Roboto/Roboto-Medium.ttf
             weight: 500
           - asset: assets/fonts/Roboto/Roboto-Bold.ttf
             weight: 700
           - asset: assets/fonts/Roboto/Roboto-Italic.ttf
             style: italic
   ```

4. **Use in Code:**
   ```dart
   Text(
     'Hello World',
     style: TextStyle(
       fontFamily: 'Roboto',
       fontWeight: FontWeight.w700,
       fontSize: 24,
     ),
   )
   ```

### Font Weights Reference

| Weight | Value | Common Name |
|--------|-------|-------------|
| Thin | 100 | Thin |
| Extra Light | 200 | Extra Light |
| Light | 300 | Light |
| Regular | 400 | Regular/Normal |
| Medium | 500 | Medium |
| Semi Bold | 600 | Semi Bold |
| Bold | 700 | Bold |
| Extra Bold | 800 | Extra Bold |
| Black | 900 | Black/Heavy |

## Animations

### Lottie Animations

**Export from After Effects:**

1. Install Lottie plugin for After Effects
2. File → Scripts → Bodymovin
3. Select composition
4. Choose output path
5. Click "Render"

**Export from Figma (with plugin):**

1. Install "LottieFiles" plugin
2. Select animation frame
3. Plugins → LottieFiles → Export
4. Download .json file

**Optimization:**

- Keep file size under 200KB
- Simplify paths and shapes
- Reduce keyframes
- Use [LottieFiles Optimizer](https://lottiefiles.com/)

**Usage in Flutter:**

```dart
import 'package:lottie/lottie.dart';
import 'package:kikocode/core/constants/asset_paths.dart';

Lottie.asset(
  AssetPaths.animationLoading,
  width: 200,
  height: 200,
  fit: BoxFit.contain,
)
```

### Rive Animations

**Export from Rive:**

1. Design animation in Rive editor
2. File → Export → Runtime
3. Save as .riv file

**Usage in Flutter:**

```dart
import 'package:rive/rive.dart';

RiveAnimation.asset(
  'assets/animations/character.riv',
  fit: BoxFit.contain,
)
```

## Icons

### Icon Systems

**Option 1: Use Material Icons (Recommended)**

```dart
Icon(Icons.home)
Icon(Icons.settings)
Icon(Icons.favorite)
```

**Option 2: Custom SVG Icons**

Export as SVG following the [Vector Assets](#vector-assets-svg) section.

**Option 3: Icon Fonts**

1. Export icons as font file (.ttf)
2. Add to assets/fonts/
3. Register in pubspec.yaml
4. Use with IconData

### Icon Sizes

Standard sizes for consistency:

| Size | Pixels | Use Case |
|------|--------|----------|
| XS | 16px | Inline with text |
| SM | 20px | Small buttons |
| MD | 24px | Default size |
| LG | 32px | Prominent actions |
| XL | 48px | Feature highlights |

### Using Icons

```dart
// Material Icon
Icon(
  Icons.home,
  size: 24,
  color: AppColors.primary,
)

// Custom SVG Icon
AppIcon.svg(
  assetPath: AssetPaths.iconCustom,
  size: AppIconSize.medium,
  color: AppColors.primary,
)
```

## Optimization

### Image Optimization Tools

**Online Tools:**
- [TinyPNG](https://tinypng.com/) - PNG/JPG compression
- [Squoosh](https://squoosh.app/) - Modern image compression
- [SVGOMG](https://jakearchibald.github.io/svgomg/) - SVG optimization

**CLI Tools:**
- ImageOptim (Mac)
- Pngquant (PNG compression)
- SVGO (SVG optimization)

### Size Guidelines

Target file sizes:

| Asset Type | Target Size |
|-----------|-------------|
| Icon (PNG) | < 10KB |
| Icon (SVG) | < 5KB |
| Illustration | < 100KB |
| Background | < 200KB |
| Photo | < 300KB |
| Animation | < 200KB |

### Optimization Checklist

- [ ] Remove unnecessary metadata
- [ ] Compress images (80-90% quality for JPG)
- [ ] Optimize SVG paths
- [ ] Remove unused assets
- [ ] Use appropriate format (PNG vs JPG vs SVG)
- [ ] Verify all resolutions exported
- [ ] Test on actual devices
- [ ] Check bundle size impact

## Flutter Asset Registration

After exporting assets, register them in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
    - assets/images/logos/
    - assets/images/icons/
    - assets/vectors/
    - assets/vectors/icons/
    - assets/animations/
```

And create type-safe constants in `lib/core/constants/asset_paths.dart`:

```dart
class AssetPaths {
  static const String logoLight = 'assets/images/logos/logo_light.png';
  static const String iconHome = 'assets/vectors/icons/icon_home.svg';
  static const String animationLoading = 'assets/animations/loading.json';
}
```

## Common Issues

### Issue: Image not found

**Solution:**
- Verify path in pubspec.yaml
- Restart app (hot reload insufficient for asset changes)
- Check file exists in correct location

### Issue: Blurry images on high-DPI screens

**Solution:**
- Export and include @2x and @3x versions
- Flutter automatically selects appropriate resolution

### Issue: Large app size

**Solution:**
- Optimize all images before adding
- Use WebP format
- Consider lazy loading for non-essential assets
- Use vector (SVG) instead of raster when possible

### Issue: SVG not rendering correctly

**Solution:**
- Ensure text is outlined
- Remove unsupported filters/effects
- Simplify complex paths
- Test with `flutter_svg` package

## Resources

- [Flutter Assets Documentation](https://docs.flutter.dev/development/ui/assets-and-images)
- [flutter_svg Package](https://pub.dev/packages/flutter_svg)
- [Lottie for Flutter](https://pub.dev/packages/lottie)
- [Image Optimization Guide](https://web.dev/fast/#optimize-your-images)

---

**Last Updated:** January 2026  
**Version:** 1.0.0  
**Maintainer:** Development Team
