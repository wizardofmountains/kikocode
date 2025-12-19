import 'package:flutter/material.dart';
import 'colors.dart';

/// Tailwind-inspired border system for Flutter
/// 
/// Provides border radius, border widths, and border utilities
/// matching Tailwind's border utilities
class AppBorders {
  // Prevent instantiation
  AppBorders._();

  // ============= Border Radius =============
  static const double radiusNone = 0.0;
  static const double radiusSm = 2.0;      // rounded-sm
  static const double radiusBase = 4.0;    // rounded (default)
  static const double radiusMd = 6.0;      // rounded-md
  static const double radiusLg = 8.0;      // rounded-lg
  static const double radiusXl = 12.0;     // rounded-xl
  static const double radiusXl2 = 16.0;    // rounded-2xl
  static const double radiusXl3 = 24.0;    // rounded-3xl
  static const double radiusFull = 9999.0; // rounded-full (effectively circular)

  // ============= BorderRadius Objects =============
  static const BorderRadius none = BorderRadius.zero;
  static const BorderRadius sm = BorderRadius.all(Radius.circular(radiusSm));
  static const BorderRadius base = BorderRadius.all(Radius.circular(radiusBase));
  static const BorderRadius md = BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius lg = BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius xl = BorderRadius.all(Radius.circular(radiusXl));
  static const BorderRadius xl2 = BorderRadius.all(Radius.circular(radiusXl2));
  static const BorderRadius xl3 = BorderRadius.all(Radius.circular(radiusXl3));
  static const BorderRadius full = BorderRadius.all(Radius.circular(radiusFull));

  // ============= Border Radius - Specific Corners =============
  static BorderRadius topOnly(double radius) => BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      );

  static BorderRadius bottomOnly(double radius) => BorderRadius.only(
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      );

  static BorderRadius leftOnly(double radius) => BorderRadius.only(
        topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
      );

  static BorderRadius rightOnly(double radius) => BorderRadius.only(
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      );

  // Common patterns
  static const BorderRadius topSm = BorderRadius.only(
    topLeft: Radius.circular(radiusSm),
    topRight: Radius.circular(radiusSm),
  );

  static const BorderRadius topMd = BorderRadius.only(
    topLeft: Radius.circular(radiusMd),
    topRight: Radius.circular(radiusMd),
  );

  static const BorderRadius topLg = BorderRadius.only(
    topLeft: Radius.circular(radiusLg),
    topRight: Radius.circular(radiusLg),
  );

  static const BorderRadius topXl = BorderRadius.only(
    topLeft: Radius.circular(radiusXl),
    topRight: Radius.circular(radiusXl),
  );

  static const BorderRadius bottomSm = BorderRadius.only(
    bottomLeft: Radius.circular(radiusSm),
    bottomRight: Radius.circular(radiusSm),
  );

  static const BorderRadius bottomMd = BorderRadius.only(
    bottomLeft: Radius.circular(radiusMd),
    bottomRight: Radius.circular(radiusMd),
  );

  static const BorderRadius bottomLg = BorderRadius.only(
    bottomLeft: Radius.circular(radiusLg),
    bottomRight: Radius.circular(radiusLg),
  );

  static const BorderRadius bottomXl = BorderRadius.only(
    bottomLeft: Radius.circular(radiusXl),
    bottomRight: Radius.circular(radiusXl),
  );

  // ============= Border Widths =============
  static const double widthNone = 0.0;
  static const double widthThin = 1.0;     // border (default)
  static const double width2 = 2.0;        // border-2
  static const double width4 = 4.0;        // border-4
  static const double width8 = 8.0;        // border-8

  // ============= Border Objects =============
  static Border all({
    Color color = AppColors.border,
    double width = widthThin,
    BorderStyle style = BorderStyle.solid,
  }) {
    return Border.all(color: color, width: width, style: style);
  }

  static Border symmetric({
    Color color = AppColors.border,
    double width = widthThin,
    bool vertical = false,
    bool horizontal = false,
  }) {
    return Border(
      top: horizontal
          ? BorderSide(color: color, width: width)
          : BorderSide.none,
      bottom: horizontal
          ? BorderSide(color: color, width: width)
          : BorderSide.none,
      left: vertical
          ? BorderSide(color: color, width: width)
          : BorderSide.none,
      right: vertical
          ? BorderSide(color: color, width: width)
          : BorderSide.none,
    );
  }

  static Border only({
    Color color = AppColors.border,
    double width = widthThin,
    bool top = false,
    bool bottom = false,
    bool left = false,
    bool right = false,
  }) {
    return Border(
      top: top ? BorderSide(color: color, width: width) : BorderSide.none,
      bottom:
          bottom ? BorderSide(color: color, width: width) : BorderSide.none,
      left: left ? BorderSide(color: color, width: width) : BorderSide.none,
      right: right ? BorderSide(color: color, width: width) : BorderSide.none,
    );
  }

  // Common border patterns
  static Border topBorder({
    Color color = AppColors.border,
    double width = widthThin,
  }) {
    return Border(top: BorderSide(color: color, width: width));
  }

  static Border bottomBorder({
    Color color = AppColors.border,
    double width = widthThin,
  }) {
    return Border(bottom: BorderSide(color: color, width: width));
  }

  static Border leftBorder({
    Color color = AppColors.border,
    double width = widthThin,
  }) {
    return Border(left: BorderSide(color: color, width: width));
  }

  static Border rightBorder({
    Color color = AppColors.border,
    double width = widthThin,
  }) {
    return Border(right: BorderSide(color: color, width: width));
  }

  // ============= BorderSide Helpers =============
  static BorderSide side({
    Color color = AppColors.border,
    double width = widthThin,
    BorderStyle style = BorderStyle.solid,
  }) {
    return BorderSide(color: color, width: width, style: style);
  }

  static const BorderSide sideThin = BorderSide(
    color: AppColors.border,
    width: widthThin,
  );

  static const BorderSide side2 = BorderSide(
    color: AppColors.border,
    width: width2,
  );

  static const BorderSide side4 = BorderSide(
    color: AppColors.border,
    width: width4,
  );

  // Note: OutlinedInputBorder fields have been moved to theme.dart due to compilation issues
  // You can access them via the inputDecorationTheme instead

  // ============= Shape Borders =============
  static ShapeBorder shapeBorder({
    BorderRadius? borderRadius,
    BorderSide borderSide = BorderSide.none,
  }) {
    return RoundedRectangleBorder(
      borderRadius: borderRadius ?? base,
      side: borderSide,
    );
  }

  static ShapeBorder circularBorder({
    BorderSide borderSide = BorderSide.none,
  }) {
    return CircleBorder(side: borderSide);
  }

  static ShapeBorder stadiumBorder({
    BorderSide borderSide = BorderSide.none,
  }) {
    return StadiumBorder(side: borderSide);
  }

  // ============= Divider Helpers =============
  static const Divider dividerThin = Divider(
    height: widthThin,
    thickness: widthThin,
    color: AppColors.border,
  );

  static const Divider divider2 = Divider(
    height: width2,
    thickness: width2,
    color: AppColors.border,
  );

  static Divider divider({
    double? height,
    double? thickness,
    Color? color,
    double indent = 0.0,
    double endIndent = 0.0,
  }) {
    return Divider(
      height: height ?? widthThin,
      thickness: thickness ?? widthThin,
      color: color ?? AppColors.border,
      indent: indent,
      endIndent: endIndent,
    );
  }

  static const VerticalDivider verticalDividerThin = VerticalDivider(
    width: widthThin,
    thickness: widthThin,
    color: AppColors.border,
  );

  static const VerticalDivider verticalDivider2 = VerticalDivider(
    width: width2,
    thickness: width2,
    color: AppColors.border,
  );
}

