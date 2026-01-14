import 'package:flutter/material.dart';
import 'package:kikocode/core/components/components.dart';

/// Action card widget for the home screen
/// 
/// Wraps AppActionCard for feature-specific usage.
class ActionCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppActionCard(
      title: title,
      onTap: onTap,
    );
  }
}

