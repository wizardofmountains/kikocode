import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';

/// Card elevation levels
enum AppCardElevation {
  none,
  low,
  medium,
  high,
}

/// A reusable card component with consistent styling
/// 
/// Provides a container with padding, border radius, shadow, and optional border.
/// 
/// Example:
/// ```dart
/// AppCard(
///   child: Column(
///     children: [
///       Text('Card Title', style: AppTypography.h4),
///       AppSpacing.v2,
///       Text('Card content', style: AppTypography.bodyBase),
///     ],
///   ),
/// )
/// ```
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.elevation = AppCardElevation.low,
    this.onTap,
    this.width,
    this.height,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final AppCardElevation elevation;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ?? AppSpacing.all6;
    final effectiveBorderRadius = borderRadius ?? AppBorders.xl;
    final effectiveBackgroundColor = backgroundColor ?? AppColors.surface;
    final shadow = _getElevationShadow(elevation);

    Widget card = Container(
      width: width,
      height: height,
      margin: margin,
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: effectiveBorderRadius,
        border: borderColor != null
            ? Border.all(color: borderColor!)
            : null,
        boxShadow: shadow,
      ),
      child: child,
    );

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: effectiveBorderRadius,
        child: card,
      );
    }

    return card;
  }

  List<BoxShadow>? _getElevationShadow(AppCardElevation elevation) {
    switch (elevation) {
      case AppCardElevation.none:
        return null;
      case AppCardElevation.low:
        return AppShadows.sm;
      case AppCardElevation.medium:
        return AppShadows.md;
      case AppCardElevation.high:
        return AppShadows.lg;
    }
  }
}

/// A card with a header, body, and optional footer
/// 
/// Useful for content cards with structured layout.
/// 
/// Example:
/// ```dart
/// AppCardSection(
///   header: Text('Title', style: AppTypography.h4),
///   body: Text('Content here'),
///   footer: AppButton(label: 'Action', onPressed: () {}),
/// )
/// ```
class AppCardSection extends StatelessWidget {
  const AppCardSection({
    super.key,
    this.header,
    required this.body,
    this.footer,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.elevation = AppCardElevation.low,
    this.onTap,
    this.headerPadding,
    this.bodyPadding,
    this.footerPadding,
    this.showDividers = false,
  });

  final Widget? header;
  final Widget body;
  final Widget? footer;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final AppCardElevation elevation;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? headerPadding;
  final EdgeInsetsGeometry? bodyPadding;
  final EdgeInsetsGeometry? footerPadding;
  final bool showDividers;

  @override
  Widget build(BuildContext context) {
    final effectiveHeaderPadding = headerPadding ?? AppSpacing.all6;
    final effectiveBodyPadding = bodyPadding ?? AppSpacing.all6;
    final effectiveFooterPadding = footerPadding ?? AppSpacing.all6;

    return AppCard(
      padding: padding ?? EdgeInsets.zero,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      elevation: elevation,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (header != null) ...[
            Padding(
              padding: effectiveHeaderPadding,
              child: header,
            ),
            if (showDividers) const Divider(height: 1),
          ],
          Padding(
            padding: effectiveBodyPadding,
            child: body,
          ),
          if (footer != null) ...[
            if (showDividers) const Divider(height: 1),
            Padding(
              padding: effectiveFooterPadding,
              child: footer,
            ),
          ],
        ],
      ),
    );
  }
}

/// A card with an image at the top
/// 
/// Useful for news cards, product cards, etc.
/// 
/// Example:
/// ```dart
/// AppImageCard(
///   imageUrl: 'https://example.com/image.jpg',
///   title: 'Card Title',
///   description: 'Card description',
///   onTap: () => print('Tapped'),
/// )
/// ```
class AppImageCard extends StatelessWidget {
  const AppImageCard({
    super.key,
    this.imageUrl,
    this.imagePath,
    this.imageWidget,
    this.imageHeight = 180,
    required this.title,
    this.description,
    this.footer,
    this.onTap,
    this.elevation = AppCardElevation.low,
  });

  final String? imageUrl;
  final String? imagePath;
  final Widget? imageWidget;
  final double imageHeight;
  final String title;
  final String? description;
  final Widget? footer;
  final VoidCallback? onTap;
  final AppCardElevation elevation;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      elevation: elevation,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: _buildImage(),
          ),
          // Content
          Padding(
            padding: AppSpacing.all4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.h5,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (description != null) ...[
                  AppSpacing.v2,
                  Text(
                    description!,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (footer != null) ...[
                  AppSpacing.v3,
                  footer!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (imageWidget != null) {
      return SizedBox(
        height: imageHeight,
        child: imageWidget,
      );
    }

    if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        height: imageHeight,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }

    if (imagePath != null) {
      return Image.asset(
        imagePath!,
        height: imageHeight,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }

    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      height: imageHeight,
      color: AppColors.gray200,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 48,
          color: AppColors.gray400,
        ),
      ),
    );
  }
}
