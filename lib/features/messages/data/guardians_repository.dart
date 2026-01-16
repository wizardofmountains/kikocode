import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kikocode/core/config/supabase_config.dart';
import '../domain/models/guardian.dart';

/// Repository for managing guardian/parent data
class GuardiansRepository {
  /// Lazy access to Supabase client to avoid initialization issues
  SupabaseClient get _client => SupabaseConfig.client;

  static const String _tableName = 'guardians';
  static const String _childGuardiansTable = 'child_guardians';

  /// Get all guardians
  Future<List<Guardian>> getGuardians() async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .order('last_name')
          .order('first_name');

      return (response as List)
          .map((json) => Guardian.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Get a single guardian by ID
  Future<Guardian?> getGuardian(String guardianId) async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .eq('id', guardianId)
          .single();

      return Guardian.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  /// Get all guardians for a specific child
  Future<List<Guardian>> getGuardiansForChild(String childId) async {
    try {
      // First get guardian IDs from the junction table
      final childGuardians = await _client
          .from(_childGuardiansTable)
          .select('guardian_id')
          .eq('child_id', childId);

      if (childGuardians.isEmpty) return [];

      final guardianIds = (childGuardians as List)
          .map((cg) => cg['guardian_id'] as String)
          .toList();

      // Then fetch the guardians
      final response = await _client
          .from(_tableName)
          .select()
          .inFilter('id', guardianIds)
          .order('is_primary_contact', ascending: false)
          .order('last_name');

      return (response as List)
          .map((json) => Guardian.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Get guardians for a child with relationship info from junction table
  Future<List<Map<String, dynamic>>> getGuardiansWithRelationship(
      String childId) async {
    try {
      final response = await _client
          .from(_childGuardiansTable)
          .select('''
            relationship,
            is_emergency_contact,
            pickup_authorized,
            guardians (*)
          ''')
          .eq('child_id', childId);

      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      rethrow;
    }
  }

  /// Get the primary contact for a child
  Future<Guardian?> getPrimaryContactForChild(String childId) async {
    try {
      final guardians = await getGuardiansForChild(childId);
      if (guardians.isEmpty) return null;

      // Return primary contact if exists, otherwise first guardian
      return guardians.firstWhere(
        (g) => g.isPrimaryContact,
        orElse: () => guardians.first,
      );
    } catch (e) {
      return null;
    }
  }
}
