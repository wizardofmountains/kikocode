# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

KIKO ("Kommunikation kinderleicht!" - Communication made easy) is a multi-platform Flutter application for iOS, Android, Web, Windows, Linux, and macOS. The backend uses Supabase.

## Common Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Run static analysis
flutter analyze

# Run tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Build for production (replace <platform> with ios, apk, web, etc.)
flutter build <platform>
```

## Architecture

**Layered architecture with feature-based organization:**

```
lib/
├── core/                      # Shared infrastructure
│   ├── components/            # Atomic design component library
│   │   ├── atoms/             # AppButton, AppInput, AppIcon, AppBadge
│   │   ├── molecules/         # AppCard, AppListTile, AppFormField
│   │   └── organisms/         # AppHeader, AppBottomNav
│   ├── design_system/         # Design tokens (colors, typography, spacing, etc.)
│   ├── constants/             # App-wide constants and type-safe asset paths
│   ├── config/                # Supabase and other configuration
│   ├── router/                # GoRouter navigation setup
│   └── widgets/               # Utility widgets
│
├── features/                  # Feature modules
│   ├── auth/                  # Authentication (welcome, login, verification)
│   ├── home/                  # Main home screen
│   └── messages/              # Messaging feature
│
└── main.dart
```

## Key Technologies

- **State Management:** flutter_riverpod
- **Backend:** supabase_flutter
- **Navigation:** go_router (routes defined in `lib/core/router/app_router.dart`)
- **Icons:** coolicons, Material Icons
- **Fonts:** google_fonts
- **SVG Support:** flutter_svg

## Development Guidelines

**From `.cursor/rules/rule.mdc`:**

- Write concise, declarative Dart code; prefer functional patterns
- Use `StatelessWidget` and `const` constructors by default
- Favor composition over inheritance; use small, private Widget classes instead of helper methods
- Use built-in state solutions (ValueNotifier, ChangeNotifier, StreamBuilder) by default; flutter_riverpod is used in this project
- Use `FutureBuilder` for single async calls; `StreamBuilder` for sequences
- Use manual constructor injection for dependencies
- Use `go_router` for all navigation
- Always use Context7 MCP when I need library/API documentation, code generation, setup or configuration steps without me having to explicitly ask.

## Component Library

Import components via barrel files:

```dart
import 'package:kikocode/core/components/components.dart';
import 'package:kikocode/core/design_system/design_system.dart';
```

**Developer showcase routes (debug mode only):**

- `/showcase/components` - Interactive component showcase
- `/showcase/design-system` - Design system showcase

## Routes

Main routes defined in `lib/core/router/app_router.dart`:

- `/` - Welcome screen
- `/login` - Login
- `/verification` - Phone/email verification
- `/loading` - Loading state
- `/home` - Main screen
- `/group-selection` - Group selection
- `/messages` - Message list
- `/message/:groupName` - Individual message thread
- `/message-status` - Message status

## Key Documentation

- `DESIGN_SYSTEM.md` - Complete design system documentation
- `FIGMA_WORKFLOW.md` - Figma to Flutter workflow guide
- `PROJECT_STRUCTURE.md` - Detailed project structure
- `docs/figma/component-mapping.md` - Figma ↔ Flutter component mapping
- `docs/components/component-catalog.md` - Full component reference
