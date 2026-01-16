/// Model representing a parent/guardian contact for children
class Guardian {
  final String id;
  final String? profileId;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phone;
  final String? address;
  final String relationship;
  final bool isPrimaryContact;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Guardian({
    required this.id,
    this.profileId,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phone,
    this.address,
    this.relationship = 'parent',
    this.isPrimaryContact = false,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Full name of the guardian
  String get fullName => '$firstName $lastName';

  /// Returns localized relationship label
  String get relationshipLabel {
    switch (relationship) {
      case 'mother':
        return 'Mutter';
      case 'father':
        return 'Vater';
      case 'grandparent':
        return 'Großeltern';
      case 'other':
        return 'Andere';
      default:
        return 'Eltern';
    }
  }

  factory Guardian.fromJson(Map<String, dynamic> json) {
    return Guardian(
      id: json['id'] as String,
      profileId: json['profile_id'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      relationship: json['relationship'] as String? ?? 'parent',
      isPrimaryContact: json['is_primary_contact'] as bool? ?? false,
      avatarUrl: json['avatar_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile_id': profileId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'relationship': relationship,
      'is_primary_contact': isPrimaryContact,
      'avatar_url': avatarUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Guardian copyWith({
    String? id,
    String? profileId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? address,
    String? relationship,
    bool? isPrimaryContact,
    String? avatarUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Guardian(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      relationship: relationship ?? this.relationship,
      isPrimaryContact: isPrimaryContact ?? this.isPrimaryContact,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Guardian && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Guardian(id: $id, name: $fullName, relationship: $relationship)';
}
