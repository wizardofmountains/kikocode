import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tailwind-inspired typography system for Flutter
/// 
/// Provides text styles similar to Tailwind's typography utilities
/// with proper font weights, sizes, and line heights
class AppTypography {
  // Prevent instantiation
  AppTypography._();

  // ============= Font Families =============
  // KIKO uses Nunito and Nunito Sans
  static String get primaryFont => GoogleFonts.nunitoSans().fontFamily!;  // Body text
  static String get displayFont => GoogleFonts.nunito().fontFamily!;      // Headings
  static String get monoFont => GoogleFonts.jetBrainsMono().fontFamily!;  // Code (if needed)

  // ============= Font Weights =============
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // ============= Font Sizes (matching Tailwind's scale) =============
  static const double xs = 12.0;      // text-xs
  static const double sm = 14.0;      // text-sm
  static const double base = 16.0;    // text-base
  static const double lg = 18.0;      // text-lg
  static const double xl = 20.0;      // text-xl
  static const double xl2 = 24.0;     // text-2xl
  static const double xl3 = 30.0;     // text-3xl
  static const double xl4 = 36.0;     // text-4xl
  static const double xl5 = 48.0;     // text-5xl
  static const double xl6 = 60.0;     // text-6xl
  static const double xl7 = 72.0;     // text-7xl
  static const double xl8 = 96.0;     // text-8xl
  static const double xl9 = 128.0;    // text-9xl

  // ============= Line Heights =============
  static const double leadingNone = 1.0;
  static const double leadingTight = 1.25;
  static const double leadingSnug = 1.375;
  static const double leadingNormal = 1.5;
  static const double leadingRelaxed = 1.625;
  static const double leadingLoose = 2.0;

  // ============= Letter Spacing =============
  static const double trackingTighter = -0.05;
  static const double trackingTight = -0.025;
  static const double trackingNormal = 0.0;
  static const double trackingWide = 0.025;
  static const double trackingWider = 0.05;
  static const double trackingWidest = 0.1;

  // ============= Display Styles (for headings/hero text) =============
  static TextStyle get display9 => TextStyle(
        fontFamily: displayFont,
        fontSize: xl9,
        fontWeight: black,
        height: leadingNone,
        letterSpacing: trackingTighter,
      );

  static TextStyle get display8 => TextStyle(
        fontFamily: displayFont,
        fontSize: xl8,
        fontWeight: black,
        height: leadingNone,
        letterSpacing: trackingTighter,
      );

  static TextStyle get display7 => TextStyle(
        fontFamily: displayFont,
        fontSize: xl7,
        fontWeight: extraBold,
        height: leadingNone,
        letterSpacing: trackingTighter,
      );

  static TextStyle get display6 => TextStyle(
        fontFamily: displayFont,
        fontSize: xl6,
        fontWeight: extraBold,
        height: leadingNone,
        letterSpacing: trackingTight,
      );

  static TextStyle get display5 => TextStyle(
        fontFamily: displayFont,
        fontSize: xl5,
        fontWeight: bold,
        height: leadingNone,
        letterSpacing: trackingTight,
      );

  // ============= Heading Styles =============
  static TextStyle get h1 => TextStyle(
        fontFamily: displayFont,
        fontSize: xl4,
        fontWeight: bold,
        height: leadingTight,
        letterSpacing: trackingTight,
      );

  static TextStyle get h2 => TextStyle(
        fontFamily: displayFont,
        fontSize: xl3,
        fontWeight: bold,
        height: leadingTight,
        letterSpacing: trackingTight,
      );

  static TextStyle get h3 => TextStyle(
        fontFamily: displayFont,
        fontSize: xl2,
        fontWeight: semiBold,
        height: leadingSnug,
        letterSpacing: trackingNormal,
      );

  static TextStyle get h4 => TextStyle(
        fontFamily: displayFont,
        fontSize: xl,
        fontWeight: semiBold,
        height: leadingSnug,
        letterSpacing: trackingNormal,
      );

  static TextStyle get h5 => TextStyle(
        fontFamily: displayFont,
        fontSize: lg,
        fontWeight: semiBold,
        height: leadingNormal,
        letterSpacing: trackingNormal,
      );

  static TextStyle get h6 => TextStyle(
        fontFamily: displayFont,
        fontSize: base,
        fontWeight: semiBold,
        height: leadingNormal,
        letterSpacing: trackingNormal,
      );

  // ============= Body Text Styles =============
  static TextStyle get bodyLarge => TextStyle(
        fontFamily: primaryFont,
        fontSize: lg,
        fontWeight: regular,
        height: leadingRelaxed,
        letterSpacing: trackingNormal,
      );

  static TextStyle get bodyBase => TextStyle(
        fontFamily: primaryFont,
        fontSize: base,
        fontWeight: regular,
        height: leadingNormal,
        letterSpacing: trackingNormal,
      );

  static TextStyle get bodySmall => TextStyle(
        fontFamily: primaryFont,
        fontSize: sm,
        fontWeight: regular,
        height: leadingNormal,
        letterSpacing: trackingNormal,
      );

  static TextStyle get bodyXSmall => TextStyle(
        fontFamily: primaryFont,
        fontSize: xs,
        fontWeight: regular,
        height: leadingNormal,
        letterSpacing: trackingWide,
      );

  // ============= Label Styles =============
  static TextStyle get labelLarge => TextStyle(
        fontFamily: primaryFont,
        fontSize: base,
        fontWeight: medium,
        height: leadingNormal,
        letterSpacing: trackingWide,
      );

  static TextStyle get labelBase => TextStyle(
        fontFamily: primaryFont,
        fontSize: sm,
        fontWeight: medium,
        height: leadingNormal,
        letterSpacing: trackingWide,
      );

  static TextStyle get labelSmall => TextStyle(
        fontFamily: primaryFont,
        fontSize: xs,
        fontWeight: medium,
        height: leadingNormal,
        letterSpacing: trackingWider,
      );

  // ============= Button Text Styles =============
  static TextStyle get buttonLarge => TextStyle(
        fontFamily: primaryFont,
        fontSize: lg,
        fontWeight: semiBold,
        height: leadingNone,
        letterSpacing: trackingWide,
      );

  static TextStyle get buttonBase => TextStyle(
        fontFamily: primaryFont,
        fontSize: base,
        fontWeight: semiBold,
        height: leadingNone,
        letterSpacing: trackingWide,
      );

  static TextStyle get buttonSmall => TextStyle(
        fontFamily: primaryFont,
        fontSize: sm,
        fontWeight: semiBold,
        height: leadingNone,
        letterSpacing: trackingWider,
      );

  static TextStyle get buttonXSmall => TextStyle(
        fontFamily: primaryFont,
        fontSize: xs,
        fontWeight: semiBold,
        height: leadingNone,
        letterSpacing: trackingWider,
      );

  // ============= Caption & Overline =============
  static TextStyle get caption => TextStyle(
        fontFamily: primaryFont,
        fontSize: xs,
        fontWeight: regular,
        height: leadingNormal,
        letterSpacing: trackingWide,
      );

  static TextStyle get overline => TextStyle(
        fontFamily: primaryFont,
        fontSize: xs,
        fontWeight: semiBold,
        height: leadingNormal,
        letterSpacing: trackingWidest,
      );

  // ============= Code/Monospace =============
  static TextStyle get codeLarge => TextStyle(
        fontFamily: monoFont,
        fontSize: base,
        fontWeight: regular,
        height: leadingRelaxed,
        letterSpacing: trackingNormal,
      );

  static TextStyle get codeBase => TextStyle(
        fontFamily: monoFont,
        fontSize: sm,
        fontWeight: regular,
        height: leadingRelaxed,
        letterSpacing: trackingNormal,
      );

  static TextStyle get codeSmall => TextStyle(
        fontFamily: monoFont,
        fontSize: xs,
        fontWeight: regular,
        height: leadingRelaxed,
        letterSpacing: trackingNormal,
      );

  // ============= Link =============
  static TextStyle get link => TextStyle(
        fontFamily: primaryFont,
        fontSize: base,
        fontWeight: medium,
        height: leadingNormal,
        letterSpacing: trackingNormal,
        decoration: TextDecoration.underline,
      );

  static TextStyle get linkSmall => TextStyle(
        fontFamily: primaryFont,
        fontSize: sm,
        fontWeight: medium,
        height: leadingNormal,
        letterSpacing: trackingNormal,
        decoration: TextDecoration.underline,
      );

  // ============= KIKO-Specific Styles (from Figma) =============
  
  /// Large Title: Nunito Bold 34px (used for "Hallo!" and "Hallo Anna!")
  static TextStyle get largeTitle => TextStyle(
        fontFamily: displayFont,
        fontSize: 34.0,
        fontWeight: bold,
        height: 1.0,  // 100% line height from Figma
        letterSpacing: 0.0,
      );

  /// Title 2: Nunito Bold 22px (used for "Kommunikation kinderleicht!")
  static TextStyle get title2 => TextStyle(
        fontFamily: displayFont,
        fontSize: 22.0,
        fontWeight: bold,
        height: 1.0,
        letterSpacing: 0.0,
      );

  /// Headline: Nunito Sans Bold 17px (used for button text)
  static TextStyle get headline => TextStyle(
        fontFamily: primaryFont,
        fontSize: 17.0,
        fontWeight: bold,
        height: 1.0,
        letterSpacing: 0.0,
      );

  /// Body: Nunito Sans Regular 17px (used for input fields)
  static TextStyle get body => TextStyle(
        fontFamily: primaryFont,
        fontSize: 17.0,
        fontWeight: regular,
        height: 1.0,
        letterSpacing: 0.0,
      );

  /// Footnote: Nunito Sans Regular 13px (used for "Passwort vergessen?")
  static TextStyle get footnote => TextStyle(
        fontFamily: primaryFont,
        fontSize: 13.0,
        fontWeight: regular,
        height: 1.0,
        letterSpacing: 0.0,
      );

  /// Caption 2: Nunito Sans Regular 11px (used for field labels)
  static TextStyle get caption2 => TextStyle(
        fontFamily: primaryFont,
        fontSize: 11.0,
        fontWeight: regular,
        height: 1.0,
        letterSpacing: 0.0,
      );

  // ============= Helper Methods =============
  
  /// Apply a color to a text style
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Apply a font weight to a text style
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Apply italic to a text style
  static TextStyle italic(TextStyle style) {
    return style.copyWith(fontStyle: FontStyle.italic);
  }

  /// Apply underline to a text style
  static TextStyle underline(TextStyle style) {
    return style.copyWith(decoration: TextDecoration.underline);
  }

  /// Apply line-through to a text style
  static TextStyle lineThrough(TextStyle style) {
    return style.copyWith(decoration: TextDecoration.lineThrough);
  }
}

