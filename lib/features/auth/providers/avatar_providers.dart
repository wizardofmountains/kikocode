import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kikocode/core/services/avatar_storage_service.dart';
import 'package:kikocode/features/auth/data/profile_repository.dart';
import 'auth_providers.dart';

// ============================================================================
// Services
// ============================================================================

/// Avatar Storage Service Provider
final avatarStorageServiceProvider = Provider<AvatarStorageService>((ref) {
  return AvatarStorageService();
});

// ============================================================================
// Avatar Upload State
// ============================================================================

/// State for avatar upload operations
enum AvatarUploadStatus {
  idle,
  uploading,
  success,
  error,
}

class AvatarUploadState {
  final AvatarUploadStatus status;
  final String? errorMessage;
  final String? uploadedUrl;
  final double? progress;

  const AvatarUploadState({
    this.status = AvatarUploadStatus.idle,
    this.errorMessage,
    this.uploadedUrl,
    this.progress,
  });

  const AvatarUploadState.idle()
      : status = AvatarUploadStatus.idle,
        errorMessage = null,
        uploadedUrl = null,
        progress = null;

  const AvatarUploadState.uploading([this.progress])
      : status = AvatarUploadStatus.uploading,
        errorMessage = null,
        uploadedUrl = null;

  const AvatarUploadState.success(String url)
      : status = AvatarUploadStatus.success,
        uploadedUrl = url,
        errorMessage = null,
        progress = null;

  const AvatarUploadState.error(String message)
      : status = AvatarUploadStatus.error,
        errorMessage = message,
        uploadedUrl = null,
        progress = null;

  bool get isUploading => status == AvatarUploadStatus.uploading;
  bool get isSuccess => status == AvatarUploadStatus.success;
  bool get isError => status == AvatarUploadStatus.error;
  bool get isIdle => status == AvatarUploadStatus.idle;
}

// ============================================================================
// Avatar Upload Provider
// ============================================================================

/// Avatar Upload Provider with state management
final avatarUploadProvider =
    StateNotifierProvider<AvatarUploadNotifier, AvatarUploadState>((ref) {
  return AvatarUploadNotifier(
    ref.watch(avatarStorageServiceProvider),
    ref.watch(profileRepositoryProvider),
  );
});

class AvatarUploadNotifier extends StateNotifier<AvatarUploadState> {
  final AvatarStorageService _storageService;
  final ProfileRepository _profileRepository;

  AvatarUploadNotifier(this._storageService, this._profileRepository)
      : super(const AvatarUploadState.idle());

  /// Upload a custom avatar image file
  Future<bool> uploadCustomAvatar(File file) async {
    state = const AvatarUploadState.uploading();

    final result = await _storageService.uploadAvatar(file);

    if (result.success && result.publicUrl != null) {
      // Update the profile with the new avatar URL
      try {
        await _profileRepository.updateProfile(avatarUrl: result.publicUrl);
        state = AvatarUploadState.success(result.publicUrl!);
        return true;
      } catch (e) {
        state = AvatarUploadState.error('Profil konnte nicht aktualisiert werden: $e');
        return false;
      }
    } else {
      state = AvatarUploadState.error(result.error ?? 'Upload fehlgeschlagen');
      return false;
    }
  }

  /// Set a predefined avatar (asset path stored in profile)
  Future<bool> setPredefinedAvatar(String assetPath) async {
    state = const AvatarUploadState.uploading();

    try {
      // For predefined avatars, we store the asset path prefixed with 'asset:'
      // This allows us to distinguish between network URLs and local assets
      final avatarValue = 'asset:$assetPath';
      await _profileRepository.updateProfile(avatarUrl: avatarValue);
      state = AvatarUploadState.success(avatarValue);
      return true;
    } catch (e) {
      state = AvatarUploadState.error('Avatar konnte nicht gesetzt werden: $e');
      return false;
    }
  }

  /// Clear the current avatar
  Future<bool> clearAvatar() async {
    state = const AvatarUploadState.uploading();

    try {
      await _profileRepository.clearAvatar();
      state = const AvatarUploadState.success('');
      return true;
    } catch (e) {
      state = AvatarUploadState.error('Avatar konnte nicht entfernt werden: $e');
      return false;
    }
  }

  /// Reset the upload state to idle
  void reset() {
    state = const AvatarUploadState.idle();
  }
}

// ============================================================================
// Helper Extensions
// ============================================================================

/// Extension to parse avatar URL and determine if it's an asset or network URL
extension AvatarUrlExtension on String? {
  /// Check if the avatar URL is a predefined asset
  bool get isAssetAvatar => this != null && this!.startsWith('asset:');

  /// Get the actual asset path if this is an asset avatar
  String? get assetPath {
    if (this == null || !this!.startsWith('asset:')) return null;
    return this!.substring(6); // Remove 'asset:' prefix
  }

  /// Get the network URL if this is a network avatar
  String? get networkUrl {
    if (this == null || this!.isEmpty || this!.startsWith('asset:')) return null;
    return this;
  }
}
