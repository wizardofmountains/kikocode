/// Tailwind-inspired Design System for Flutter
/// 
/// A comprehensive design system providing:
/// - Colors: Full Tailwind color palette with semantic naming
/// - Typography: Text styles with proper font hierarchy
/// - Spacing: Consistent spacing scale (4px based)
/// - Borders: Border radius and border utilities
/// - Shadows: Box shadows from subtle to prominent
/// - Breakpoints: Responsive design utilities
/// - Theme: Complete Material 3 theme integration
/// 
/// Usage:
/// ```dart
/// import 'package:kikocode/core/design_system/design_system.dart';
/// 
/// // Use colors
/// Container(color: AppColors.primary)
/// 
/// // Use typography
/// Text('Hello', style: AppTypography.h1)
/// 
/// // Use spacing
/// Padding(padding: AppSpacing.all4)
/// SizedBox(height: AppSpacing.v4)
/// 
/// // Use borders
/// Container(
///   decoration: BoxDecoration(
///     borderRadius: AppBorders.lg,
///     border: AppBorders.all(),
///   ),
/// )
/// 
/// // Use shadows
/// Container(
///   decoration: BoxDecoration(
///     boxShadow: AppShadows.md,
///   ),
/// )
/// 
/// // Responsive design
/// AppBreakpoints.responsive(
///   context,
///   mobile: MobileWidget(),
///   desktop: DesktopWidget(),
/// )
/// ```

library design_system;

// Export all design system modules
export 'colors.dart';
export 'typography.dart';
export 'kiko_typography.dart';
export 'spacing.dart';
export 'borders.dart';
export 'shadows.dart';
export 'breakpoints.dart';
export 'theme.dart';
export 'kiko_components.dart';

