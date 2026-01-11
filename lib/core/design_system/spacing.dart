import 'package:flutter/material.dart';

/// Spacing system for consistent layout spacing across the app
/// Based on Figma design specifications
class AppSpacing {
  // Prevent instantiation
  AppSpacing._();

  // ============= Spacing Scale =============
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double huge = 40.0;
  static const double giant = 48.0;

  // ============= Common Use Cases =============
  static const double cardPadding = xl;
  static const double screenPadding = lg;
  static const double sectionSpacing = xxl;
  static const double itemSpacing = md;
  static const double iconSpacing = sm;

  // ============= Legacy spacing values (for theme.dart compatibility) =============
  static const double spacing2 = sm; // 8.0
  static const double spacing3 = md; // 12.0
  static const double spacing4 = lg; // 16.0
  static const EdgeInsets all4 = EdgeInsets.all(lg); // 16.0
  
  // ============= Button Padding =============
  static const double buttonPaddingHorizontal = xxl; // 24.0
  static const double buttonPaddingVertical = md; // 12.0
  
  // ============= Input Padding =============
  static const double inputPaddingHorizontal = lg; // 16.0
  static const double inputPaddingVertical = md; // 12.0
  
  // ============= Edge Insets Helpers =============
  static const h4v0 = EdgeInsets.symmetric(horizontal: lg, vertical: 0);

  // ============= Border Radius =============
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusXxl = 25.0;
  static const double radiusFull = 999.0;

  // ============= Specific Component Radii (from Figma) =============
  static const double inputFieldRadius = radiusXxl; // 25px
  static const double cardRadius = 30.0;
  static const double buttonRadius = radiusXxl;
  static const double tabBarItemRadius = 13.0;
  
  // ============= EdgeInsets Factory Methods =============
  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) {
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }
}
