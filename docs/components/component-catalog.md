# Component Catalog

Complete reference of all available components in the KIKO component library.

## Atoms

### AppButton

Reusable button with multiple variants and sizes.

**Variants:**
- `primary` - Primary brand button
- `secondary` - Secondary button
- `outline` - Outlined button
- `ghost` - Text-only button
- `danger` - Destructive action button

**Sizes:**
- `small` - 36px height
- `medium` - 44px height (default)
- `large` - 52px height

**Features:**
- Icon support (left or right)
- Loading state
- Disabled state
- Full width option

**Example:**
```dart
AppButton(
  label: 'Submit',
  onPressed: () {},
  variant: AppButtonVariant.primary,
  size: AppButtonSize.medium,
  icon: Icons.check,
  loading: false,
  fullWidth: false,
)
```

### AppInput

Text input field with consistent styling.

**Sizes:**
- `small` - Compact input
- `medium` - Standard input (default)
- `large` - Large input

**Features:**
- Prefix/suffix icons
- Password visibility toggle
- Label and helper text
- Error states
- Character limit
- Multi-line support

**Example:**
```dart
AppInput(
  label: 'Email',
  hintText: 'Enter your email',
  prefixIcon: Icons.email,
  keyboardType: TextInputType.emailAddress,
  onChanged: (value) {},
)
```

### AppIcon

Icon wrapper supporting Material icons and SVGs.

**Sizes:**
- `xSmall` - 16px
- `small` - 20px
- `medium` - 24px (default)
- `large` - 32px
- `xLarge` - 48px

**Variants:**
- `AppIcon` - Standard icon
- `AppIconCircle` - Icon in circular background
- `AppIconSquare` - Icon in square background

**Example:**
```dart
AppIcon(
  icon: Icons.home,
  size: AppIconSize.medium,
  color: AppColors.primary,
)

AppIcon.svg(
  assetPath: AssetPaths.iconCustom,
  size: AppIconSize.medium,
  color: AppColors.primary,
)
```

### AppBadge

Status badges and labels.

**Variants:**
- `primary` - Primary color
- `secondary` - Secondary color
- `success` - Green/success
- `warning` - Orange/warning
- `error` - Red/error
- `info` - Blue/info
- `neutral` - Gray/neutral

**Sizes:**
- `small` - Compact badge
- `medium` - Standard badge (default)
- `large` - Large badge

**Features:**
- Icon support
- Deletable (with X button)
- Tappable
- Notification badge variant

**Example:**
```dart
AppBadge(
  label: 'Active',
  variant: AppBadgeVariant.success,
  size: AppBadgeSize.medium,
  icon: Icons.check,
  onDelete: () {},
)

AppNotificationBadge(count: 5)
```

## Molecules

### AppCard

Container component with consistent styling.

**Elevation Levels:**
- `none` - No shadow
- `low` - Subtle shadow (default)
- `medium` - Medium shadow
- `high` - Prominent shadow

**Variants:**
- `AppCard` - Basic card
- `AppCardSection` - Card with header/body/footer
- `AppImageCard` - Card with image

**Example:**
```dart
AppCard(
  elevation: AppCardElevation.low,
  onTap: () {},
  child: Column(
    children: [
      Text('Title', style: AppTypography.h4),
      Text('Content'),
    ],
  ),
)

AppImageCard(
  imageUrl: 'https://...',
  title: 'Card Title',
  description: 'Description',
  footer: AppButton(label: 'Action', onPressed: () {}),
)
```

### AppListTile

List item with leading/trailing widgets.

**Sizes:**
- `compact` - 48px height
- `standard` - 56px height (default)
- `large` - 72px height

**Variants:**
- `AppListTile` - Basic list tile
- `AppAvatarListTile` - With avatar
- `AppCheckboxListTile` - With checkbox
- `AppSwitchListTile` - With switch

**Example:**
```dart
AppListTile(
  leading: Icon(Icons.person),
  title: 'John Doe',
  subtitle: 'Developer',
  trailing: Icon(Icons.chevron_right),
  onTap: () {},
)

AppCheckboxListTile(
  title: 'Accept terms',
  value: isChecked,
  onChanged: (value) {},
)
```

### AppFormField

Complete form field with validation.

**Features:**
- Required field indicator
- Validation
- Helper text
- Error messages
- All AppInput features

**Variants:**
- `AppFormField` - Standard field
- `AppDropdownFormField` - Dropdown select
- `AppTextAreaFormField` - Multi-line text area

**Example:**
```dart
AppFormField(
  label: 'Username',
  hintText: 'Enter username',
  required: true,
  validator: (value) {
    if (value?.isEmpty ?? true) return 'Required';
    return null;
  },
)

AppTextAreaFormField(
  label: 'Message',
  minLines: 3,
  maxLines: 6,
)
```

## Organisms

### AppHeader

App bar with consistent styling.

**Variants:**
- `AppHeader` - Standard app bar
- `AppSearchHeader` - With integrated search
- `AppLargeHeader` - Large header with subtitle
- `AppTabHeader` - With tabs

**Features:**
- Back button
- Actions
- Custom title widget
- Bottom widget (tabs, etc.)

**Example:**
```dart
AppHeader(
  title: 'Home',
  showBackButton: true,
  actions: [
    IconButton(icon: Icon(Icons.search), onPressed: () {}),
  ],
)

AppSearchHeader(
  hintText: 'Search...',
  onSearch: (query) {},
)
```

### AppBottomNav

Bottom navigation bar.

**Variants:**
- `AppBottomNav` - Standard Material bottom nav
- `AppCustomBottomNav` - Custom styled bottom nav
- `AppBottomNavWithFab` - With floating action button

**Features:**
- Multiple items
- Active/inactive states
- Badges support
- Custom styling

**Example:**
```dart
AppBottomNav(
  currentIndex: 0,
  onTap: (index) {},
  items: [
    AppBottomNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
      badge: AppNotificationBadge(count: 3),
    ),
    AppBottomNavItem(
      icon: Icons.search_outlined,
      activeIcon: Icons.search,
      label: 'Search',
    ),
  ],
)
```

## Usage Guidelines

### When to Use Each Component

**Buttons:**
- Primary: Main call-to-action
- Secondary: Secondary actions
- Outline: Alternative actions
- Ghost: Tertiary actions
- Danger: Destructive actions

**Cards:**
- Basic card: General content container
- Image card: Content with media
- Card section: Structured content

**List Items:**
- Standard: Navigation or selection
- Avatar: User-related items
- Checkbox/Switch: Settings or selections

### Component Composition

Components can be composed together:

```dart
// Card with list tiles
AppCard(
  child: Column(
    children: [
      AppListTile(title: 'Item 1', onTap: () {}),
      Divider(height: 1),
      AppListTile(title: 'Item 2', onTap: () {}),
    ],
  ),
)

// Button with badge
Stack(
  children: [
    AppButton(label: 'Messages', onPressed: () {}),
    Positioned(
      right: 0,
      top: 0,
      child: AppNotificationBadge(count: 5),
    ),
  ],
)
```

### Accessibility

All components include:
- Semantic labels
- Proper touch targets (≥44x44)
- WCAG-compliant contrast
- Screen reader support

### Performance

Components are optimized for:
- Minimal rebuilds
- Efficient rendering
- Small bundle size

## Component Development

### Adding New Components

1. **Determine Category:**
   - Atom: Indivisible component
   - Molecule: 2-5 atoms combined
   - Organism: Complex section

2. **Create Component File:**
   ```
   lib/core/components/[category]/app_[name].dart
   ```

3. **Follow Structure:**
   ```dart
   /// Component documentation
   class AppComponent extends StatelessWidget {
     /// Parameter documentation
     final Type parameter;
     
     const AppComponent({
       super.key,
       required this.parameter,
     });
     
     @override
     Widget build(BuildContext context) {
       // Implementation using design tokens
     }
   }
   ```

4. **Export Component:**
   Add to category barrel file (`atoms.dart`, etc.)

5. **Add to Showcase:**
   Update component showcase screen

### Component Checklist

- [ ] Uses design system tokens
- [ ] Includes documentation
- [ ] Supports customization
- [ ] Handles all states
- [ ] Accessible
- [ ] Responsive
- [ ] Exported from barrel file
- [ ] Added to showcase

## Resources

- **Component Showcase:** `/showcase/components`
- **Design System:** `/showcase/design-system`
- **Examples:** `/docs/examples/`
- **Figma Mapping:** `/docs/figma/component-mapping.md`

---

**Last Updated:** January 2026  
**Version:** 1.0.0  
**Maintained by:** Development Team
