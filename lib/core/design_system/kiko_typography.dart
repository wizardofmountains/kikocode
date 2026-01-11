import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Kiko-specific typography system based on Figma design
/// Uses Nunito and Nunito Sans fonts
class KikoTypography {
  // Prevent instantiation
  KikoTypography._();

  // ============= Font Families =============
  static String get nunito => GoogleFonts.nunito().fontFamily!;
  static String get nunitoSans => GoogleFonts.nunitoSans().fontFamily!;

  // ============= App/Title 1 - Nunito Bold, 28px =============
  static TextStyle get appTitle1 => TextStyle(
        fontFamily: nunito,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        height: 1.0, // lineHeight: 100% in Figma
        letterSpacing: 0,
      );

  // ============= App/Headline - Nunito Sans Bold, 17px =============
  static TextStyle get appHeadline => TextStyle(
        fontFamily: nunitoSans,
        fontSize: 17.0,
        fontWeight: FontWeight.w700,
        height: 1.29, // lineHeight: 129% in Figma
        letterSpacing: 0,
      );

  // ============= App/Body - Nunito Sans Regular, 17px =============
  static TextStyle get appBody => TextStyle(
        fontFamily: nunitoSans,
        fontSize: 17.0,
        fontWeight: FontWeight.w400,
        height: 1.33, // lineHeight: 133% in Figma
        letterSpacing: 0,
      );

  // ============= App/Footnote - Nunito Sans Regular, 13px =============
  static TextStyle get appFootnote => TextStyle(
        fontFamily: nunitoSans,
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        height: 1.38, // lineHeight: 138% in Figma
        letterSpacing: 0,
      );

  // ============= App/Caption 2 - Nunito Sans Regular, 11px =============
  static TextStyle get appCaption2 => TextStyle(
        fontFamily: nunitoSans,
        fontSize: 11.0,
        fontWeight: FontWeight.w400,
        height: 1.2, // lineHeight: 120% in Figma
        letterSpacing: 0,
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
}
