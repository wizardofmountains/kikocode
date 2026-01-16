import 'package:flutter/material.dart';

/// Represents a kindergarten group (e.g., Sonnenschein, Schmetterling)
class Group {
  final String id;
  final String kindergartenId;
  final String name;
  final String? description;
  final String? color;
  final String? icon;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Computed property for member count (from joined query)
  final int? memberCount;

  const Group({
    required this.id,
    required this.kindergartenId,
    required this.name,
    this.description,
    this.color,
    this.icon,
    required this.createdAt,
    required this.updatedAt,
    this.memberCount,
  });

  /// Map of icon identifiers to emoji characters
  static const Map<String, String> _iconToEmoji = {
    'cloud': '☁️',
    'star': '⭐',
    'sun': '☀️',
    'butterfly': '🦋',
    'rainbow': '🌈',
    'parrot': '🦜',
    'moon': '🌙',
    'ladybug': '🐞',
    'flower': '🌸',
    'tree': '🌳',
    'fish': '🐟',
    'bird': '🐦',
    'bear': '🐻',
    'bee': '🐝',
    'cat': '🐱',
    'dog': '🐶',
    'rabbit': '🐰',
    'turtle': '🐢',
    'dolphin': '🐬',
    'elephant': '🐘',
    'lion': '🦁',
    'penguin': '🐧',
    'frog': '🐸',
    'snail': '🐌',
    'mushroom': '🍄',
    'apple': '🍎',
    'heart': '❤️',
    'rocket': '🚀',
  };

  /// Returns the emoji icon for the group (defaults to a star if not set)
  String get emoji {
    if (icon == null) return '⭐';
    // First check if it's an icon identifier that needs mapping
    final mapped = _iconToEmoji[icon!.toLowerCase()];
    if (mapped != null) return mapped;
    // If not in map, return the icon as-is (might already be an emoji)
    return icon!;
  }

  /// Returns the color for the group icon as a Flutter Color
  Color get iconColor {
    if (color == null) return const Color(0xFFB794F6);

    // Parse hex color string
    String hexColor = color!.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  factory Group.fromJson(Map<String, dynamic> json) {
    // Handle member count from aggregation
    int? memberCount;
    if (json['children'] != null && json['children'] is List) {
      memberCount = (json['children'] as List).length;
    } else if (json['member_count'] != null) {
      memberCount = json['member_count'] as int;
    }

    return Group(
      id: json['id'] as String,
      kindergartenId: json['kindergarten_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      color: json['color'] as String?,
      icon: json['icon'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      memberCount: memberCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kindergarten_id': kindergartenId,
      'name': name,
      'description': description,
      'color': color,
      'icon': icon,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Group copyWith({
    String? id,
    String? kindergartenId,
    String? name,
    String? description,
    String? color,
    String? icon,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? memberCount,
  }) {
    return Group(
      id: id ?? this.id,
      kindergartenId: kindergartenId ?? this.kindergartenId,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      memberCount: memberCount ?? this.memberCount,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Group && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Group(id: $id, name: $name, emoji: $emoji)';
}
