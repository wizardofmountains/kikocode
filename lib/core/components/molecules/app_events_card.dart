import 'package:flutter/material.dart';
import 'package:kikocode/core/design_system/design_system.dart';
import 'app_card.dart';

/// Event item data model
class AppEventItem {
  const AppEventItem({
    required this.dateLabel,
    required this.eventName,
    this.isActive = false,
  });

  /// The date or day label (e.g., "Heute", "Mi, 10.")
  final String dateLabel;
  
  /// The event name
  final String eventName;
  
  /// Whether this event is active/current (affects text color)
  final bool isActive;
}

/// A card component for displaying a list of events
/// 
/// Displays events in a two-column layout with dates/days on the left
/// and event names on the right. Active events are shown in dark text,
/// while upcoming events are shown in lighter gray.
/// 
/// Example:
/// ```dart
/// AppEventsCard(
///   title: 'Meine Ereignisse',
///   events: [
///     AppEventItem(
///       dateLabel: 'Heute',
///       eventName: 'Laternenwanderung',
///       isActive: true,
///     ),
///     AppEventItem(
///       dateLabel: 'Mi, 10.',
///       eventName: 'Gemüsebuffet',
///     ),
///   ],
/// )
/// ```
class AppEventsCard extends StatelessWidget {
  const AppEventsCard({
    super.key,
    required this.title,
    required this.events,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.titleStyle,
    this.onEventTap,
  });

  /// The card title
  final String title;
  
  /// List of events to display
  final List<AppEventItem> events;
  
  /// Background color (default: AppColors.backgroundLight)
  final Color? backgroundColor;
  
  /// Border radius (default: AppBorders.xl2)
  final BorderRadius? borderRadius;
  
  /// Padding inside the card (default: AppSpacing.all5)
  final EdgeInsetsGeometry? padding;
  
  /// Title text style (default: AppTypography.h5)
  final TextStyle? titleStyle;
  
  /// Callback when an event is tapped (optional)
  final void Function(AppEventItem event, int index)? onEventTap;

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? AppColors.backgroundLight;
    final effectiveBorderRadius = borderRadius ?? AppBorders.xl2;
    final effectivePadding = padding ?? AppSpacing.all5;
    final effectiveTitleStyle = titleStyle ?? AppTypography.h5;

    return Container(
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: effectiveBorderRadius,
        boxShadow: AppShadows.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: effectiveTitleStyle,
          ),
          AppSpacing.v3,
          ...events.asMap().entries.map((entry) {
            final index = entry.key;
            final event = entry.value;
            return _buildEventItem(event, index);
          }),
        ],
      ),
    );
  }

  Widget _buildEventItem(AppEventItem event, int index) {
    final textColor = event.isActive
        ? AppColors.textPrimary
        : AppColors.textSecondary;

    Widget item = Padding(
      padding: AppSpacing.bottomOnly(
        index < events.length - 1 ? AppSpacing.spacing2 : 0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date/Day column
          SizedBox(
            width: 80,
            child: Text(
              event.dateLabel,
              style: AppTypography.bodyBase.copyWith(
                color: textColor,
                fontWeight: event.isActive
                    ? AppTypography.semiBold
                    : AppTypography.regular,
              ),
            ),
          ),
          // Event name column
          Expanded(
            child: Text(
              event.eventName,
              style: AppTypography.bodyBase.copyWith(
                color: textColor,
                fontWeight: event.isActive
                    ? AppTypography.semiBold
                    : AppTypography.regular,
              ),
            ),
          ),
        ],
      ),
    );

    if (onEventTap != null) {
      item = InkWell(
        onTap: () => onEventTap!(event, index),
        borderRadius: AppBorders.base,
        child: item,
      );
    }

    return item;
  }
}
