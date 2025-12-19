import 'package:flutter/material.dart';
import 'colors.dart';

/// Tailwind-inspired shadow system for Flutter
/// 
/// Provides box shadows matching Tailwind's shadow utilities
/// from shadow-sm to shadow-2xl
class AppShadows {
  // Prevent instantiation
  AppShadows._();

  // ============= Shadow Definitions =============
  
  /// No shadow
  static const List<BoxShadow> none = [];

  /// shadow-sm: Subtle shadow for slightly elevated elements
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0D000000), // black with 5% opacity
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  /// shadow: Default shadow for cards and elevated elements
  static const List<BoxShadow> base = [
    BoxShadow(
      color: Color(0x1A000000), // black with 10% opacity
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0D000000), // black with 5% opacity
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: -1,
    ),
  ];

  /// shadow-md: Medium shadow for dropdowns and popovers
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x1A000000), // black with 10% opacity
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x0D000000), // black with 5% opacity
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -2,
    ),
  ];

  /// shadow-lg: Large shadow for modals and overlays
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x1A000000), // black with 10% opacity
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: Color(0x0D000000), // black with 5% opacity
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -4,
    ),
  ];

  /// shadow-xl: Extra large shadow for large modals
  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x19000000), // black with ~10% opacity
      offset: Offset(0, 20),
      blurRadius: 25,
      spreadRadius: -5,
    ),
    BoxShadow(
      color: Color(0x0D000000), // black with 5% opacity
      offset: Offset(0, 8),
      blurRadius: 10,
      spreadRadius: -6,
    ),
  ];

  /// shadow-2xl: Maximum shadow for the highest elevation
  static const List<BoxShadow> xl2 = [
    BoxShadow(
      color: Color(0x19000000), // black with ~10% opacity
      offset: Offset(0, 25),
      blurRadius: 50,
      spreadRadius: -12,
    ),
  ];

  /// shadow-inner: Inner shadow (inset effect)
  static const List<BoxShadow> inner = [
    BoxShadow(
      color: Color(0x0D000000), // black with 5% opacity
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  // ============= Colored Shadows =============

  /// Create a custom colored shadow
  static List<BoxShadow> colored({
    required Color color,
    double opacity = 0.5,
    Offset offset = const Offset(0, 4),
    double blurRadius = 6,
    double spreadRadius = 0,
  }) {
    return [
      BoxShadow(
        color: color.withOpacity(opacity),
        offset: offset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
    ];
  }

  /// Primary colored shadow (purple)
  static List<BoxShadow> get primarySm => colored(
        color: AppColors.primary,
        opacity: 0.2,
        offset: const Offset(0, 2),
        blurRadius: 4,
      );

  static List<BoxShadow> get primary => colored(
        color: AppColors.primary,
        opacity: 0.3,
        offset: const Offset(0, 4),
        blurRadius: 8,
      );

  static List<BoxShadow> get primaryLg => colored(
        color: AppColors.primary,
        opacity: 0.4,
        offset: const Offset(0, 8),
        blurRadius: 16,
      );

  /// Success colored shadow (green)
  static List<BoxShadow> get successSm => colored(
        color: AppColors.success,
        opacity: 0.2,
        offset: const Offset(0, 2),
        blurRadius: 4,
      );

  static List<BoxShadow> get success => colored(
        color: AppColors.success,
        opacity: 0.3,
        offset: const Offset(0, 4),
        blurRadius: 8,
      );

  /// Warning colored shadow (amber)
  static List<BoxShadow> get warningSm => colored(
        color: AppColors.warning,
        opacity: 0.2,
        offset: const Offset(0, 2),
        blurRadius: 4,
      );

  static List<BoxShadow> get warning => colored(
        color: AppColors.warning,
        opacity: 0.3,
        offset: const Offset(0, 4),
        blurRadius: 8,
      );

  /// Error colored shadow (red)
  static List<BoxShadow> get errorSm => colored(
        color: AppColors.error,
        opacity: 0.2,
        offset: const Offset(0, 2),
        blurRadius: 4,
      );

  static List<BoxShadow> get error => colored(
        color: AppColors.error,
        opacity: 0.3,
        offset: const Offset(0, 4),
        blurRadius: 8,
      );

  // ============= Elevation Helpers =============
  
  /// Get shadow by elevation level (Material Design style)
  /// Level 0-5 maps to different shadow intensities
  static List<BoxShadow> byElevation(int level) {
    switch (level) {
      case 0:
        return none;
      case 1:
        return sm;
      case 2:
        return base;
      case 3:
        return md;
      case 4:
        return lg;
      case 5:
        return xl;
      case 6:
        return xl2;
      default:
        return base;
    }
  }

  // ============= Drop Shadow (for images/widgets) =============
  
  /// Create a custom drop shadow filter
  static BoxShadow dropShadow({
    Color color = Colors.black,
    double opacity = 0.25,
    Offset offset = const Offset(0, 4),
    double blurRadius = 4,
  }) {
    return BoxShadow(
      color: color.withOpacity(opacity),
      offset: offset,
      blurRadius: blurRadius,
    );
  }

  static BoxShadow get dropShadowSm => dropShadow(
        opacity: 0.1,
        offset: const Offset(0, 1),
        blurRadius: 2,
      );

  static BoxShadow get dropShadowBase => dropShadow(
        opacity: 0.15,
        offset: const Offset(0, 2),
        blurRadius: 4,
      );

  static BoxShadow get dropShadowMd => dropShadow(
        opacity: 0.2,
        offset: const Offset(0, 4),
        blurRadius: 8,
      );

  static BoxShadow get dropShadowLg => dropShadow(
        opacity: 0.25,
        offset: const Offset(0, 8),
        blurRadius: 16,
      );

  static BoxShadow get dropShadowXl => dropShadow(
        opacity: 0.3,
        offset: const Offset(0, 12),
        blurRadius: 24,
      );
}

