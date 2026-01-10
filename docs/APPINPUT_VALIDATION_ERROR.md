# AppInput Validation Error State - Complete Implementation Guide

## 🎨 Figma Design Extraction

This document details the validation error state design extracted from Figma node `560:2833` and fully implemented in the `AppInput` component.

## 📐 Visual Specifications

### Error State Input Field

| Property | Value | Flutter Implementation |
|----------|-------|------------------------|
| Background Color | `#FBF7EF` | `AppColors.surfaceHighest` |
| Border Width | `2px` | `width: 2` |
| Border Color | `#FF383C` | `AppColors.accentRed` |
| Border Radius | `25px` | `BorderRadius.circular(25)` |
| Height | `50px` | Controlled by `AppInputSize.medium` |
| Width | `350px` | Full width (set by parent) |

### Placeholder Text (Inside Field)

| Property | Value | Flutter Implementation |
|----------|-------|------------------------|
| Font Family | Nunito Sans | `AppTypography.body` |
| Font Weight | Regular (400) | `FontWeight.w400` |
| Font Size | `17px` | `fontSize: 17` |
| Color (Error) | `rgba(255, 56, 60, 0.4)` | `AppColors.accentRed.withOpacity(0.4)` |
| Color (Normal) | `#BFBFBF` | `AppColors.textTertiary` |

### Error Label (Above Field)

| Property | Value | Flutter Implementation |
|----------|-------|------------------------|
| Font Family | Nunito Sans | `AppTypography.caption2` |
| Font Weight | Regular (400) | `FontWeight.w400` |
| Font Size | `11px` | `fontSize: 11` |
| Color | `#FF383C` | `AppColors.accentRed` |
| Left Padding | `20px` | `EdgeInsets.only(left: 20)` |
| Spacing Below | `~2px` | `AppSpacing.v2` |

## 🔧 Component Implementation

### AppInput Component Features

The `AppInput` component (`lib/core/components/atoms/app_input.dart`) automatically handles the validation error state:

1. **Smart Label Display**: 
   - Normal state: Shows `label` in gray
   - Error state: Shows `errorText` in red (replaces label)

2. **Automatic Styling**:
   - Border color changes to red when error is present
   - Placeholder text color changes to red at 40% opacity
   - No error text shown below field (unlike Flutter default)

3. **Pixel-Perfect Alignment**:
   - Label has 20px left padding to match Figma design
   - Consistent with text padding inside the input field

### Code Example

```dart
// State management
String? _usernameError;
final _usernameController = TextEditingController();

// Validation logic
void _handleSubmit() {
  setState(() {
    _usernameError = null; // Reset error
  });
  
  if (_usernameController.text.isEmpty) {
    setState(() {
      _usernameError = 'Benutzername erforderlich!';
    });
    return;
  }
  
  // Continue with valid input...
}

// UI
AppInput(
  controller: _usernameController,
  label: 'Benutzername',
  hintText: 'Benutzername',
  errorText: _usernameError, // Pass error state
  size: AppInputSize.medium,
)
```

## 🎯 Usage in Login Screen

The login screen (`lib/features/auth/screens/login_screen.dart`) demonstrates the complete validation flow:

### Layout Structure (Figma Positions)

```
Top: 325px - Username AppInput (includes label above)
Top: 398px - Password AppInput (includes label above)  
Top: 550px - "Anmelden" Button
```

### Validation Flow

1. **User clicks "Anmelden" button** without filling fields
2. **Validation runs** in `_handleLogin()` method
3. **Error states set** via `setState()`
4. **AppInput automatically displays**:
   - Red label text above field
   - Red border around field
   - Red-tinted placeholder inside field

### Complete Implementation

```dart
class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  
  String? _usernameError;
  String? _passwordError;

  void _handleLogin() {
    // Reset errors
    setState(() {
      _usernameError = null;
      _passwordError = null;
    });

    // Validate
    bool hasError = false;
    
    if (_usernameController.text.isEmpty) {
      setState(() {
        _usernameError = 'Benutzername erforderlich!';
      });
      hasError = true;
    }
    
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Passwort erforderlich!';
      });
      hasError = true;
    }

    if (!hasError) {
      // Proceed with login...
      context.push('/auth/verification');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Username field at top: 325px
          Positioned(
            top: 325,
            left: 22,
            right: 22,
            child: AppInput(
              controller: _usernameController,
              label: 'Benutzername',
              hintText: 'Benutzername',
              errorText: _usernameError,
            ),
          ),
          
          // Password field at top: 398px
          Positioned(
            top: 398,
            left: 22,
            right: 22,
            child: AppInput(
              controller: _passwordController,
              label: 'Passwort',
              hintText: 'Passwort',
              obscureText: true,
              errorText: _passwordError,
            ),
          ),
          
          // Submit button
          Positioned(
            top: 550,
            child: AppButton(
              label: 'Anmelden',
              onPressed: _handleLogin,
            ),
          ),
        ],
      ),
    );
  }
}
```

## 🎨 Color Reference

All colors are defined in `lib/core/design_system/colors.dart`:

```dart
// Error/Validation Colors
static const Color accentRed = Color(0xFFFF383C);    // #FF383C

// Surface Colors
static const Color surfaceHighest = Color(0xFFFBF7EF); // #FBF7EF
static const Color surfaceLow = Color(0xFFEFDFBD);     // #EFDFBD (normal border)

// Text Colors  
static const Color textTertiary = Color(0xFFBFBFBF);   // #BFBFBF (placeholder)
```

## 📱 Visual Preview

### Normal State
```
┌─────────────────────────────────────┐
│ Benutzername (gray, 11px)           │ ← Label
│ ┌─────────────────────────────────┐ │
│ │ Benutzername (gray, 17px)       │ │ ← Field with placeholder
│ └─────────────────────────────────┘ │
│   ↑ 2px beige border                │
└─────────────────────────────────────┘
```

### Error State
```
┌─────────────────────────────────────┐
│ Benutzername erforderlich! (RED)    │ ← Error replaces label
│ ┌─────────────────────────────────┐ │
│ │ Benutzername (red 40%)          │ │ ← Field with red placeholder
│ └─────────────────────────────────┘ │
│   ↑ 2px RED border                  │
└─────────────────────────────────────┘
```

## ✅ Implementation Checklist

- [x] Extract Figma design specifications
- [x] Implement error border styling (2px solid red)
- [x] Implement error placeholder color (red at 40% opacity)
- [x] Implement error label above field
- [x] Add 20px left padding to label
- [x] Remove error text below field (non-standard Flutter behavior)
- [x] Integrate with login screen validation
- [x] Match exact pixel positions from Figma
- [x] Use correct typography (Nunito Sans 11px/17px)
- [x] Use correct colors from design system

## 🚀 Result

The AppInput component now perfectly matches the Figma validation error design. When a user clicks "Anmelden" without filling the required fields, the validation error state appears exactly as designed in Figma.

---

**Component File**: `lib/core/components/atoms/app_input.dart`  
**Example Usage**: `lib/features/auth/screens/login_screen.dart`  
**Figma Reference**: Node `560:2833` (Required validation state)  
**Last Updated**: January 10, 2026
