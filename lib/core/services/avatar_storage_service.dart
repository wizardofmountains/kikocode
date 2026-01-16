import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

/// Result of an avatar upload operation
class AvatarUploadResult {
  final bool success;
  final String? publicUrl;
  final String? error;

  const AvatarUploadResult({
    required this.success,
    this.publicUrl,
    this.error,
  });

  const AvatarUploadResult.success(String url)
      : success = true,
        publicUrl = url,
        error = null;

  const AvatarUploadResult.failure(String errorMessage)
      : success = false,
        publicUrl = null,
        error = errorMessage;
}

/// Service for handling avatar uploads, deletions, and URL generation.
///
/// Manages avatar storage in Supabase Storage bucket 'avatars'.
/// Each user's avatars are stored in their own folder: avatars/{userId}/
class AvatarStorageService {
  static const String _bucketName = 'avatars';

  /// Lazy access to Supabase client
  SupabaseClient get _client => SupabaseConfig.client;

  /// Get the current user's ID
  String? get _currentUserId => _client.auth.currentUser?.id;

  /// Upload an avatar image file for the current user.
  ///
  /// Returns the public URL of the uploaded image on success.
  Future<AvatarUploadResult> uploadAvatar(File file) async {
    final userId = _currentUserId;
    if (userId == null) {
      return const AvatarUploadResult.failure('User not authenticated');
    }

    return _uploadFile(file, userId, 'avatar');
  }

  /// Upload an avatar image from bytes for the current user.
  Future<AvatarUploadResult> uploadAvatarBytes(
    Uint8List bytes, {
    String extension = 'jpg',
  }) async {
    final userId = _currentUserId;
    if (userId == null) {
      return const AvatarUploadResult.failure('User not authenticated');
    }

    return _uploadBytes(bytes, userId, 'avatar', extension);
  }

  /// Upload an avatar for a specific child.
  ///
  /// Requires appropriate permissions (parent of the child or staff).
  Future<AvatarUploadResult> uploadChildAvatar(
    String childId,
    File file,
  ) async {
    final userId = _currentUserId;
    if (userId == null) {
      return const AvatarUploadResult.failure('User not authenticated');
    }

    // Child avatars stored under the user's folder with child prefix
    return _uploadFile(file, userId, 'child_$childId');
  }

  /// Upload child avatar from bytes.
  Future<AvatarUploadResult> uploadChildAvatarBytes(
    String childId,
    Uint8List bytes, {
    String extension = 'jpg',
  }) async {
    final userId = _currentUserId;
    if (userId == null) {
      return const AvatarUploadResult.failure('User not authenticated');
    }

    return _uploadBytes(bytes, userId, 'child_$childId', extension);
  }

  /// Delete an avatar by its URL.
  ///
  /// Parses the URL to extract the file path and deletes it.
  Future<bool> deleteAvatar(String url) async {
    try {
      final path = _extractPathFromUrl(url);
      if (path == null) {
        return false;
      }

      await _client.storage.from(_bucketName).remove([path]);
      return true;
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting avatar: $e');
      return false;
    }
  }

  /// Delete all avatars for the current user.
  Future<bool> deleteAllUserAvatars() async {
    final userId = _currentUserId;
    if (userId == null) return false;

    try {
      final files = await _client.storage.from(_bucketName).list(path: userId);
      if (files.isEmpty) return true;

      final paths = files.map((f) => '$userId/${f.name}').toList();
      await _client.storage.from(_bucketName).remove(paths);
      return true;
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting user avatars: $e');
      return false;
    }
  }

  /// Get the public URL for an avatar path.
  String getPublicUrl(String path) {
    return _client.storage.from(_bucketName).getPublicUrl(path);
  }

  /// Internal method to upload a file.
  Future<AvatarUploadResult> _uploadFile(
    File file,
    String userId,
    String filePrefix,
  ) async {
    try {
      final extension = _getFileExtension(file.path);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = '${filePrefix}_$timestamp.$extension';
      final path = '$userId/$fileName';

      // Delete existing avatars with the same prefix
      await _deleteExistingAvatars(userId, filePrefix);

      await _client.storage.from(_bucketName).upload(
            path,
            file,
            fileOptions: FileOptions(
              contentType: _getContentType(extension),
              upsert: true,
            ),
          );

      final publicUrl = getPublicUrl(path);
      return AvatarUploadResult.success(publicUrl);
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading avatar: $e');
      return AvatarUploadResult.failure(e.toString());
    }
  }

  /// Internal method to upload bytes.
  Future<AvatarUploadResult> _uploadBytes(
    Uint8List bytes,
    String userId,
    String filePrefix,
    String extension,
  ) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = '${filePrefix}_$timestamp.$extension';
      final path = '$userId/$fileName';

      // Delete existing avatars with the same prefix
      await _deleteExistingAvatars(userId, filePrefix);

      await _client.storage.from(_bucketName).uploadBinary(
            path,
            bytes,
            fileOptions: FileOptions(
              contentType: _getContentType(extension),
              upsert: true,
            ),
          );

      final publicUrl = getPublicUrl(path);
      return AvatarUploadResult.success(publicUrl);
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading avatar bytes: $e');
      return AvatarUploadResult.failure(e.toString());
    }
  }

  /// Delete existing avatars with the given prefix.
  Future<void> _deleteExistingAvatars(String userId, String filePrefix) async {
    try {
      final files = await _client.storage.from(_bucketName).list(path: userId);
      final toDelete = files
          .where((f) => f.name.startsWith(filePrefix))
          .map((f) => '$userId/${f.name}')
          .toList();

      if (toDelete.isNotEmpty) {
        await _client.storage.from(_bucketName).remove(toDelete);
      }
    } catch (e) {
      // Ignore errors during cleanup
      // ignore: avoid_print
      print('Warning: Could not clean up existing avatars: $e');
    }
  }

  /// Extract file path from a Supabase storage URL.
  String? _extractPathFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final segments = uri.pathSegments;

      // Find the bucket name in the path and get everything after it
      final bucketIndex = segments.indexOf(_bucketName);
      if (bucketIndex == -1 || bucketIndex >= segments.length - 1) {
        return null;
      }

      return segments.sublist(bucketIndex + 1).join('/');
    } catch (e) {
      return null;
    }
  }

  /// Get file extension from path.
  String _getFileExtension(String path) {
    final lastDot = path.lastIndexOf('.');
    if (lastDot == -1) return 'jpg';
    return path.substring(lastDot + 1).toLowerCase();
  }

  /// Get content type for file extension.
  String _getContentType(String extension) {
    switch (extension.toLowerCase()) {
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'heic':
        return 'image/heic';
      case 'jpg':
      case 'jpeg':
      default:
        return 'image/jpeg';
    }
  }
}
