import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kikocode/core/config/supabase_config.dart';

/// Model representing a user profile
class UserProfile {
  final String id;
  final String? email;
  final String? fullName;
  final String? avatarUrl;
  final String role;
  final String? phone;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    this.email,
    this.fullName,
    this.avatarUrl,
    required this.role,
    this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  /// The name to display in the UI
  String get name => fullName ?? email ?? '';

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      email: json['email'] as String?,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      role: (json['role'] as String?) ?? 'parent',
      phone: json['phone'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'role': role,
      'phone': phone,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserProfile copyWith({
    String? id,
    String? email,
    String? fullName,
    String? avatarUrl,
    String? role,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Repository for managing user profiles in Supabase
class ProfileRepository {
  /// Lazy access to Supabase client to avoid initialization issues
  SupabaseClient get _client => SupabaseConfig.client;

  static const String _tableName = 'profiles';

  /// Get the current user's profile
  Future<UserProfile?> getCurrentProfile() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;
    
    return getProfile(userId);
  }

  /// Get a profile by user ID
  Future<UserProfile?> getProfile(String userId) async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .eq('id', userId)
          .single();
      
      return UserProfile.fromJson(response);
    } catch (e) {
      // Profile might not exist yet
      return null;
    }
  }

  /// Create a new profile
  Future<UserProfile> createProfile({
    required String userId,
    String? email,
    String? fullName,
    String? avatarUrl,
    String role = 'parent',
  }) async {
    final now = DateTime.now();
    final data = {
      'id': userId,
      'email': email,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'role': role,
      'created_at': now.toIso8601String(),
      'updated_at': now.toIso8601String(),
    };

    final response = await _client
        .from(_tableName)
        .insert(data)
        .select()
        .single();

    return UserProfile.fromJson(response);
  }

  /// Update the current user's profile
  Future<UserProfile> updateProfile({
    String? fullName,
    String? avatarUrl,
    String? phone,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('No authenticated user');
    }

    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };

    if (fullName != null) updates['full_name'] = fullName;
    if (avatarUrl != null) updates['avatar_url'] = avatarUrl;
    if (phone != null) updates['phone'] = phone;

    final response = await _client
        .from(_tableName)
        .update(updates)
        .eq('id', userId)
        .select()
        .single();

    return UserProfile.fromJson(response);
  }

  /// Stream of profile changes for the current user
  Stream<UserProfile?> watchCurrentProfile() {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      return Stream.value(null);
    }

    return _client
        .from(_tableName)
        .stream(primaryKey: ['id'])
        .eq('id', userId)
        .map((data) {
          if (data.isEmpty) return null;
          return UserProfile.fromJson(data.first);
        });
  }

  /// Clear the current user's avatar
  Future<UserProfile> clearAvatar() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('No authenticated user');
    }

    final updates = <String, dynamic>{
      'avatar_url': null,
      'updated_at': DateTime.now().toIso8601String(),
    };

    final response = await _client
        .from(_tableName)
        .update(updates)
        .eq('id', userId)
        .select()
        .single();

    return UserProfile.fromJson(response);
  }
}
