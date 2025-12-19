import 'package:flutter/widgets.dart';

/// Tailwind-inspired breakpoint system for Flutter
/// 
/// Provides responsive breakpoints matching Tailwind's responsive design utilities
class AppBreakpoints {
  // Prevent instantiation
  AppBreakpoints._();

  // ============= Breakpoint Values (in logical pixels) =============
  static const double xs = 0;        // Extra small devices (phones)
  static const double sm = 640;      // Small devices (large phones)
  static const double md = 768;      // Medium devices (tablets)
  static const double lg = 1024;     // Large devices (laptops)
  static const double xl = 1280;     // Extra large devices (desktops)
  static const double xl2 = 1536;    // 2xl devices (large desktops)

  // ============= Screen Size Helpers =============
  
  /// Get the current screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get the current screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Check if screen is at least a certain breakpoint
  static bool isXs(BuildContext context) {
    return getScreenWidth(context) >= xs;
  }

  static bool isSm(BuildContext context) {
    return getScreenWidth(context) >= sm;
  }

  static bool isMd(BuildContext context) {
    return getScreenWidth(context) >= md;
  }

  static bool isLg(BuildContext context) {
    return getScreenWidth(context) >= lg;
  }

  static bool isXl(BuildContext context) {
    return getScreenWidth(context) >= xl;
  }

  static bool is2Xl(BuildContext context) {
    return getScreenWidth(context) >= xl2;
  }

  // ============= Screen Type Checks =============
  
  /// Check if current screen is mobile (< md)
  static bool isMobile(BuildContext context) {
    return getScreenWidth(context) < md;
  }

  /// Check if current screen is tablet (>= md and < lg)
  static bool isTablet(BuildContext context) {
    final width = getScreenWidth(context);
    return width >= md && width < lg;
  }

  /// Check if current screen is desktop (>= lg)
  static bool isDesktop(BuildContext context) {
    return getScreenWidth(context) >= lg;
  }

  /// Check if current screen is large desktop (>= xl2)
  static bool isLargeDesktop(BuildContext context) {
    return getScreenWidth(context) >= xl2;
  }

  // ============= Responsive Value Selection =============
  
  /// Get a value based on current breakpoint
  /// 
  /// Example:
  /// ```dart
  /// final padding = AppBreakpoints.value(
  ///   context,
  ///   xs: 8.0,
  ///   sm: 12.0,
  ///   md: 16.0,
  ///   lg: 24.0,
  ///   xl: 32.0,
  /// );
  /// ```
  static T value<T>(
    BuildContext context, {
    required T xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xl2,
  }) {
    final width = getScreenWidth(context);

    if (xl2 != null && width >= AppBreakpoints.xl2) return xl2;
    if (xl != null && width >= AppBreakpoints.xl) return xl;
    if (lg != null && width >= AppBreakpoints.lg) return lg;
    if (md != null && width >= AppBreakpoints.md) return md;
    if (sm != null && width >= AppBreakpoints.sm) return sm;

    return xs;
  }

  /// Get a value based on mobile, tablet, or desktop
  /// 
  /// Example:
  /// ```dart
  /// final columns = AppBreakpoints.device(
  ///   context,
  ///   mobile: 1,
  ///   tablet: 2,
  ///   desktop: 3,
  /// );
  /// ```
  static T device<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) return desktop;
    if (isTablet(context) && tablet != null) return tablet;
    return mobile;
  }

  // ============= Responsive Builders =============
  
  /// Build different widgets based on screen size
  /// 
  /// Example:
  /// ```dart
  /// AppBreakpoints.responsive(
  ///   context,
  ///   mobile: MobileLayout(),
  ///   tablet: TabletLayout(),
  ///   desktop: DesktopLayout(),
  /// )
  /// ```
  static Widget responsive(
    BuildContext context, {
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    if (isDesktop(context) && desktop != null) return desktop;
    if (isTablet(context) && tablet != null) return tablet;
    return mobile;
  }

  /// Build widget with builder pattern
  /// 
  /// Example:
  /// ```dart
  /// AppBreakpoints.builder(
  ///   context,
  ///   builder: (context, breakpoint) {
  ///     if (breakpoint == ScreenType.desktop) {
  ///       return DesktopLayout();
  ///     }
  ///     return MobileLayout();
  ///   },
  /// )
  /// ```
  static Widget builder(
    BuildContext context, {
    required Widget Function(BuildContext, ScreenType) builder,
  }) {
    final screenType = getScreenType(context);
    return builder(context, screenType);
  }

  // ============= Screen Type Enum =============
  
  static ScreenType getScreenType(BuildContext context) {
    final width = getScreenWidth(context);

    if (width >= xl2) return ScreenType.xl2;
    if (width >= xl) return ScreenType.xl;
    if (width >= lg) return ScreenType.lg;
    if (width >= md) return ScreenType.md;
    if (width >= sm) return ScreenType.sm;

    return ScreenType.xs;
  }

  // ============= Orientation Helpers =============
  
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // ============= Safe Area Helpers =============
  
  static EdgeInsets getSafeArea(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  static double getSafeAreaTop(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getSafeAreaBottom(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  // ============= Grid Columns =============
  
  /// Get recommended grid columns based on screen size
  static int getGridColumns(BuildContext context) {
    return device(
      context,
      mobile: 4,
      tablet: 8,
      desktop: 12,
    );
  }

  /// Get recommended max content width based on screen size
  static double getMaxContentWidth(BuildContext context) {
    return value(
      context,
      xs: double.infinity,
      sm: double.infinity,
      md: 768,
      lg: 1024,
      xl: 1280,
      xl2: 1536,
    );
  }
}

/// Screen type enum for responsive design
enum ScreenType {
  xs,   // < 640px
  sm,   // >= 640px
  md,   // >= 768px
  lg,   // >= 1024px
  xl,   // >= 1280px
  xl2,  // >= 1536px
}

/// Extension on ScreenType for convenient checks
extension ScreenTypeExtension on ScreenType {
  bool get isXs => this == ScreenType.xs;
  bool get isSm => this == ScreenType.sm;
  bool get isMd => this == ScreenType.md;
  bool get isLg => this == ScreenType.lg;
  bool get isXl => this == ScreenType.xl;
  bool get is2Xl => this == ScreenType.xl2;

  bool get isMobile => this == ScreenType.xs || this == ScreenType.sm;
  bool get isTablet => this == ScreenType.md;
  bool get isDesktop => this == ScreenType.lg || this == ScreenType.xl || this == ScreenType.xl2;
}

