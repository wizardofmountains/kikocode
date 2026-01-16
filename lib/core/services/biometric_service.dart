import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:shared_preferences/shared_preferences.dart';

/// Error types for biometric authentication
enum BiometricError {
  /// Biometrics not available on this device
  notAvailable,
  /// No biometrics enrolled on this device
  notEnrolled,
  /// Too many failed attempts - temporarily locked
  lockedOut,
  /// Permanently locked out - requires device passcode
  permanentlyLocked,
  /// User cancelled the authentication
  cancelled,
  /// Biometrics have changed since setup (security concern)
  biometricsChanged,
  /// Unknown error occurred
  unknown,
}

/// Result of biometric authentication
class BiometricResult {
  final bool success;
  final BiometricError? error;
  final String? errorMessage;

  const BiometricResult._({
    required this.success,
    this.error,
    this.errorMessage,
  });

  factory BiometricResult.success() => const BiometricResult._(success: true);

  factory BiometricResult.failure(BiometricError error, [String? message]) =>
      BiometricResult._(success: false, error: error, errorMessage: message);

  bool get isSuccess => success;
  bool get isFailure => !success;
  bool get isCancelled => error == BiometricError.cancelled;
  bool get isLockedOut =>
      error == BiometricError.lockedOut ||
      error == BiometricError.permanentlyLocked;
}

/// Service for handling biometric authentication (Face ID / Touch ID)
class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  static const String _biometricEnabledKey = 'biometric_enabled';
  static const String _biometricHashKey = 'biometric_hash';

  /// Check if biometric authentication is available on this device
  Future<bool> isBiometricAvailable() async {
    try {
      final bool canAuthenticateWithBiometrics =
          await _localAuth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();
      return canAuthenticate;
    } on PlatformException catch (e) {
      debugPrint('BiometricService: Error checking biometric availability: $e');
      return false;
    }
  }

  /// Check if biometrics are enrolled (not just available on device)
  Future<bool> hasBiometricsEnrolled() async {
    final biometrics = await getAvailableBiometrics();
    return biometrics.isNotEmpty;
  }

  /// Get the list of available biometric types on this device
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      debugPrint('BiometricService: Error getting available biometrics: $e');
      return [];
    }
  }

  /// Check if Face ID is available (iOS specific)
  Future<bool> isFaceIdAvailable() async {
    final biometrics = await getAvailableBiometrics();
    return biometrics.contains(BiometricType.face);
  }

  /// Check if Touch ID / Fingerprint is available
  Future<bool> isTouchIdAvailable() async {
    final biometrics = await getAvailableBiometrics();
    return biometrics.contains(BiometricType.fingerprint);
  }

  /// Authenticate using biometrics
  ///
  /// [localizedReason] - The message shown to the user
  /// [allowDeviceCredential] - If true, allows PIN/password fallback when biometric fails
  ///
  /// Returns a [BiometricResult] with success status and error information
  Future<BiometricResult> authenticate({
    String localizedReason = 'Bitte authentifizieren Sie sich, um fortzufahren',
    bool allowDeviceCredential = false,
  }) async {
    try {
      // Check if biometrics are available
      if (!await isBiometricAvailable()) {
        return BiometricResult.failure(
          BiometricError.notAvailable,
          'Biometrische Authentifizierung ist auf diesem Gerät nicht verfügbar.',
        );
      }

      // Check if biometrics are enrolled
      if (!await hasBiometricsEnrolled()) {
        return BiometricResult.failure(
          BiometricError.notEnrolled,
          'Keine biometrischen Daten eingerichtet. Bitte richten Sie Face ID oder Touch ID in den Geräteeinstellungen ein.',
        );
      }

      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: localizedReason,
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: !allowDeviceCredential,
        ),
      );

      if (didAuthenticate) {
        return BiometricResult.success();
      } else {
        return BiometricResult.failure(
          BiometricError.cancelled,
          'Authentifizierung abgebrochen.',
        );
      }
    } on PlatformException catch (e) {
      debugPrint('BiometricService: Authentication error: $e');
      return _handlePlatformException(e);
    }
  }

  /// Handle platform-specific exceptions and return appropriate error
  BiometricResult _handlePlatformException(PlatformException e) {
    switch (e.code) {
      case auth_error.notAvailable:
        return BiometricResult.failure(
          BiometricError.notAvailable,
          'Biometrische Authentifizierung nicht verfügbar.',
        );
      case auth_error.notEnrolled:
        return BiometricResult.failure(
          BiometricError.notEnrolled,
          'Keine biometrischen Daten eingerichtet.',
        );
      case auth_error.lockedOut:
        return BiometricResult.failure(
          BiometricError.lockedOut,
          'Zu viele fehlgeschlagene Versuche. Bitte versuchen Sie es später erneut.',
        );
      case auth_error.permanentlyLockedOut:
        return BiometricResult.failure(
          BiometricError.permanentlyLocked,
          'Biometrie gesperrt. Bitte entsperren Sie Ihr Gerät mit Ihrem Passcode.',
        );
      case auth_error.passcodeNotSet:
        return BiometricResult.failure(
          BiometricError.notAvailable,
          'Kein Gerätecode eingerichtet.',
        );
      default:
        return BiometricResult.failure(
          BiometricError.unknown,
          e.message ?? 'Ein unbekannter Fehler ist aufgetreten.',
        );
    }
  }

  /// Legacy authenticate method for backward compatibility
  /// Returns true if authentication was successful, false otherwise
  @Deprecated('Use authenticate() which returns BiometricResult for better error handling')
  Future<bool> authenticateLegacy({
    String localizedReason = 'Bitte authentifizieren Sie sich, um fortzufahren',
  }) async {
    final result = await authenticate(localizedReason: localizedReason);
    return result.success;
  }

  /// Check if the user has enabled biometric authentication in the app
  Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricEnabledKey) ?? false;
  }

  /// Enable or disable biometric authentication for the app
  /// When enabling, stores a hash of current biometrics for change detection
  Future<void> setBiometricEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, enabled);

    if (enabled) {
      // Store biometric hash for change detection
      await _storeBiometricHash();
    } else {
      // Clear the hash when disabling
      await prefs.remove(_biometricHashKey);
    }
  }

  /// Get a human-readable name for the available biometric type
  Future<String> getBiometricTypeName() async {
    if (await isFaceIdAvailable()) {
      return 'Face ID';
    } else if (await isTouchIdAvailable()) {
      return 'Touch ID';
    }
    return 'Biometrie';
  }

  // ============================================================================
  // Biometric Change Detection (Security Feature)
  // ============================================================================

  /// Store a hash of the current biometric configuration
  /// This is used to detect if biometrics have changed since setup
  Future<void> _storeBiometricHash() async {
    final prefs = await SharedPreferences.getInstance();
    final hash = await _computeBiometricHash();
    await prefs.setString(_biometricHashKey, hash);
  }

  /// Compute a hash of the current biometric configuration
  /// Note: This uses available biometric types, not actual fingerprint/face data
  /// The local_auth package doesn't provide access to actual biometric identifiers
  Future<String> _computeBiometricHash() async {
    final biometrics = await getAvailableBiometrics();
    // Sort to ensure consistent ordering
    final biometricStrings = biometrics.map((b) => b.toString()).toList()..sort();
    final dataToHash = biometricStrings.join(',');
    final hash = sha256.convert(utf8.encode(dataToHash));
    return hash.toString();
  }

  /// Check if biometrics have changed since the app was set up
  /// Returns true if biometrics appear to have changed (potential security concern)
  ///
  /// Note: Due to platform limitations, this only detects if biometric TYPES
  /// have changed (e.g., fingerprint was available but now only face is).
  /// It cannot detect if a new fingerprint was added to the same type.
  Future<bool> haveBiometricsChanged() async {
    final prefs = await SharedPreferences.getInstance();
    final storedHash = prefs.getString(_biometricHashKey);

    // If no hash stored, biometrics were never set up
    if (storedHash == null) {
      return false;
    }

    final currentHash = await _computeBiometricHash();
    return storedHash != currentHash;
  }

  /// Verify biometrics haven't changed and authenticate
  /// If biometrics have changed, returns a failure with biometricsChanged error
  Future<BiometricResult> authenticateWithChangeDetection({
    String localizedReason = 'Bitte authentifizieren Sie sich, um fortzufahren',
    bool allowDeviceCredential = false,
  }) async {
    // Check if biometrics have changed
    if (await haveBiometricsChanged()) {
      return BiometricResult.failure(
        BiometricError.biometricsChanged,
        'Die biometrischen Daten haben sich geändert. Bitte melden Sie sich mit Ihrem Passwort an und aktivieren Sie die Biometrie erneut.',
      );
    }

    return authenticate(
      localizedReason: localizedReason,
      allowDeviceCredential: allowDeviceCredential,
    );
  }

  /// Update the stored biometric hash to the current configuration
  /// Call this after user re-authenticates following a biometric change
  Future<void> updateBiometricHash() async {
    await _storeBiometricHash();
  }
}
