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
  static const String logoLight = '$_vectors/logos/logo_light.svg';
  
  /// Dark version of the KIKO logo (add when available)
  // static const String logoDark = '$_vectors/logos/logo_dark.svg';
  
  /// Small logo icon only
  // static const String logoIcon = '$_vectors/logos/logo_icon.svg';
  
  // ===== ICONS =====
  
  /// Face ID authentication icon
  static const String iconFaceId = '$_vectors/icons/face_id_symbol.svg';
  
  /// Checkmark circle icon (success indicator)
  static const String iconCheckmarkCircle = '$_vectors/icons/checkmark_circle.svg';
  
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

  /// Base path for avatar images
  static const String _avatars = '$_images/avatars';

  /// Predefined animal avatars
  static const String avatarBear = '$_avatars/avatar_bear.png';
  static const String avatarBunny = '$_avatars/avatar_bunny.png';
  static const String avatarCat = '$_avatars/avatar_cat.png';
  static const String avatarDog = '$_avatars/avatar_dog.png';
  static const String avatarElephant = '$_avatars/avatar_elephant.png';
  static const String avatarFox = '$_avatars/avatar_fox.png';
  static const String avatarGiraffe = '$_avatars/avatar_giraffe.png';
  static const String avatarKoala = '$_avatars/avatar_koala.png';
  static const String avatarLion = '$_avatars/avatar_lion.png';
  static const String avatarOwl = '$_avatars/avatar_owl.png';
  static const String avatarPanda = '$_avatars/avatar_panda.png';
  static const String avatarPenguin = '$_avatars/avatar_penguin.png';

  /// List of all predefined avatars for avatar picker
  static const List<String> predefinedAvatars = [
    avatarBear,
    avatarBunny,
    avatarCat,
    avatarDog,
    avatarElephant,
    avatarFox,
    avatarGiraffe,
    avatarKoala,
    avatarLion,
    avatarOwl,
    avatarPanda,
    avatarPenguin,
  ];
  
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
