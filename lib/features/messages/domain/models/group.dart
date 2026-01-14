import 'package:flutter/material.dart';

/// Represents a group that can receive messages
/// Contains display information including emoji icon and color
class Group {
  final String id;
  final String name;
  final String emoji;
  final Color iconColor;

  const Group({
    required this.id,
    required this.name,
    required this.emoji,
    required this.iconColor,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Group &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Group(id: $id, name: $name, emoji: $emoji)';
}
