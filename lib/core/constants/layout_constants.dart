/// Layout constants extracted from Figma designs
/// 
/// This file contains layout-specific constants that match the Figma designs,
/// including dimensions, constraints, and layout-specific values.
library;

import 'package:kikocode/core/design_system/spacing.dart';
import 'package:kikocode/core/design_system/breakpoints.dart';

/// Common component sizes
class ComponentSizes {
  // Button sizes
  static const double buttonHeightSmall = 32.0;
  static const double buttonHeightMedium = 40.0;
  static const double buttonHeightLarge = 48.0;
  
  // Icon sizes
  static const double iconXSmall = 16.0;
  static const double iconSmall = 20.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;
  
  // Avatar sizes
  static const double avatarSmall = 32.0;
  static const double avatarMedium = 40.0;
  static const double avatarLarge = 64.0;
  static const double avatarXLarge = 96.0;
  
  // Input field heights
  static const double inputHeightSmall = 36.0;
  static const double inputHeightMedium = 44.0;
  static const double inputHeightLarge = 52.0;
}

/// Layout constraints from Figma
class LayoutConstraints {
  // Content widths
  static const double maxContentWidth = 1200.0;
  static const double maxFormWidth = 480.0;
  static const double maxCardWidth = 400.0;
  
  // Min heights
  static const double minTouchTarget = 44.0; // iOS HIG recommendation
  static const double minButtonHeight = 44.0;
  
  // Max heights
  static const double maxDialogHeight = 600.0;
  static const double maxBottomSheetHeight = 0.9; // 90% of screen height
  
  // Aspect ratios (width / height)
  static const double aspectRatioSquare = 1.0;
  static const double aspectRatioLandscape = 16.0 / 9.0;
  static const double aspectRatioPortrait = 3.0 / 4.0;
  static const double aspectRatioWide = 21.0 / 9.0;
}

/// Grid system
class GridSystem {
  // Column counts for different breakpoints
  static const int columnsMobile = 4;
  static const int columnsTablet = 8;
  static const int columnsDesktop = 12;
  
  // Gutter sizes (space between columns)
  static double gutterMobile = AppSpacing.spacing4; // 16px
  static double gutterTablet = AppSpacing.spacing6; // 24px
  static double gutterDesktop = AppSpacing.spacing8; // 32px
  
  // Margin sizes (space from screen edges)
  static double marginMobile = AppSpacing.spacing4; // 16px
  static double marginTablet = AppSpacing.spacing6; // 24px
  static double marginDesktop = AppSpacing.spacing8; // 32px
}

/// Navigation dimensions
class NavigationDimensions {
  // Top app bar
  static const double appBarHeight = 56.0;
  static const double appBarHeightLarge = 64.0;
  
  // Bottom navigation bar
  static const double bottomNavHeight = 64.0;
  static const double bottomNavHeightCompact = 56.0;
  
  // Side navigation drawer
  static const double drawerWidth = 280.0;
  static const double drawerWidthExpanded = 320.0;
  
  // Tab bar
  static const double tabBarHeight = 48.0;
}

/// Card dimensions
class CardDimensions {
  // Standard card sizes
  static const double cardMinHeight = 120.0;
  static const double cardMaxHeight = 400.0;
  
  // Specific card types from Figma
  static const double newsCardHeight = 180.0;
  static const double actionCardHeight = 120.0;
  static const double groupCardHeight = 80.0;
}

/// Modal dimensions
class ModalDimensions {
  // Dialog
  static const double dialogMinWidth = 280.0;
  static const double dialogMaxWidth = 560.0;
  static const double dialogBorderRadius = 16.0;
  
  // Bottom sheet
  static const double bottomSheetBorderRadius = 16.0;
  static const double bottomSheetHandleWidth = 40.0;
  static const double bottomSheetHandleHeight = 4.0;
  
  // Snackbar
  static const double snackbarMaxWidth = 600.0;
  static const double snackbarMinHeight = 48.0;
}

/// List item dimensions
class ListItemDimensions {
  static const double listItemMinHeight = 56.0;
  static const double listItemCompactHeight = 48.0;
  static const double listItemLargeHeight = 72.0;
  
  // List tile specific
  static const double listTileAvatarSize = 40.0;
  static const double listTileIconSize = 24.0;
}

/// Border widths
class BorderWidths {
  static const double thin = 1.0;
  static const double medium = 2.0;
  static const double thick = 4.0;
}

/// Divider dimensions
class DividerDimensions {
  static const double thickness = 1.0;
  static const double thickThickness = 2.0;
  static double indent = AppSpacing.spacing4;
}
