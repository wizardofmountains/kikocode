# Figma to Flutter Component Mapping

Guide for mapping Figma components and design elements to Flutter widgets and components.

## Component Hierarchy

### Atomic Design Mapping

| Figma Term | Flutter Equivalent | KIKO Component |
|------------|-------------------|----------------|
| Component | Widget | AppButton, AppInput, etc. |
| Instance | Widget instantiation | Usage of component |
| Variant | Enum/Parameter | AppButtonVariant.primary |
| Auto Layout | Column/Row/Flex | Layout widgets |
| Frame | Container | Container, SizedBox |

## Common Component Mappings

### Buttons

| Figma Component | Flutter Component | Code Example |
|----------------|-------------------|--------------|
| Primary Button | AppButton | `AppButton(variant: primary)` |
| Secondary Button | AppButton | `AppButton(variant: secondary)` |
| Outline Button | AppButton | `AppButton(variant: outline)` |
| Text Button | AppButton | `AppButton(variant: ghost)` |
| Icon Button | IconButton | `IconButton(icon: Icon(...))` |
| FAB | FloatingActionButton | `FloatingActionButton(...)` |

**Example:**

```dart
// Figma: Primary Button, 44px height, 16px padding
AppButton(
  label: 'Submit',
  onPressed: () {},
  variant: AppButtonVariant.primary,
  size: AppButtonSize.medium,
)
```

### Text Inputs

| Figma Component | Flutter Component | Code Example |
|----------------|-------------------|--------------|
| Text Field | AppInput | `AppInput(label: 'Email')` |
| Text Area | AppInput | `AppInput(maxLines: 5)` |
| Search Field | TextField | With prefix icon |
| Password Field | AppInput | `AppInput(obscureText: true)` |
| Dropdown | DropdownButton | `AppDropdownFormField(...)` |

**Example:**

```dart
// Figma: Email Input with icon, 44px height
AppInput(
  label: 'Email',
  hintText: 'Enter your email',
  prefixIcon: Icons.email,
  keyboardType: TextInputType.emailAddress,
  size: AppInputSize.medium,
)
```

### Cards

| Figma Component | Flutter Component | Code Example |
|----------------|-------------------|--------------|
| Card | AppCard | `AppCard(child: ...)` |
| Elevated Card | AppCard | With elevation parameter |
| Image Card | AppImageCard | `AppImageCard(...)` |
| Info Card | AppCardSection | With header/footer |

**Example:**

```dart
// Figma: Card with 24px padding, 16px radius, shadow
AppCard(
  padding: AppSpacing.all6,
  elevation: AppCardElevation.medium,
  child: Column(
    children: [
      Text('Title', style: AppTypography.h4),
      AppSpacing.v2,
      Text('Content', style: AppTypography.bodyBase),
    ],
  ),
)
```

### Lists

| Figma Component | Flutter Component | Code Example |
|----------------|-------------------|--------------|
| List Item | AppListTile | `AppListTile(...)` |
| Avatar List Item | AppAvatarListTile | With leading avatar |
| Checkbox Item | AppCheckboxListTile | `AppCheckboxListTile(...)` |
| Switch Item | AppSwitchListTile | `AppSwitchListTile(...)` |

**Example:**

```dart
// Figma: List item with avatar, title, subtitle
AppAvatarListTile(
  avatar: CircleAvatar(child: Text('JD')),
  title: 'John Doe',
  subtitle: 'Software Developer',
  trailing: Icon(Icons.chevron_right),
  onTap: () {},
)
```

### Navigation

| Figma Component | Flutter Component | Code Example |
|----------------|-------------------|--------------|
| App Bar | AppHeader | `AppHeader(title: ...)` |
| Bottom Nav | AppBottomNav | `AppBottomNav(items: ...)` |
| Tab Bar | TabBar | With TabController |
| Drawer | Drawer | `Drawer(child: ...)` |

**Example:**

```dart
// Figma: App bar with title and actions
AppHeader(
  title: 'Home',
  actions: [
    IconButton(icon: Icon(Icons.search), onPressed: () {}),
    IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
  ],
)
```

### Badges & Labels

| Figma Component | Flutter Component | Code Example |
|----------------|-------------------|--------------|
| Badge | AppBadge | `AppBadge(label: 'New')` |
| Status Badge | AppBadge | With variant parameter |
| Chip | AppBadge | Deletable badge |
| Tag | AppBadge | Small size |
| Notification Dot | AppNotificationBadge | `AppNotificationBadge(count: 5)` |

**Example:**

```dart
// Figma: Success badge with green background
AppBadge(
  label: 'Active',
  variant: AppBadgeVariant.success,
  size: AppBadgeSize.medium,
)
```

## Layout Mappings

### Auto Layout → Flutter Layouts

| Figma Auto Layout | Flutter Widget | Notes |
|------------------|----------------|-------|
| Vertical | Column | Children stacked vertically |
| Horizontal | Row | Children arranged horizontally |
| Wrap | Wrap | Children wrap to next line |
| Stack | Stack | Overlapping children |
| Absolute Position | Positioned (in Stack) | Absolute positioning |

### Layout Properties

| Figma Property | Flutter Property | Example |
|----------------|-----------------|---------|
| Padding | padding | `padding: AppSpacing.all4` |
| Spacing (gap) | SizedBox/Gap | `AppSpacing.v4` between children |
| Fill Container | Expanded/Flexible | `Expanded(child: ...)` |
| Hug Contents | MainAxisSize.min | In Column/Row |
| Alignment | mainAxisAlignment, crossAxisAlignment | Various options |

**Example:**

```dart
// Figma: Auto Layout vertical, 16px gap, center aligned
Column(
  mainAxisSize: MainAxisSize.min,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Widget1(),
    AppSpacing.v4,  // 16px gap
    Widget2(),
    AppSpacing.v4,
    Widget3(),
  ],
)
```

## Effects Mapping

### Shadows

| Figma Effect | Flutter Property | Notes |
|--------------|-----------------|-------|
| Drop Shadow | boxShadow | Use AppShadows constants |
| Inner Shadow | Not directly supported | Alternative: Stack with blur |
| Layer Blur | BackdropFilter | For background blur |

**Example:**

```dart
// Figma: Drop shadow (0, 4, 6, -1, rgba(0,0,0,0.1))
Container(
  decoration: BoxDecoration(
    color: AppColors.surface,
    borderRadius: AppBorders.lg,
    boxShadow: AppShadows.md,
  ),
  child: ...,
)
```

### Opacity

```dart
// Figma: 50% opacity
Opacity(
  opacity: 0.5,
  child: Widget(),
)

// Or for colors:
Container(
  color: AppColors.primary.withOpacity(0.5),
)
```

### Blur

```dart
// Figma: Background blur
BackdropFilter(
  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  child: Container(
    color: Colors.black.withOpacity(0.3),
    child: ...,
  ),
)
```

## Typography Mapping

### Text Styles

| Figma Style | Flutter Style | Code |
|-------------|--------------|------|
| Heading 1 | AppTypography.h1 | `Text('...', style: AppTypography.h1)` |
| Heading 2 | AppTypography.h2 | `Text('...', style: AppTypography.h2)` |
| Body Text | AppTypography.bodyBase | Default |
| Caption | AppTypography.caption | `Text('...', style: AppTypography.caption)` |
| Button Text | AppTypography.buttonBase | Used in buttons |

### Text Properties

| Figma Property | Flutter Property | Example |
|----------------|-----------------|---------|
| Font Family | fontFamily | `fontFamily: 'Inter'` |
| Font Size | fontSize | `fontSize: 16` |
| Font Weight | fontWeight | `fontWeight: FontWeight.w600` |
| Line Height | height | `height: 1.5` (150%) |
| Letter Spacing | letterSpacing | `letterSpacing: -0.5` |
| Text Color | color | `color: AppColors.textPrimary` |
| Text Align | textAlign | `textAlign: TextAlign.center` |

## Color Mapping

### Color Properties

| Figma Property | Flutter Property | Example |
|----------------|-----------------|---------|
| Fill | color / backgroundColor | `color: AppColors.primary` |
| Stroke | border | `border: Border.all(color: ...)` |
| Text Color | TextStyle.color | `style: TextStyle(color: ...)` |
| Opacity | withOpacity() | `AppColors.primary.withOpacity(0.5)` |

### Gradients

```dart
// Figma: Linear gradient (purple to blue)
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.primary,
        AppColors.secondary,
      ],
    ),
  ),
)

// Figma: Radial gradient
Container(
  decoration: BoxDecoration(
    gradient: RadialGradient(
      colors: [Colors.white, AppColors.primary],
    ),
  ),
)
```

## Interactive States

### Hover (Web/Desktop)

```dart
// Figma: Hover state with color change
MouseRegion(
  onEnter: (_) => setState(() => isHovered = true),
  onExit: (_) => setState(() => isHovered = false),
  child: Container(
    color: isHovered ? AppColors.primary600 : AppColors.primary,
    child: ...,
  ),
)
```

### Press/Tap

```dart
// Figma: Active/pressed state
GestureDetector(
  onTapDown: (_) => setState(() => isPressed = true),
  onTapUp: (_) => setState(() => isPressed = false),
  onTapCancel: () => setState(() => isPressed = false),
  child: Container(
    color: isPressed ? AppColors.primary700 : AppColors.primary,
    child: ...,
  ),
)

// Or use InkWell for ripple effect
InkWell(
  onTap: () {},
  child: ...,
)
```

### Disabled

```dart
// Figma: Disabled state with reduced opacity
AppButton(
  label: 'Submit',
  onPressed: () {},
  enabled: false,  // Automatically handles disabled styling
)

// Or manual:
Opacity(
  opacity: isEnabled ? 1.0 : 0.5,
  child: ...,
)
```

## Common Patterns

### Modal/Dialog

```dart
// Figma: Modal with overlay
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Title'),
    content: Text('Content'),
    actions: [
      AppButton(
        label: 'Cancel',
        onPressed: () => Navigator.pop(context),
        variant: AppButtonVariant.ghost,
      ),
      AppButton(
        label: 'Confirm',
        onPressed: () {},
      ),
    ],
  ),
)
```

### Bottom Sheet

```dart
// Figma: Bottom sheet
showModalBottomSheet(
  context: context,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(16),
    ),
  ),
  builder: (context) => Container(
    padding: AppSpacing.all6,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [...],
    ),
  ),
)
```

### Snackbar/Toast

```dart
// Figma: Toast notification
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Message sent'),
    backgroundColor: AppColors.success,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: AppBorders.lg,
    ),
  ),
)
```

## Tips for Accurate Mapping

1. **Use Dev Mode:** Always reference Figma Dev Mode for exact values
2. **Component Library:** Check existing components before creating new ones
3. **Design Tokens:** Use design system tokens, never hardcode values
4. **Variants:** Map Figma variants to Flutter enums/parameters
5. **States:** Ensure all interactive states are implemented
6. **Responsive:** Consider responsive behavior from the start
7. **Accessibility:** Add semantic labels and proper touch targets

## Checklist

- [ ] All Figma components mapped to Flutter equivalents
- [ ] Interactive states documented
- [ ] Layout patterns identified
- [ ] Typography mapped correctly
- [ ] Colors use design tokens
- [ ] Spacing follows design system
- [ ] Effects (shadows, blur) implemented
- [ ] Responsive behavior planned
- [ ] Accessibility considered

---

**Last Updated:** January 2026  
**Version:** 1.0.0
