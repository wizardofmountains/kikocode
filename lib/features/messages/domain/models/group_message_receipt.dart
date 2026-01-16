import 'guardian.dart';
import 'child.dart';

/// Model representing a receipt for a group message
/// Tracks whether a guardian has read/acknowledged a message for a specific child
class GroupMessageReceipt {
  final String id;
  final String messageId;
  final String guardianId;
  final String childId;
  final DateTime? readAt;
  final DateTime? acknowledgedAt;
  final DateTime createdAt;

  // Joined data from related tables
  final Guardian? guardian;
  final Child? child;

  const GroupMessageReceipt({
    required this.id,
    required this.messageId,
    required this.guardianId,
    required this.childId,
    this.readAt,
    this.acknowledgedAt,
    required this.createdAt,
    this.guardian,
    this.child,
  });

  /// Whether the message has been read
  bool get isRead => readAt != null;

  /// Whether the message has been acknowledged
  bool get isAcknowledged => acknowledgedAt != null;

  /// Formatted read time for display (HH:mm)
  String? get formattedReadTime {
    if (readAt == null) return null;
    return '${readAt!.hour.toString().padLeft(2, '0')}:${readAt!.minute.toString().padLeft(2, '0')}';
  }

  /// Formatted acknowledged time for display (HH:mm)
  String? get formattedAcknowledgedTime {
    if (acknowledgedAt == null) return null;
    return '${acknowledgedAt!.hour.toString().padLeft(2, '0')}:${acknowledgedAt!.minute.toString().padLeft(2, '0')}';
  }

  factory GroupMessageReceipt.fromJson(Map<String, dynamic> json) {
    // Handle joined guardian data
    Guardian? guardian;
    if (json['guardians'] != null) {
      guardian = Guardian.fromJson(json['guardians'] as Map<String, dynamic>);
    }

    // Handle joined child data
    Child? child;
    if (json['children'] != null) {
      child = Child.fromJson(json['children'] as Map<String, dynamic>);
    }

    return GroupMessageReceipt(
      id: json['id'] as String,
      messageId: json['message_id'] as String,
      guardianId: json['guardian_id'] as String,
      childId: json['child_id'] as String,
      readAt: json['read_at'] != null
          ? DateTime.parse(json['read_at'] as String)
          : null,
      acknowledgedAt: json['acknowledged_at'] != null
          ? DateTime.parse(json['acknowledged_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      guardian: guardian,
      child: child,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message_id': messageId,
      'guardian_id': guardianId,
      'child_id': childId,
      'read_at': readAt?.toIso8601String(),
      'acknowledged_at': acknowledgedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  GroupMessageReceipt copyWith({
    String? id,
    String? messageId,
    String? guardianId,
    String? childId,
    DateTime? readAt,
    DateTime? acknowledgedAt,
    DateTime? createdAt,
    Guardian? guardian,
    Child? child,
  }) {
    return GroupMessageReceipt(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      guardianId: guardianId ?? this.guardianId,
      childId: childId ?? this.childId,
      readAt: readAt ?? this.readAt,
      acknowledgedAt: acknowledgedAt ?? this.acknowledgedAt,
      createdAt: createdAt ?? this.createdAt,
      guardian: guardian ?? this.guardian,
      child: child ?? this.child,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupMessageReceipt &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'GroupMessageReceipt(id: $id, messageId: $messageId, isRead: $isRead, isAcknowledged: $isAcknowledged)';
}
