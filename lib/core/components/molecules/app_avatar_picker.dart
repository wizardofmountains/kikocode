import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../design_system/design_system.dart';
import '../../constants/asset_paths.dart';
import '../atoms/app_avatar.dart';

/// Result from avatar picker
class AvatarPickerResult {
  /// The selected predefined avatar asset path (if predefined was chosen)
  final String? assetPath;

  /// The selected/cropped image file (if custom was chosen)
  final File? imageFile;

  /// Whether the user wants to remove the avatar
  final bool removeAvatar;

  const AvatarPickerResult({
    this.assetPath,
    this.imageFile,
    this.removeAvatar = false,
  });

  const AvatarPickerResult.asset(String path)
      : assetPath = path,
        imageFile = null,
        removeAvatar = false;

  const AvatarPickerResult.file(File file)
      : imageFile = file,
        assetPath = null,
        removeAvatar = false;

  const AvatarPickerResult.remove()
      : assetPath = null,
        imageFile = null,
        removeAvatar = true;

  bool get hasSelection => assetPath != null || imageFile != null;
}

/// Avatar picker bottom sheet with camera, gallery, and predefined avatar options.
///
/// Usage:
/// ```dart
/// final result = await AppAvatarPicker.show(context);
/// if (result != null && result.hasSelection) {
///   // Handle the selection
/// }
/// ```
class AppAvatarPicker {
  /// Show the avatar picker bottom sheet.
  ///
  /// Returns an [AvatarPickerResult] or null if cancelled.
  static Future<AvatarPickerResult?> show(
    BuildContext context, {
    String? currentAvatarUrl,
    String? currentAssetPath,
    bool showRemoveOption = false,
  }) {
    return showModalBottomSheet<AvatarPickerResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AvatarPickerSheet(
        currentAvatarUrl: currentAvatarUrl,
        currentAssetPath: currentAssetPath,
        showRemoveOption: showRemoveOption,
      ),
    );
  }
}

class _AvatarPickerSheet extends StatefulWidget {
  final String? currentAvatarUrl;
  final String? currentAssetPath;
  final bool showRemoveOption;

  const _AvatarPickerSheet({
    this.currentAvatarUrl,
    this.currentAssetPath,
    this.showRemoveOption = false,
  });

  @override
  State<_AvatarPickerSheet> createState() => _AvatarPickerSheetState();
}

class _AvatarPickerSheetState extends State<_AvatarPickerSheet> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceHighest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.gray300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Profilbild auswählen',
                style: AppTypography.h4,
              ),
            ),

            // Loading overlay
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              )
            else ...[
              // Camera and Gallery options
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.camera_alt,
                        label: 'Kamera',
                        onTap: _pickFromCamera,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.photo_library,
                        label: 'Galerie',
                        onTap: _pickFromGallery,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Predefined avatars section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Oder wähle einen Avatar',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Predefined avatars grid
              SizedBox(
                height: 180,
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: AssetPaths.predefinedAvatars.length,
                  itemBuilder: (context, index) {
                    final avatarPath = AssetPaths.predefinedAvatars[index];
                    final isSelected = avatarPath == widget.currentAssetPath;
                    return _AvatarOption(
                      assetPath: avatarPath,
                      isSelected: isSelected,
                      onTap: () => _selectPredefinedAvatar(avatarPath),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Remove option
              if (widget.showRemoveOption &&
                  (widget.currentAvatarUrl != null ||
                      widget.currentAssetPath != null))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton.icon(
                    onPressed: _removeAvatar,
                    icon: const Icon(Icons.delete_outline, color: AppColors.error),
                    label: Text(
                      'Profilbild entfernen',
                      style: AppTypography.bodyBase.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _pickFromCamera() async {
    await _pickImage(ImageSource.camera);
  }

  Future<void> _pickFromGallery() async {
    await _pickImage(ImageSource.gallery);
  }

  Future<void> _pickImage(ImageSource source) async {
    setState(() => _isLoading = true);

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image == null) {
        setState(() => _isLoading = false);
        return;
      }

      // Crop the image
      final croppedFile = await _cropImage(image.path);

      if (croppedFile != null && mounted) {
        Navigator.of(context).pop(AvatarPickerResult.file(croppedFile));
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Laden des Bildes: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<File?> _cropImage(String imagePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Bild zuschneiden',
          toolbarColor: AppColors.primary,
          statusBarColor: AppColors.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          hideBottomControls: false,
        ),
        IOSUiSettings(
          title: 'Bild zuschneiden',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
          aspectRatioPickerButtonHidden: true,
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }

  void _selectPredefinedAvatar(String assetPath) {
    Navigator.of(context).pop(AvatarPickerResult.asset(assetPath));
  }

  void _removeAvatar() {
    Navigator.of(context).pop(const AvatarPickerResult.remove());
  }
}

/// Action button for camera/gallery
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceHigh,
      borderRadius: AppBorders.lg,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorders.lg,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
                color: AppColors.primary,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Single avatar option in the grid
class _AvatarOption extends StatelessWidget {
  final String assetPath;
  final bool isSelected;
  final VoidCallback onTap;

  const _AvatarOption({
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 3)
              : null,
        ),
        child: AppAvatar(
          assetPath: assetPath,
          size: AppAvatarSize.large,
        ),
      ),
    );
  }
}
