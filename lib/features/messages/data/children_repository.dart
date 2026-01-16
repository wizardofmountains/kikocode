import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kikocode/core/config/supabase_config.dart';
import '../domain/models/child.dart';

/// Repository for managing children data
class ChildrenRepository {
  /// Lazy access to Supabase client to avoid initialization issues
  SupabaseClient get _client => SupabaseConfig.client;

  static const String _tableName = 'children';

  /// Get all children
  Future<List<Child>> getChildren() async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .order('last_name')
          .order('first_name');

      return (response as List)
          .map((json) => Child.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Get children by group ID
  Future<List<Child>> getChildrenByGroup(String groupId) async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .eq('group_id', groupId)
          .order('last_name')
          .order('first_name');

      return (response as List)
          .map((json) => Child.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Get a single child by ID
  Future<Child?> getChild(String childId) async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .eq('id', childId)
          .single();

      return Child.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  /// Get a child with their guardians
  Future<Map<String, dynamic>?> getChildWithGuardians(String childId) async {
    try {
      final response = await _client
          .from(_tableName)
          .select('''
            *,
            child_guardians (
              guardian_id,
              relationship,
              is_emergency_contact,
              pickup_authorized,
              guardians (*)
            )
          ''')
          .eq('id', childId)
          .single();

      return response;
    } catch (e) {
      return null;
    }
  }

  /// Stream of children changes for a group
  Stream<List<Child>> watchChildrenByGroup(String groupId) {
    return _client
        .from(_tableName)
        .stream(primaryKey: ['id'])
        .eq('group_id', groupId)
        .order('last_name')
        .map((data) => data.map((json) => Child.fromJson(json)).toList());
  }
}
