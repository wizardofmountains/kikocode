import 'package:flutter/widgets.dart';

/// Tailwind-inspired spacing system for Flutter
/// 
/// Provides consistent spacing values matching Tailwind's spacing scale
/// where each step is 4px (0.25rem)
class AppSpacing {
  // Prevent instantiation
  AppSpacing._();

  // ============= Spacing Scale (in pixels) =============
  static const double px = 1.0;           // 1px
  static const double spacing0 = 0.0;     // 0
  static const double spacing0_5 = 2.0;   // 0.5 = 2px
  static const double spacing1 = 4.0;     // 1 = 4px
  static const double spacing1_5 = 6.0;   // 1.5 = 6px
  static const double spacing2 = 8.0;     // 2 = 8px
  static const double spacing2_5 = 10.0;  // 2.5 = 10px
  static const double spacing3 = 12.0;    // 3 = 12px
  static const double spacing3_5 = 14.0;  // 3.5 = 14px
  static const double spacing4 = 16.0;    // 4 = 16px
  static const double spacing5 = 20.0;    // 5 = 20px
  static const double spacing6 = 24.0;    // 6 = 24px
  static const double spacing7 = 28.0;    // 7 = 28px
  static const double spacing8 = 32.0;    // 8 = 32px
  static const double spacing9 = 36.0;    // 9 = 36px
  static const double spacing10 = 40.0;   // 10 = 40px
  static const double spacing11 = 44.0;   // 11 = 44px
  static const double spacing12 = 48.0;   // 12 = 48px
  static const double spacing14 = 56.0;   // 14 = 56px
  static const double spacing16 = 64.0;   // 16 = 64px
  static const double spacing20 = 80.0;   // 20 = 80px
  static const double spacing24 = 96.0;   // 24 = 96px
  static const double spacing28 = 112.0;  // 28 = 112px
  static const double spacing32 = 128.0;  // 32 = 128px
  static const double spacing36 = 144.0;  // 36 = 144px
  static const double spacing40 = 160.0;  // 40 = 160px
  static const double spacing44 = 176.0;  // 44 = 176px
  static const double spacing48 = 192.0;  // 48 = 192px
  static const double spacing52 = 208.0;  // 52 = 208px
  static const double spacing56 = 224.0;  // 56 = 224px
  static const double spacing60 = 240.0;  // 60 = 240px
  static const double spacing64 = 256.0;  // 64 = 256px
  static const double spacing72 = 288.0;  // 72 = 288px
  static const double spacing80 = 320.0;  // 80 = 320px
  static const double spacing96 = 384.0;  // 96 = 384px

  // ============= Semantic Aliases =============
  static const double xxs = spacing1;     // 4px
  static const double xs = spacing2;      // 8px
  static const double sm = spacing3;      // 12px
  static const double md = spacing4;      // 16px
  static const double lg = spacing6;      // 24px
  static const double xl = spacing8;      // 32px
  static const double xl2 = spacing10;    // 40px
  static const double xl3 = spacing12;    // 48px
  static const double xl4 = spacing16;    // 64px
  static const double xl5 = spacing20;    // 80px
  static const double xl6 = spacing24;    // 96px

  // ============= Common Use Cases =============
  static const double buttonPaddingVertical = spacing3;      // 12px
  static const double buttonPaddingHorizontal = spacing6;    // 24px
  static const double buttonSpacing = spacing4;              // 16px
  
  static const double inputPaddingVertical = spacing3;       // 12px
  static const double inputPaddingHorizontal = spacing4;     // 16px
  static const double inputSpacing = spacing4;               // 16px

  static const double cardPadding = spacing6;                // 24px
  static const double cardSpacing = spacing4;                // 16px

  static const double sectionSpacing = spacing8;             // 32px
  static const double sectionPadding = spacing6;             // 24px

  static const double screenPadding = spacing4;              // 16px
  static const double screenPaddingLarge = spacing6;         // 24px

  // ============= EdgeInsets Helpers =============
  
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
  static const EdgeInsets h4v0 = EdgeInsets.symmetric(horizontal: spacing4);
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
  
  // Horizontal spacing
  static const SizedBox hPx = SizedBox(width: px);
  static const SizedBox h1 = SizedBox(width: spacing1);
  static const SizedBox h2 = SizedBox(width: spacing2);
  static const SizedBox h3 = SizedBox(width: spacing3);
  static const SizedBox h4 = SizedBox(width: spacing4);
  static const SizedBox h5 = SizedBox(width: spacing5);
  static const SizedBox h6 = SizedBox(width: spacing6);
  static const SizedBox h8 = SizedBox(width: spacing8);
  static const SizedBox h10 = SizedBox(width: spacing10);
  static const SizedBox h12 = SizedBox(width: spacing12);
  static const SizedBox h16 = SizedBox(width: spacing16);
  static const SizedBox h20 = SizedBox(width: spacing20);
  static const SizedBox h24 = SizedBox(width: spacing24);

  // Vertical spacing
  static const SizedBox vPx = SizedBox(height: px);
  static const SizedBox v1 = SizedBox(height: spacing1);
  static const SizedBox v2 = SizedBox(height: spacing2);
  static const SizedBox v3 = SizedBox(height: spacing3);
  static const SizedBox v4 = SizedBox(height: spacing4);
  static const SizedBox v5 = SizedBox(height: spacing5);
  static const SizedBox v6 = SizedBox(height: spacing6);
  static const SizedBox v8 = SizedBox(height: spacing8);
  static const SizedBox v10 = SizedBox(height: spacing10);
  static const SizedBox v12 = SizedBox(height: spacing12);
  static const SizedBox v16 = SizedBox(height: spacing16);
  static const SizedBox v20 = SizedBox(height: spacing20);
  static const SizedBox v24 = SizedBox(height: spacing24);

  // Custom sized boxes
  static SizedBox width(double value) => SizedBox(width: value);
  static SizedBox height(double value) => SizedBox(height: value);
  static SizedBox square(double value) => SizedBox(width: value, height: value);

  // ============= Gap (for Flex widgets) =============
  // Note: Requires the 'gap' parameter in Row/Column (Flutter 3.10+)
  
  static const double gap1 = spacing1;
  static const double gap2 = spacing2;
  static const double gap3 = spacing3;
  static const double gap4 = spacing4;
  static const double gap5 = spacing5;
  static const double gap6 = spacing6;
  static const double gap8 = spacing8;
  static const double gap10 = spacing10;
  static const double gap12 = spacing12;
  static const double gap16 = spacing16;
  static const double gap20 = spacing20;
  static const double gap24 = spacing24;
}

