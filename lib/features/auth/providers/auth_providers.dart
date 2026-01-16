import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kikocode/features/auth/data/auth_repository.dart';
import 'package:kikocode/features/auth/data/profile_repository.dart';
import 'package:kikocode/core/services/biometric_service.dart';
import 'package:kikocode/core/services/secure_credential_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ============================================================================
// Services
// ============================================================================

/// Biometric Service Provider
final biometricServiceProvider = Provider<BiometricService>((ref) {
  return BiometricService();
});

/// Secure Credential Service Provider
final secureCredentialServiceProvider = Provider<SecureCredentialService>((ref) {
  return SecureCredentialService();
});

// ============================================================================
// Repositories
// ============================================================================

/// Auth Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// Profile Repository Provider
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

// ============================================================================
// User State
// ============================================================================

/// Current User Provider (streams auth state changes)
final currentUserProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges.map((state) => state.session?.user);
});

/// Current Profile Provider
final currentProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) return null;
  
  final profileRepository = ref.watch(profileRepositoryProvider);
  return profileRepository.getCurrentProfile();
});

/// Profile Stream Provider (real-time updates)
final profileStreamProvider = StreamProvider<UserProfile?>((ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  return profileRepository.watchCurrentProfile();
});

// ============================================================================
// Biometric State
// ============================================================================

/// Whether biometric authentication is available on this device
final biometricAvailableProvider = FutureProvider<bool>((ref) async {
  final biometricService = ref.watch(biometricServiceProvider);
  return biometricService.isBiometricAvailable();
});

/// Whether biometrics are enrolled (not just available on device)
final biometricEnrolledProvider = FutureProvider<bool>((ref) async {
  final biometricService = ref.watch(biometricServiceProvider);
  return biometricService.hasBiometricsEnrolled();
});

/// Whether the user has enabled biometric authentication
final biometricEnabledProvider = FutureProvider<bool>((ref) async {
  final biometricService = ref.watch(biometricServiceProvider);
  return biometricService.isBiometricEnabled();
});

/// Human-readable name for the biometric type (Face ID / Touch ID)
final biometricTypeNameProvider = FutureProvider<String>((ref) async {
  final biometricService = ref.watch(biometricServiceProvider);
  return biometricService.getBiometricTypeName();
});

/// Whether biometrics have changed since setup (security check)
final biometricsChangedProvider = FutureProvider<bool>((ref) async {
  final biometricService = ref.watch(biometricServiceProvider);
  return biometricService.haveBiometricsChanged();
});

// ============================================================================
// Auth State Notifier
// ============================================================================

/// Auth State Provider with full state management
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AsyncValue<User?>>((ref) {
  return AuthStateNotifier(
    ref.watch(authRepositoryProvider),
    ref.watch(profileRepositoryProvider),
    ref.watch(secureCredentialServiceProvider),
    ref.watch(biometricServiceProvider),
  );
});

class AuthStateNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;
  final SecureCredentialService _secureCredentialService;
  final BiometricService _biometricService;

  AuthStateNotifier(
    this._authRepository,
    this._profileRepository,
    this._secureCredentialService,
    this._biometricService,
  ) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    state = AsyncValue.data(_authRepository.currentUser);
  }

  /// Sign in with email and password
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authRepository.signIn(
        email: email,
        password: password,
      );
      state = AsyncValue.data(response.user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Sign up with email, password, and optional profile data
  Future<void> signUp({
    required String email,
    required String password,
    String? username,
    String? displayName,
  }) async {
    state = const AsyncValue.loading();
    try {
      final response = await _authRepository.signUp(
        email: email,
        password: password,
        username: username,
        displayName: displayName,
      );
      state = AsyncValue.data(response.user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Sign out (keeps stored credentials for biometric re-login)
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await _authRepository.signOut();
      // DON'T clear credentials - they're needed for biometric re-login
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Sign out and forget all stored credentials
  /// Use this for "logout from all devices" or when user wants to fully disconnect
  Future<void> signOutAndForget() async {
    state = const AsyncValue.loading();
    try {
      await _authRepository.signOut();
      // Clear all stored credentials and biometric settings
      await _secureCredentialService.clearCredentials();
      await _biometricService.setBiometricEnabled(false);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Get the current user's profile
  Future<UserProfile?> getProfile() async {
    return _profileRepository.getCurrentProfile();
  }
}
