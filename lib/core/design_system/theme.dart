import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'typography.dart';
import 'kiko_typography.dart';
import 'spacing.dart';
import 'borders.dart';
import 'shadows.dart';

/// Main theme configuration integrating the design system
class AppTheme {
  // Prevent instantiation
  AppTheme._();

  // ============= Light Theme =============
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryKiko,
        onPrimary: AppColors.surfaceHigh,
        primaryContainer: AppColors.primaryLightKiko,
        onPrimaryContainer: AppColors.primaryKiko,
        secondary: AppColors.secondaryKiko,
        onSecondary: AppColors.textPrimaryKiko,
        secondaryContainer: AppColors.secondaryLightKiko,
        onSecondaryContainer: AppColors.textPrimaryKiko,
        tertiary: AppColors.primaryLightKiko,
        onTertiary: AppColors.primaryKiko,
        tertiaryContainer: AppColors.surfaceHigh,
        onTertiaryContainer: AppColors.textPrimaryKiko,
        error: AppColors.error,
        onError: AppColors.white,
        errorContainer: AppColors.red100,
        onErrorContainer: AppColors.red900,
        surface: AppColors.surfaceHighest,
        onSurface: AppColors.textPrimaryKiko,
        surfaceContainerHighest: AppColors.surfaceHigh,
        outline: AppColors.surfaceLow,
        outlineVariant: AppColors.surfaceLow,
        shadow: AppColors.black,
        scrim: AppColors.black,
        inverseSurface: AppColors.textPrimaryKiko,
        onInverseSurface: AppColors.surfaceHighest,
        inversePrimary: AppColors.primaryLightKiko,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.surfaceBase,

      // App Bar
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.surfaceHighest,
        foregroundColor: AppColors.textPrimaryKiko,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: KikoTypography.appHeadline.copyWith(
          color: AppColors.textPrimaryKiko,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.textPrimaryKiko,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      // Card
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.surfaceHighest,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          side: const BorderSide(
            color: AppColors.surfaceLow,
            width: 2,
          ),
        ),
        margin: AppSpacing.all4,
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.surfaceHigh,
          backgroundColor: AppColors.primaryKiko,
          disabledForegroundColor: AppColors.surfaceHigh,
          disabledBackgroundColor: AppColors.primaryLightKiko,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: AppSpacing.symmetric(
            horizontal: AppSpacing.buttonPaddingHorizontal,
            vertical: AppSpacing.buttonPaddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.tabBarItemRadius),
            side: const BorderSide(
              color: AppColors.primaryLightKiko,
              width: 2,
            ),
          ),
          textStyle: KikoTypography.appHeadline,
          minimumSize: const Size(64, 50),
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryKiko,
          disabledForegroundColor: AppColors.captionKiko,
          padding: AppSpacing.symmetric(
            horizontal: AppSpacing.buttonPaddingHorizontal,
            vertical: AppSpacing.buttonPaddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.tabBarItemRadius),
          ),
          textStyle: KikoTypography.appHeadline,
          minimumSize: const Size(64, 50),
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryKiko,
          disabledForegroundColor: AppColors.captionKiko,
          side: const BorderSide(
            color: AppColors.primaryLightKiko,
            width: 2,
          ),
          padding: AppSpacing.symmetric(
            horizontal: AppSpacing.buttonPaddingHorizontal,
            vertical: AppSpacing.buttonPaddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.tabBarItemRadius),
          ),
          textStyle: KikoTypography.appHeadline,
          minimumSize: const Size(64, 50),
        ),
      ),

      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryKiko,
        foregroundColor: AppColors.surfaceHigh,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
          side: const BorderSide(
            color: AppColors.primaryLightKiko,
            width: 2,
          ),
        ),
      ),

      // Input Decoration  
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceHighest,
        contentPadding: AppSpacing.symmetric(
          horizontal: AppSpacing.inputPaddingHorizontal,
          vertical: AppSpacing.inputPaddingVertical,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
          borderSide: const BorderSide(color: AppColors.surfaceLow, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
          borderSide: const BorderSide(color: AppColors.surfaceLow, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
          borderSide: const BorderSide(color: AppColors.secondaryKiko, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: KikoTypography.appBody.copyWith(
          color: AppColors.captionKiko,
        ),
        hintStyle: KikoTypography.appBody.copyWith(
          color: AppColors.captionKiko,
        ),
        errorStyle: KikoTypography.appFootnote.copyWith(
          color: AppColors.error,
        ),
        prefixIconColor: AppColors.textPrimaryKiko,
        suffixIconColor: AppColors.textPrimaryKiko,
      ),

      // Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.gray300;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.surface;
        }),
        checkColor: WidgetStateProperty.all(AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: AppBorders.base,
        ),
      ),

      // Radio
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.gray300;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.textSecondary;
        }),
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.gray300;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.gray400;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.gray200;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight.withOpacity(0.5);
          }
          return AppColors.gray300;
        }),
      ),

      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.gray300,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withOpacity(0.2),
        valueIndicatorColor: AppColors.primary,
        valueIndicatorTextStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.white,
        ),
      ),

      // Progress Indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.gray200,
        circularTrackColor: AppColors.gray200,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        elevation: 8,
        shadowColor: AppColors.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: AppBorders.xl2,
        ),
        titleTextStyle: AppTypography.h4.copyWith(
          color: AppColors.textPrimary,
        ),
        contentTextStyle: AppTypography.bodyBase.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // Bottom Sheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppBorders.radiusXl2),
          ),
        ),
        showDragHandle: true,
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.gray800,
        contentTextStyle: AppTypography.bodyBase.copyWith(
          color: AppColors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppBorders.lg,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.gray100,
        deleteIconColor: AppColors.textSecondary,
        disabledColor: AppColors.gray200,
        selectedColor: AppColors.primaryLight.withOpacity(0.2),
        secondarySelectedColor: AppColors.secondaryLight.withOpacity(0.2),
        labelPadding: AppSpacing.h4v0,
        padding: AppSpacing.symmetric(
          horizontal: AppSpacing.spacing3,
          vertical: AppSpacing.spacing2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppBorders.lg,
        ),
        labelStyle: AppTypography.labelBase.copyWith(
          color: AppColors.textPrimary,
        ),
        secondaryLabelStyle: AppTypography.labelBase.copyWith(
          color: AppColors.textPrimary,
        ),
        brightness: Brightness.light,
        side: const BorderSide(
          color: AppColors.border,
          width: AppBorders.widthThin,
        ),
      ),

      // Tooltip
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.gray800,
          borderRadius: AppBorders.base,
        ),
        textStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.white,
        ),
        padding: AppSpacing.symmetric(
          horizontal: AppSpacing.spacing3,
          vertical: AppSpacing.spacing2,
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.surfaceLow,
        thickness: 2,
        space: AppSpacing.spacing4,
      ),

      // List Tile
      listTileTheme: ListTileThemeData(
        contentPadding: AppSpacing.h4v0,
        minLeadingWidth: 40,
        iconColor: AppColors.textPrimaryKiko,
        textColor: AppColors.textPrimaryKiko,
        titleTextStyle: KikoTypography.appBody.copyWith(
          color: AppColors.textPrimaryKiko,
        ),
        subtitleTextStyle: KikoTypography.appFootnote.copyWith(
          color: AppColors.captionKiko,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
      ),

      // Icon
      iconTheme: const IconThemeData(
        color: AppColors.textPrimaryKiko,
        size: 24,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: KikoTypography.appTitle1.copyWith(
          color: AppColors.textPrimaryKiko,
        ),
        displayMedium: KikoTypography.appTitle1.copyWith(
          color: AppColors.textPrimaryKiko,
        ),
        displaySmall: KikoTypography.appHeadline.copyWith(
          color: AppColors.textPrimaryKiko,
        ),
        headlineLarge: KikoTypography.appHeadline.copyWith(
          color: AppColors.textPrimaryKiko,
        ),
        headlineMedium: KikoTypography.appHeadline.copyWith(
          color: AppColors.textPrimaryKiko,
        ),
        headlineSmall: KikoTypography.appHeadline.copyWith(
          color: AppColors.textPrimaryKiko,
        ),
        titleLarge: KikoTypography.appHeadline.copyWith(
          color: AppColors.textPrimaryKiko,
        ),
        titleMedium: KikoTypography.appBody.copyWith(
          color: AppColors.textPrimaryKiko,
        ),
        titleSmall: KikoTypography.appFootnote.copyWith(
          color: AppColors.captionKiko,
        ),
        bodyLarge: KikoTypography.appBody.copyWith(
          color: AppColors.textPrimaryKiko,
        ),
        bodyMedium: KikoTypography.appBody.copyWith(
          color: AppColors.textPrimaryKiko,
        ),
        bodySmall: KikoTypography.appFootnote.copyWith(
          color: AppColors.captionKiko,
        ),
        labelLarge: KikoTypography.appHeadline.copyWith(
          color: AppColors.textPrimaryKiko,
        ),
        labelMedium: KikoTypography.appFootnote.copyWith(
          color: AppColors.captionKiko,
        ),
        labelSmall: KikoTypography.appCaption2.copyWith(
          color: AppColors.captionKiko,
        ),
      ),
    );
  }

  // ============= Dark Theme =============
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: ColorScheme.dark(
        primary: AppColors.purple400,
        onPrimary: AppColors.purple900,
        primaryContainer: AppColors.purple800,
        onPrimaryContainer: AppColors.purple100,
        
        secondary: AppColors.indigo400,
        onSecondary: AppColors.indigo900,
        secondaryContainer: AppColors.indigo800,
        onSecondaryContainer: AppColors.indigo100,
        
        tertiary: AppColors.pink400,
        onTertiary: AppColors.pink900,
        tertiaryContainer: AppColors.pink800,
        onTertiaryContainer: AppColors.pink100,
        
        error: AppColors.red400,
        onError: AppColors.red900,
        errorContainer: AppColors.red800,
        onErrorContainer: AppColors.red100,
        
        surface: AppColors.gray900,
        onSurface: AppColors.gray100,
        surfaceContainerHighest: AppColors.gray800,
        
        outline: AppColors.gray700,
        outlineVariant: AppColors.gray800,
        
        shadow: AppColors.black,
        scrim: AppColors.black,
        
        inverseSurface: AppColors.gray100,
        onInverseSurface: AppColors.gray900,
        inversePrimary: AppColors.purple600,
      ),

      scaffoldBackgroundColor: AppColors.gray950,

      // Text Theme for Dark Mode
      textTheme: TextTheme(
        displayLarge: AppTypography.display5.copyWith(
          color: AppColors.gray100,
        ),
        displayMedium: AppTypography.display6.copyWith(
          color: AppColors.gray100,
        ),
        displaySmall: AppTypography.h1.copyWith(
          color: AppColors.gray100,
        ),
        headlineLarge: AppTypography.h2.copyWith(
          color: AppColors.gray100,
        ),
        headlineMedium: AppTypography.h3.copyWith(
          color: AppColors.gray100,
        ),
        headlineSmall: AppTypography.h4.copyWith(
          color: AppColors.gray100,
        ),
        titleLarge: AppTypography.h5.copyWith(
          color: AppColors.gray100,
        ),
        titleMedium: AppTypography.h6.copyWith(
          color: AppColors.gray100,
        ),
        titleSmall: AppTypography.labelLarge.copyWith(
          color: AppColors.gray100,
        ),
        bodyLarge: AppTypography.bodyLarge.copyWith(
          color: AppColors.gray200,
        ),
        bodyMedium: AppTypography.bodyBase.copyWith(
          color: AppColors.gray200,
        ),
        bodySmall: AppTypography.bodySmall.copyWith(
          color: AppColors.gray400,
        ),
        labelLarge: AppTypography.labelLarge.copyWith(
          color: AppColors.gray200,
        ),
        labelMedium: AppTypography.labelBase.copyWith(
          color: AppColors.gray200,
        ),
        labelSmall: AppTypography.labelSmall.copyWith(
          color: AppColors.gray400,
        ),
      ),
    );
  }
}

