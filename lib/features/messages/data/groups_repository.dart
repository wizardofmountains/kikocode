import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kikocode/core/config/supabase_config.dart';
import '../domain/models/group.dart';

/// Repository for managing kindergarten groups
class GroupsRepository {
  /// Lazy access to Supabase client to avoid initialization issues
  SupabaseClient get _client => SupabaseConfig.client;

  static const String _tableName = 'groups';

  /// Get all groups
  Future<List<Group>> getGroups() async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .order('name');

      return (response as List)
          .map((json) => Group.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Get groups with member counts (number of children in each group)
  Future<List<Group>> getGroupsWithMemberCounts() async {
    try {
      final response = await _client
          .from(_tableName)
          .select('''
            *,
            children:children(id)
          ''')
          .order('name');

      return (response as List)
          .map((json) => Group.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Get a single group by ID
  Future<Group?> getGroup(String groupId) async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .eq('id', groupId)
          .single();

      return Group.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  /// Get groups for a specific kindergarten
  Future<List<Group>> getGroupsByKindergarten(String kindergartenId) async {
    try {
      final response = await _client
          .from(_tableName)
          .select('''
            *,
            children:children(id)
          ''')
          .eq('kindergarten_id', kindergartenId)
          .order('name');

      return (response as List)
          .map((json) => Group.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Stream of groups changes (real-time updates)
  Stream<List<Group>> watchGroups() {
    return _client
        .from(_tableName)
        .stream(primaryKey: ['id'])
        .order('name')
        .map((data) => data.map((json) => Group.fromJson(json)).toList());
  }
}
