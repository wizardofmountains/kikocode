/// Type-safe asset path constants
/// 
/// This file provides type-safe constants for all asset paths in the application.
/// Always use these constants instead of hardcoding asset paths.
library;

/// Image asset paths
class AssetPaths {
  // Base paths
  static const String _images = 'assets/images';
  static const String _vectors = 'assets/vectors';
  static const String _fonts = 'assets/fonts';
  static const String _animations = 'assets/animations';
  
  // ===== LOGOS =====
  
  /// Light version of the KIKO logo
  static const String logoLight = '$_images/LogoLight.svg';
  
  /// Dark version of the KIKO logo (add when available)
  // static const String logoDark = '$_images/logos/logo_dark.svg';
  
  /// Small logo icon only
  // static const String logoIcon = '$_vectors/logos/logo_icon.svg';
  
  // ===== ICONS =====
  
  // Add icon paths as they are added to the project
  // Example:
  // static const String iconHome = '$_vectors/icons/icon_home.svg';
  // static const String iconSettings = '$_vectors/icons/icon_settings.svg';
  // static const String iconProfile = '$_vectors/icons/icon_profile.svg';
  
  // ===== ILLUSTRATIONS =====
  
  // Add illustration paths as they are added
  // Example:
  // static const String illustrationWelcome = '$_vectors/illustrations/welcome.svg';
  // static const String illustrationEmpty = '$_vectors/illustrations/empty_state.svg';
  
  // ===== BACKGROUNDS =====
  
  // Add background paths as they are added
  // Example:
  // static const String bgGradientPurple = '$_images/backgrounds/bg_gradient_purple.png';
  
  // ===== AVATARS =====
  
  // Add avatar paths as they are added
  // Example:
  // static const String avatarPlaceholder = '$_images/avatars/avatar_placeholder.png';
  
  // ===== ANIMATIONS =====
  
  // Add animation paths as they are added
  // Example:
  // static const String animationLoading = '$_animations/loading.json';
  // static const String animationSuccess = '$_animations/success.json';
  // static const String animationError = '$_animations/error.json';
}

/// Font family constants
class FontFamilies {
  // Using Google Fonts - no need for local font files
  // If you add custom fonts, define them here:
  // static const String customFont = 'CustomFont';
}
