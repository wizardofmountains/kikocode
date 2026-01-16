import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service for securely storing and retrieving user credentials
/// Uses platform-specific secure storage:
/// - Android: Keystore with EncryptedSharedPreferences
/// - iOS: Keychain with kSecAttrAccessibleWhenUnlocked
class SecureCredentialService {
  static const _emailKey = 'stored_email';
  static const _passwordKey = 'stored_password';

  /// Platform-specific secure storage options
  FlutterSecureStorage get _storage {
    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
    );
    const iosOptions = IOSOptions(
      accessibility: KeychainAccessibility.unlocked,
    );
    return const FlutterSecureStorage(
      aOptions: androidOptions,
      iOptions: iosOptions,
    );
  }

  /// Store user credentials securely
  /// These credentials are encrypted at rest using platform-specific encryption
  Future<void> storeCredentials({
    required String email,
    required String password,
  }) async {
    try {
      await _storage.write(key: _emailKey, value: email);
      await _storage.write(key: _passwordKey, value: password);
      debugPrint('SecureCredentialService: Credentials stored successfully');
    } catch (e) {
      debugPrint('SecureCredentialService: Error storing credentials: $e');
      rethrow;
    }
  }

  /// Retrieve stored credentials
  /// Returns null if no credentials are stored
  Future<({String email, String password})?> getCredentials() async {
    try {
      final email = await _storage.read(key: _emailKey);
      final password = await _storage.read(key: _passwordKey);

      if (email == null || password == null) {
        debugPrint('SecureCredentialService: No stored credentials found');
        return null;
      }

      debugPrint('SecureCredentialService: Credentials retrieved successfully');
      return (email: email, password: password);
    } catch (e) {
      debugPrint('SecureCredentialService: Error retrieving credentials: $e');
      return null;
    }
  }

  /// Check if credentials are stored
  Future<bool> hasStoredCredentials() async {
    try {
      final email = await _storage.read(key: _emailKey);
      final password = await _storage.read(key: _passwordKey);
      final hasCredentials = email != null && password != null;
      debugPrint('SecureCredentialService: hasStoredCredentials = $hasCredentials');
      return hasCredentials;
    } catch (e) {
      debugPrint('SecureCredentialService: Error checking credentials: $e');
      return false;
    }
  }

  /// Clear all stored credentials
  /// Call this when user explicitly logs out and wants to forget credentials
  Future<void> clearCredentials() async {
    try {
      await _storage.delete(key: _emailKey);
      await _storage.delete(key: _passwordKey);
      debugPrint('SecureCredentialService: Credentials cleared');
    } catch (e) {
      debugPrint('SecureCredentialService: Error clearing credentials: $e');
      rethrow;
    }
  }
}
