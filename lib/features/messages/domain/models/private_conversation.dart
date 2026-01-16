import 'child.dart';
import 'guardian.dart';

/// Model representing a private chat thread between staff and guardians about a specific child
class PrivateConversation {
  final String id;
  final String childId;
  final String guardianId;
  final String staffId;
  final DateTime? lastMessageAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Optional joined data
  final Child? child;
  final Guardian? guardian;

  const PrivateConversation({
    required this.id,
    required this.childId,
    required this.guardianId,
    required this.staffId,
    this.lastMessageAt,
    required this.createdAt,
    required this.updatedAt,
    this.child,
    this.guardian,
  });

  factory PrivateConversation.fromJson(Map<String, dynamic> json) {
    return PrivateConversation(
      id: json['id'] as String,
      childId: json['child_id'] as String,
      guardianId: json['guardian_id'] as String,
      staffId: json['staff_id'] as String,
      lastMessageAt: json['last_message_at'] != null
          ? DateTime.parse(json['last_message_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      child: json['children'] != null
          ? Child.fromJson(json['children'] as Map<String, dynamic>)
          : null,
      guardian: json['guardians'] != null
          ? Guardian.fromJson(json['guardians'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'child_id': childId,
      'guardian_id': guardianId,
      'staff_id': staffId,
      'last_message_at': lastMessageAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  PrivateConversation copyWith({
    String? id,
    String? childId,
    String? guardianId,
    String? staffId,
    DateTime? lastMessageAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Child? child,
    Guardian? guardian,
  }) {
    return PrivateConversation(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      guardianId: guardianId ?? this.guardianId,
      staffId: staffId ?? this.staffId,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      child: child ?? this.child,
      guardian: guardian ?? this.guardian,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrivateConversation &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'PrivateConversation(id: $id, childId: $childId, guardianId: $guardianId)';
}
