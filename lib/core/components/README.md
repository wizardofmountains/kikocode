# Component Library

This directory contains reusable UI components organized using atomic design principles.

## Directory Structure

```
components/
├── atoms/          # Basic building blocks
├── molecules/      # Combinations of atoms
├── organisms/      # Complex component combinations
└── components.dart # Main export file
```

## Atomic Design Principles

### Atoms (Primitives)
The smallest, indivisible components:
- **AppButton** - Button with multiple variants and sizes
- **AppInput** - Text input field
- **AppIcon** - Icon wrapper for Material icons and SVGs
- **AppBadge** - Status badges and labels

### Molecules (Composites)
Combinations of atoms working together:
- **AppCard** - Container with consistent styling
- **AppListTile** - List item with leading/trailing widgets
- **AppFormField** - Complete form input with validation

### Organisms (Sections)
Complex components made from molecules and atoms:
- **AppHeader** - App bar variations
- **AppBottomNav** - Bottom navigation bar

## Usage

### Import All Components
```dart
import 'package:kikocode/core/components/components.dart';
```

### Import Specific Categories
```dart
import 'package:kikocode/core/components/atoms/atoms.dart';
import 'package:kikocode/core/components/molecules/molecules.dart';
import 'package:kikocode/core/components/organisms/organisms.dart';
```

## Examples

### Using Atoms
```dart
// Button
AppButton(
  label: 'Submit',
  onPressed: () {},
  variant: AppButtonVariant.primary,
)

// Input
AppInput(
  label: 'Email',
  hintText: 'Enter your email',
  prefixIcon: Icons.email,
)

// Badge
AppBadge(
  label: 'Active',
  variant: AppBadgeVariant.success,
)
```

### Using Molecules
```dart
// Card
AppCard(
  child: Text('Card content'),
)

// List Tile
AppListTile(
  leading: Icon(Icons.person),
  title: 'John Doe',
  subtitle: 'Developer',
  trailing: Icon(Icons.chevron_right),
  onTap: () {},
)

// Form Field
AppFormField(
  label: 'Username',
  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
)
```

### Using Organisms
```dart
// Header
AppHeader(
  title: 'Home',
  actions: [Icon(Icons.search)],
)

// Bottom Navigation
AppBottomNav(
  currentIndex: 0,
  onTap: (index) {},
  items: [
    AppBottomNavItem(icon: Icons.home, label: 'Home'),
    AppBottomNavItem(icon: Icons.search, label: 'Search'),
  ],
)
```

## Design System Integration

All components are built on top of the design system tokens:
- Colors: `AppColors`
- Typography: `AppTypography`
- Spacing: `AppSpacing`
- Borders: `AppBorders`
- Shadows: `AppShadows`
- Breakpoints: `AppBreakpoints`

## Adding New Components

When adding new components:

1. **Choose the right category**:
   - Atom: Can't be broken down further
   - Molecule: Combination of 2-5 atoms
   - Organism: Complex section with multiple molecules

2. **Follow naming conventions**:
   - Prefix with `App` (e.g., `AppButton`)
   - Use descriptive names
   - Export from category barrel file

3. **Include documentation**:
   - Class-level documentation
   - Parameter descriptions
   - Usage examples

4. **Use design system**:
   - Always use design tokens
   - Don't hardcode values
   - Maintain consistency

5. **Make it reusable**:
   - Support customization via props
   - Provide sensible defaults
   - Handle edge cases

## Component Checklist

- [ ] Uses design system tokens
- [ ] Includes documentation and examples
- [ ] Supports customization
- [ ] Handles loading/error states
- [ ] Accessible (semantic labels)
- [ ] Responsive (works on all screen sizes)
- [ ] Follows Flutter best practices
- [ ] Exported from barrel file

## References

- [Atomic Design by Brad Frost](https://atomicdesign.bradfrost.com/)
- [Flutter Widget Catalog](https://docs.flutter.dev/development/ui/widgets)
- Design System: `/lib/core/design_system/`

---

**Last Updated:** January 2026  
**Maintained by:** Development Team
