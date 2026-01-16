/// Model representing an individual message within a private conversation
class PrivateMessage {
  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final DateTime? readAt;
  final DateTime createdAt;

  // Optional: sender display name from joined profiles table
  final String? senderName;

  const PrivateMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    this.readAt,
    required this.createdAt,
    this.senderName,
  });

  /// Whether the message has been read
  bool get isRead => readAt != null;

  /// Formatted time for display (HH:mm)
  String get formattedTime {
    return '${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}';
  }

  factory PrivateMessage.fromJson(Map<String, dynamic> json) {
    // Handle joined profile data for sender name
    String? senderName;
    if (json['profiles'] != null) {
      final profiles = json['profiles'] as Map<String, dynamic>;
      senderName = profiles['full_name'] as String?;
    }

    return PrivateMessage(
      id: json['id'] as String,
      conversationId: json['conversation_id'] as String,
      senderId: json['sender_id'] as String,
      content: json['content'] as String,
      readAt: json['read_at'] != null
          ? DateTime.parse(json['read_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      senderName: senderName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'sender_id': senderId,
      'content': content,
      'read_at': readAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  PrivateMessage copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? content,
    DateTime? readAt,
    DateTime? createdAt,
    String? senderName,
  }) {
    return PrivateMessage(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
      senderName: senderName ?? this.senderName,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrivateMessage &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'PrivateMessage(id: $id, conversationId: $conversationId, content: ${content.substring(0, content.length > 20 ? 20 : content.length)}...)';
}
