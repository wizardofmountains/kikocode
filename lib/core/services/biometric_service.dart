import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for handling biometric authentication (Face ID / Touch ID)
class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();
  
  static const String _biometricEnabledKey = 'biometric_enabled';
  
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
  /// Returns true if authentication was successful
  Future<bool> authenticate({
    String localizedReason = 'Bitte authentifizieren Sie sich, um fortzufahren',
  }) async {
    try {
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      return didAuthenticate;
    } on PlatformException catch (e) {
      debugPrint('BiometricService: Authentication error: $e');
      return false;
    }
  }
  
  /// Check if the user has enabled biometric authentication in the app
  Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricEnabledKey) ?? false;
  }
  
  /// Enable or disable biometric authentication for the app
  Future<void> setBiometricEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, enabled);
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
}
