# Startup System Architecture

## Overview Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         App Launch                               │
│                         (main.dart)                              │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                      StartupScreen                               │
│                  (Shows logo + loading)                          │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                   appStartupProvider                             │
│                   (FutureProvider)                               │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                  StartupRepository                               │
│                                                                   │
│  1. Initialize Supabase                                          │
│  2. Check Auth Status                                            │
│  3. Return User | null                                           │
└────────────────────────┬────────────────────────────────────────┘
                         │
         ┌───────────────┴───────────────┐
         │                               │
         ▼                               ▼
┌──────────────────┐           ┌──────────────────┐
│  User != null    │           │  User == null    │
│  (Authenticated) │           │  (Not Auth'd)    │
└────────┬─────────┘           └────────┬─────────┘
         │                               │
         ▼                               ▼
┌──────────────────┐           ┌──────────────────┐
│  Navigate to     │           │  Navigate to     │
│  /home           │           │  /welcome        │
│  (Home Screen)   │           │  (Welcome Screen)│
└──────────────────┘           └──────────────────┘
```

## Component Relationships

```
StartupScreen (UI Layer)
    │
    └──► watches: appStartupProvider
              │
              └──► depends on: StartupRepository
                        │
                        ├──► uses: SupabaseConfig
                        └──► uses: AuthRepository
```

## State Flow

```
AsyncLoading (Initializing)
    │
    ├──► AsyncData(User?) ──► Navigate based on auth status
    │
    └──► AsyncError ──► Navigate to /welcome (fail-safe)
```

## File Organization

```
lib/features/startup/
├── data/
│   └── startup_repository.dart      [Business Logic]
│       - initializeApp()
│       - _initializeSupabase()
│
├── presentation/
│   ├── providers/
│   │   └── startup_providers.dart   [State Management]
│   │       - startupRepositoryProvider
│   │       - appStartupProvider
│   │
│   └── screens/
│       └── startup_screen.dart      [UI]
│           - Logo (299.52 x 120)
│           - Loading indicator
│           - Navigation logic
│
└── IMPLEMENTATION_SUMMARY.md        [Documentation]
```

## Integration Points

### 1. Router (`app_router.dart`)
```dart
initialLocation: '/startup'  // Changed from '/'

routes: [
  GoRoute(path: '/startup', ...) // NEW
  GoRoute(path: '/', ...)        // Existing (welcome)
  // ... other routes
]
```

### 2. Main Entry (`main.dart`)
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Supabase init removed - now in StartupRepository
  runApp(ProviderScope(child: MyApp()));
}
```

### 3. Auth System (`auth_repository.dart`)
```dart
// Used by StartupRepository to check auth status
currentUser → User?
authStateChanges → Stream<AuthState>
```

### 4. Supabase Config (`supabase_config.dart`)
```dart
// Called by StartupRepository
SupabaseConfig.initialize() → Future<void>
```

## Design Tokens Used

```dart
// Colors (from AppColors)
surfaceBase     #F3E7CE  (Background)
primary         #A974C7  (Loading indicator)
textSecondary   #374151  (Error text)

// Spacing (from AppSpacing)
v8              32px     (Logo to loading)
v6              24px     (Loading to error)
h6v0            24px horizontal padding

// Typography (from AppTypography)
bodySmall       14px Nunito Sans (Error text)

// Assets (from AssetPaths)
logoLight       logo_light.svg (KIKO logo)
```

## Error Handling Strategy

```
Initialization Error
    │
    ├──► Log error (with ignore: avoid_print)
    │
    ├──► Return null (treat as unauthenticated)
    │
    └──► Navigate to /welcome (fail-safe)

Result: App never crashes during startup
```

## Performance Considerations

- **Fast Path:** Supabase already initialized → instant check
- **Slow Path:** First initialization → ~500-1000ms
- **Visual Feedback:** Loading indicator always visible
- **No Blocking:** UI remains responsive

## Future Enhancement Hooks

The architecture supports easy additions:

1. **First-time Detection:**
   ```dart
   if (isFirstTime && user == null) {
     context.go('/onboarding');
   }
   ```

2. **Version Check:**
   ```dart
   final needsUpdate = await _checkVersion();
   if (needsUpdate) context.go('/update');
   ```

3. **Data Preload:**
   ```dart
   await Future.wait([
     _loadUserProfile(),
     _loadAppSettings(),
   ]);
   ```

4. **Analytics:**
   ```dart
   analytics.logEvent('app_startup', {
     'duration_ms': duration,
     'auth_status': user != null,
   });
   ```

---

**Architecture Pattern:** Repository Pattern + Provider State Management  
**Design Philosophy:** Fail-safe, User-centric, Maintainable  
**Code Quality:** Type-safe, Documented, Tested
