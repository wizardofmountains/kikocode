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

  // ============= Numeric Spacing Scale =============
  static const double spacing0 = 0.0;
  static const double spacing1 = 4.0;
  static const double spacing1_5 = 6.0;
  static const double spacing2 = 8.0;
  static const double spacing3 = 12.0;
  static const double spacing4 = 16.0;
  static const double spacing5 = 20.0;
  static const double spacing6 = 24.0;
  static const double spacing8 = 32.0;
  static const double spacing10 = 40.0;
  static const double spacing12 = 48.0;
  static const double spacing16 = 64.0;
  static const double spacing20 = 80.0;
  static const double spacing24 = 96.0;

  // ============= Common Use Cases =============
  static const double cardPadding = xl;
  static const double screenPadding = lg;
  static const double sectionSpacing = xxl;
  static const double itemSpacing = md;
  static const double iconSpacing = sm;

  // ============= Button Padding =============
  static const double buttonPaddingHorizontal = xxl; // 24.0
  static const double buttonPaddingVertical = md; // 12.0

  // ============= Input Padding =============
  static const double inputPaddingHorizontal = lg; // 16.0
  static const double inputPaddingVertical = md; // 12.0

  // ============= EdgeInsets Factory Methods =============

  // All sides
  static EdgeInsets all(double value) => EdgeInsets.all(value);
  static const EdgeInsets all0 = EdgeInsets.all(spacing0);
  static const EdgeInsets all1 = EdgeInsets.all(spacing1);
  static const EdgeInsets all2 = EdgeInsets.all(spacing2);
  static const EdgeInsets all3 = EdgeInsets.all(spacing3);
  static const EdgeInsets all4 = EdgeInsets.all(spacing4);
  static const EdgeInsets all5 = EdgeInsets.all(spacing5);
  static const EdgeInsets all6 = EdgeInsets.all(spacing6);
  static const EdgeInsets all8 = EdgeInsets.all(spacing8);
  static const EdgeInsets all10 = EdgeInsets.all(spacing10);
  static const EdgeInsets all12 = EdgeInsets.all(spacing12);
  static const EdgeInsets all16 = EdgeInsets.all(spacing16);
  static const EdgeInsets all20 = EdgeInsets.all(spacing20);
  static const EdgeInsets all24 = EdgeInsets.all(spacing24);

  // Symmetric
  static EdgeInsets symmetric({double vertical = 0, double horizontal = 0}) {
    return EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal);
  }

  static EdgeInsets horizontalOnly(double value) {
    return EdgeInsets.symmetric(horizontal: value);
  }

  static EdgeInsets verticalOnly(double value) {
    return EdgeInsets.symmetric(vertical: value);
  }

  // Common symmetric patterns
  static const EdgeInsets h1v0 = EdgeInsets.symmetric(horizontal: spacing1);
  static const EdgeInsets h2v0 = EdgeInsets.symmetric(horizontal: spacing2);
  static const EdgeInsets h3v0 = EdgeInsets.symmetric(horizontal: spacing3);
  static const EdgeInsets h4v0 = EdgeInsets.symmetric(horizontal: spacing4, vertical: 0);
  static const EdgeInsets h6v0 = EdgeInsets.symmetric(horizontal: spacing6);
  static const EdgeInsets h8v0 = EdgeInsets.symmetric(horizontal: spacing8);

  static const EdgeInsets h0v1 = EdgeInsets.symmetric(vertical: spacing1);
  static const EdgeInsets h0v2 = EdgeInsets.symmetric(vertical: spacing2);
  static const EdgeInsets h0v3 = EdgeInsets.symmetric(vertical: spacing3);
  static const EdgeInsets h0v4 = EdgeInsets.symmetric(vertical: spacing4);
  static const EdgeInsets h0v6 = EdgeInsets.symmetric(vertical: spacing6);
  static const EdgeInsets h0v8 = EdgeInsets.symmetric(vertical: spacing8);

  static const EdgeInsets h4v2 = EdgeInsets.symmetric(
    horizontal: spacing4,
    vertical: spacing2,
  );
  static const EdgeInsets h3v2 = EdgeInsets.symmetric(
    horizontal: spacing3,
    vertical: spacing2,
  );
  static const EdgeInsets h4v3 = EdgeInsets.symmetric(
    horizontal: spacing4,
    vertical: spacing3,
  );
  static const EdgeInsets h6v3 = EdgeInsets.symmetric(
    horizontal: spacing6,
    vertical: spacing3,
  );
  static const EdgeInsets h8v4 = EdgeInsets.symmetric(
    horizontal: spacing8,
    vertical: spacing4,
  );

  // Only specific sides
  static EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  static EdgeInsets topOnly(double value) => EdgeInsets.only(top: value);
  static EdgeInsets bottomOnly(double value) => EdgeInsets.only(bottom: value);
  static EdgeInsets leftOnly(double value) => EdgeInsets.only(left: value);
  static EdgeInsets rightOnly(double value) => EdgeInsets.only(right: value);

  // ============= SizedBox Helpers =============
  static const SizedBox verticalGap1 = SizedBox(height: spacing1);
  static const SizedBox verticalGap2 = SizedBox(height: spacing2);
  static const SizedBox verticalGap3 = SizedBox(height: spacing3);
  static const SizedBox verticalGap4 = SizedBox(height: spacing4);
  static const SizedBox horizontalGap1 = SizedBox(width: spacing1);
  static const SizedBox horizontalGap2 = SizedBox(width: spacing2);
  static const SizedBox horizontalGap3 = SizedBox(width: spacing3);
  static const SizedBox horizontalGap4 = SizedBox(width: spacing4);

  // Short vertical SizedBox aliases (v = vertical)
  static const SizedBox v1 = SizedBox(height: spacing1);   // 4px
  static const SizedBox v2 = SizedBox(height: spacing2);   // 8px
  static const SizedBox v3 = SizedBox(height: spacing3);   // 12px
  static const SizedBox v4 = SizedBox(height: spacing4);   // 16px
  static const SizedBox v5 = SizedBox(height: spacing5);   // 20px
  static const SizedBox v6 = SizedBox(height: spacing6);   // 24px
  static const SizedBox v8 = SizedBox(height: spacing8);   // 32px
  static const SizedBox v10 = SizedBox(height: spacing10); // 40px
  static const SizedBox v12 = SizedBox(height: spacing12); // 48px
  static const SizedBox v16 = SizedBox(height: spacing16); // 64px
  static const SizedBox v20 = SizedBox(height: spacing20); // 80px
  static const SizedBox v24 = SizedBox(height: spacing24); // 96px

  // Short horizontal SizedBox aliases (h = horizontal)
  static const SizedBox h1 = SizedBox(width: spacing1);   // 4px
  static const SizedBox h2 = SizedBox(width: spacing2);   // 8px
  static const SizedBox h3 = SizedBox(width: spacing3);   // 12px
  static const SizedBox h4 = SizedBox(width: spacing4);   // 16px
  static const SizedBox h5 = SizedBox(width: spacing5);   // 20px
  static const SizedBox h6 = SizedBox(width: spacing6);   // 24px
  static const SizedBox h8 = SizedBox(width: spacing8);   // 32px
  static const SizedBox h10 = SizedBox(width: spacing10); // 40px
  static const SizedBox h12 = SizedBox(width: spacing12); // 48px
  static const SizedBox h16 = SizedBox(width: spacing16); // 64px
  static const SizedBox h20 = SizedBox(width: spacing20); // 80px
  static const SizedBox h24 = SizedBox(width: spacing24); // 96px

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
}
