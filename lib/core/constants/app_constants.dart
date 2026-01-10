/// Application-wide constants
/// 
/// This file contains constant values used throughout the application.
library;

/// App information
class AppInfo {
  static const String appName = 'KIKO';
  static const String appFullName = 'KIKO - Kommunikation kinderleicht!';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
}

/// Feature flags
class FeatureFlags {
  static const bool enableDarkMode = true;
  static const bool enableAnimations = true;
  static const bool enableDebugOverlay = true;
  static const bool enableAnalytics = false;
}

/// Timing constants
class Timings {
  // Animation durations in milliseconds
  static const int animationFast = 150;
  static const int animationNormal = 300;
  static const int animationSlow = 500;
  
  // Timeouts
  static const int networkTimeout = 30000; // 30 seconds
  static const int debounceDelay = 300;
  static const int splashScreenDuration = 2000;
}

/// Z-index layers for stacking
class ZIndex {
  static const int background = 0;
  static const int content = 1;
  static const int overlay = 2;
  static const int dropdown = 3;
  static const int modal = 4;
  static const int tooltip = 5;
  static const int toast = 6;
}

/// Pagination constants
class Pagination {
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}

/// Validation constants
class Validation {
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;
  static const int maxMessageLength = 1000;
}
