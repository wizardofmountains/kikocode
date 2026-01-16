import 'group.dart';

/// Enum representing the type of group message
enum GroupMessageType {
  announcement,
  reminder,
  alert,
  general;

  static GroupMessageType fromString(String? value) {
    switch (value) {
      case 'announcement':
        return GroupMessageType.announcement;
      case 'reminder':
        return GroupMessageType.reminder;
      case 'alert':
        return GroupMessageType.alert;
      case 'general':
      default:
        return GroupMessageType.general;
    }
  }

  String get displayName {
    switch (this) {
      case GroupMessageType.announcement:
        return 'Ankündigung';
      case GroupMessageType.reminder:
        return 'Erinnerung';
      case GroupMessageType.alert:
        return 'Warnung';
      case GroupMessageType.general:
        return 'Allgemein';
    }
  }
}

/// Model representing a group message sent to one or more groups
class GroupMessage {
  final String id;
  final String groupId;
  final String senderId;
  final String? title;
  final String content;
  final GroupMessageType messageType;
  final bool requiresAcknowledgment;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Joined data from related tables
  final Group? group;
  final String? senderName;

  // Statistics from receipts (aggregated)
  final int? totalRecipients;
  final int? readCount;
  final int? acknowledgedCount;

  const GroupMessage({
    required this.id,
    required this.groupId,
    required this.senderId,
    this.title,
    required this.content,
    this.messageType = GroupMessageType.general,
    this.requiresAcknowledgment = false,
    required this.createdAt,
    required this.updatedAt,
    this.group,
    this.senderName,
    this.totalRecipients,
    this.readCount,
    this.acknowledgedCount,
  });

  /// Progress of read receipts (0.0 to 1.0)
  double get readProgress {
    if (totalRecipients == null || totalRecipients == 0) return 0.0;
    return (readCount ?? 0) / totalRecipients!;
  }

  /// Progress of acknowledgments (0.0 to 1.0)
  double get acknowledgedProgress {
    if (totalRecipients == null || totalRecipients == 0) return 0.0;
    return (acknowledgedCount ?? 0) / totalRecipients!;
  }

  /// Formatted time for display (HH:mm)
  String get formattedTime {
    return '${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}';
  }

  /// Formatted date for display (DD.MM.YYYY)
  String get formattedDate {
    return '${createdAt.day.toString().padLeft(2, '0')}.${createdAt.month.toString().padLeft(2, '0')}.${createdAt.year}';
  }

  factory GroupMessage.fromJson(Map<String, dynamic> json) {
    // Handle joined group data
    Group? group;
    if (json['groups'] != null) {
      group = Group.fromJson(json['groups'] as Map<String, dynamic>);
    }

    // Handle joined profile data for sender name
    String? senderName;
    if (json['profiles'] != null) {
      final profiles = json['profiles'] as Map<String, dynamic>;
      senderName = profiles['full_name'] as String?;
    }

    // Handle aggregated stats
    int? totalRecipients;
    int? readCount;
    int? acknowledgedCount;

    if (json['total_recipients'] != null) {
      totalRecipients = json['total_recipients'] as int;
    }
    if (json['read_count'] != null) {
      readCount = json['read_count'] as int;
    }
    if (json['acknowledged_count'] != null) {
      acknowledgedCount = json['acknowledged_count'] as int;
    }

    return GroupMessage(
      id: json['id'] as String,
      groupId: json['group_id'] as String,
      senderId: json['sender_id'] as String,
      title: json['title'] as String?,
      content: json['content'] as String,
      messageType: GroupMessageType.fromString(json['message_type'] as String?),
      requiresAcknowledgment: json['requires_acknowledgment'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      group: group,
      senderName: senderName,
      totalRecipients: totalRecipients,
      readCount: readCount,
      acknowledgedCount: acknowledgedCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'sender_id': senderId,
      'title': title,
      'content': content,
      'message_type': messageType.name,
      'requires_acknowledgment': requiresAcknowledgment,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  GroupMessage copyWith({
    String? id,
    String? groupId,
    String? senderId,
    String? title,
    String? content,
    GroupMessageType? messageType,
    bool? requiresAcknowledgment,
    DateTime? createdAt,
    DateTime? updatedAt,
    Group? group,
    String? senderName,
    int? totalRecipients,
    int? readCount,
    int? acknowledgedCount,
  }) {
    return GroupMessage(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      senderId: senderId ?? this.senderId,
      title: title ?? this.title,
      content: content ?? this.content,
      messageType: messageType ?? this.messageType,
      requiresAcknowledgment:
          requiresAcknowledgment ?? this.requiresAcknowledgment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      group: group ?? this.group,
      senderName: senderName ?? this.senderName,
      totalRecipients: totalRecipients ?? this.totalRecipients,
      readCount: readCount ?? this.readCount,
      acknowledgedCount: acknowledgedCount ?? this.acknowledgedCount,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupMessage &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'GroupMessage(id: $id, title: $title, content: ${content.substring(0, content.length > 20 ? 20 : content.length)}...)';
}
