/// Model representing an event like Laternenwanderung, Gemüsebuffet, Pyjamaparty
class Event {
  final String id;
  final String groupId;
  final String title;
  final String? description;
  final DateTime eventDate;
  final String? eventTime;
  final String? endTime;
  final String? location;
  final bool requiresResponse;
  final DateTime? responseDeadline;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Event({
    required this.id,
    required this.groupId,
    required this.title,
    this.description,
    required this.eventDate,
    this.eventTime,
    this.endTime,
    this.location,
    this.requiresResponse = false,
    this.responseDeadline,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Formatted date string for display
  String get formattedDate {
    final weekdays = [
      'Montag',
      'Dienstag',
      'Mittwoch',
      'Donnerstag',
      'Freitag',
      'Samstag',
      'Sonntag'
    ];
    final months = [
      'Januar',
      'Februar',
      'März',
      'April',
      'Mai',
      'Juni',
      'Juli',
      'August',
      'September',
      'Oktober',
      'November',
      'Dezember'
    ];
    final weekday = weekdays[eventDate.weekday - 1];
    final month = months[eventDate.month - 1];
    return '$weekday, ${eventDate.day}. $month ${eventDate.year}';
  }

  /// Formatted time range for display
  String get formattedTimeRange {
    if (eventTime == null) return 'Uhrzeit wird noch bekannt gegeben';
    if (endTime == null) return '$eventTime Uhr';
    return '$eventTime - $endTime Uhr';
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      groupId: json['group_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      eventDate: DateTime.parse(json['event_date'] as String),
      eventTime: json['event_time'] as String?,
      endTime: json['end_time'] as String?,
      location: json['location'] as String?,
      requiresResponse: json['requires_response'] as bool? ?? false,
      responseDeadline: json['response_deadline'] != null
          ? DateTime.parse(json['response_deadline'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'title': title,
      'description': description,
      'event_date': eventDate.toIso8601String().split('T').first,
      'event_time': eventTime,
      'end_time': endTime,
      'location': location,
      'requires_response': requiresResponse,
      'response_deadline': responseDeadline?.toIso8601String().split('T').first,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Event copyWith({
    String? id,
    String? groupId,
    String? title,
    String? description,
    DateTime? eventDate,
    String? eventTime,
    String? endTime,
    String? location,
    bool? requiresResponse,
    DateTime? responseDeadline,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Event(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      title: title ?? this.title,
      description: description ?? this.description,
      eventDate: eventDate ?? this.eventDate,
      eventTime: eventTime ?? this.eventTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      requiresResponse: requiresResponse ?? this.requiresResponse,
      responseDeadline: responseDeadline ?? this.responseDeadline,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Event(id: $id, title: $title, date: $eventDate)';
}
