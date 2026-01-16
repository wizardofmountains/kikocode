/// Response status for an event
enum EventResponseStatus {
  attending,
  notAttending,
  maybe,
  pending;

  String get value {
    switch (this) {
      case EventResponseStatus.attending:
        return 'attending';
      case EventResponseStatus.notAttending:
        return 'not_attending';
      case EventResponseStatus.maybe:
        return 'maybe';
      case EventResponseStatus.pending:
        return 'pending';
    }
  }

  String get label {
    switch (this) {
      case EventResponseStatus.attending:
        return 'Zusage';
      case EventResponseStatus.notAttending:
        return 'Absage';
      case EventResponseStatus.maybe:
        return 'Vielleicht';
      case EventResponseStatus.pending:
        return 'Ausstehend';
    }
  }

  static EventResponseStatus fromString(String value) {
    switch (value) {
      case 'attending':
        return EventResponseStatus.attending;
      case 'not_attending':
        return EventResponseStatus.notAttending;
      case 'maybe':
        return EventResponseStatus.maybe;
      case 'pending':
      default:
        return EventResponseStatus.pending;
    }
  }
}

/// Model representing an attendance response from a guardian for an event
class EventResponse {
  final String id;
  final String eventId;
  final String childId;
  final String guardianId;
  final EventResponseStatus response;
  final String? notes;
  final DateTime respondedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EventResponse({
    required this.id,
    required this.eventId,
    required this.childId,
    required this.guardianId,
    required this.response,
    this.notes,
    required this.respondedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      id: json['id'] as String,
      eventId: json['event_id'] as String,
      childId: json['child_id'] as String,
      guardianId: json['guardian_id'] as String,
      response: EventResponseStatus.fromString(json['response'] as String),
      notes: json['notes'] as String?,
      respondedAt: DateTime.parse(json['responded_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'child_id': childId,
      'guardian_id': guardianId,
      'response': response.value,
      'notes': notes,
      'responded_at': respondedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  EventResponse copyWith({
    String? id,
    String? eventId,
    String? childId,
    String? guardianId,
    EventResponseStatus? response,
    String? notes,
    DateTime? respondedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EventResponse(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      childId: childId ?? this.childId,
      guardianId: guardianId ?? this.guardianId,
      response: response ?? this.response,
      notes: notes ?? this.notes,
      respondedAt: respondedAt ?? this.respondedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventResponse &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'EventResponse(id: $id, eventId: $eventId, response: ${response.value})';
}
