/// Model representing a child enrolled in a kindergarten group
class Child {
  final String id;
  final String groupId;
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  final String? avatarUrl;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Child({
    required this.id,
    required this.groupId,
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
    this.avatarUrl,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Full name of the child
  String get fullName => '$firstName $lastName';

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'] as String,
      groupId: json['group_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      avatarUrl: json['avatar_url'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth?.toIso8601String().split('T').first,
      'avatar_url': avatarUrl,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Child copyWith({
    String? id,
    String? groupId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? avatarUrl,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Child(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Child && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Child(id: $id, name: $fullName, groupId: $groupId)';
}
