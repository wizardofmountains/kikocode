import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kikocode/core/config/supabase_config.dart';
import '../domain/models/event.dart';
import '../domain/models/event_response.dart';

/// Repository for managing events and event responses
class EventsRepository {
  /// Lazy access to Supabase client to avoid initialization issues
  SupabaseClient get _client => SupabaseConfig.client;

  static const String _eventsTable = 'events';
  static const String _responsesTable = 'event_responses';

  /// Get all events
  Future<List<Event>> getEvents() async {
    try {
      final response = await _client
          .from(_eventsTable)
          .select()
          .order('event_date', ascending: false);

      return (response as List)
          .map((json) => Event.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Get events by group ID
  Future<List<Event>> getEventsByGroup(String groupId) async {
    try {
      final response = await _client
          .from(_eventsTable)
          .select()
          .eq('group_id', groupId)
          .order('event_date', ascending: false);

      return (response as List)
          .map((json) => Event.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Get upcoming events (from today onwards)
  Future<List<Event>> getUpcomingEvents() async {
    try {
      final today = DateTime.now().toIso8601String().split('T').first;
      final response = await _client
          .from(_eventsTable)
          .select()
          .gte('event_date', today)
          .order('event_date');

      return (response as List)
          .map((json) => Event.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Get a single event by ID
  Future<Event?> getEvent(String eventId) async {
    try {
      final response = await _client
          .from(_eventsTable)
          .select()
          .eq('id', eventId)
          .single();

      return Event.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  /// Get events with response statistics (for message status screen)
  Future<List<Map<String, dynamic>>> getEventsWithResponseStats() async {
    try {
      final response = await _client
          .from(_eventsTable)
          .select('''
            *,
            event_responses (
              id,
              response
            ),
            groups!inner (
              id,
              name,
              children (id)
            )
          ''')
          .order('event_date', ascending: false);

      // Process to add response stats
      return (response as List).map((event) {
        final eventData = event as Map<String, dynamic>;
        final responses = eventData['event_responses'] as List? ?? [];
        final group = eventData['groups'] as Map<String, dynamic>?;
        final children = group?['children'] as List? ?? [];

        final totalChildren = children.length;
        final respondedCount = responses.length;

        return {
          ...eventData,
          'total_count': totalChildren,
          'responded_count': respondedCount,
          'progress': totalChildren > 0 ? respondedCount / totalChildren : 0.0,
        };
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Get responses for a specific event
  Future<List<EventResponse>> getEventResponses(String eventId) async {
    try {
      final response = await _client
          .from(_responsesTable)
          .select()
          .eq('event_id', eventId)
          .order('responded_at', ascending: false);

      return (response as List)
          .map((json) => EventResponse.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Submit or update an event response
  Future<EventResponse> submitResponse({
    required String eventId,
    required String childId,
    required String guardianId,
    required EventResponseStatus response,
    String? notes,
  }) async {
    final now = DateTime.now();
    final data = {
      'event_id': eventId,
      'child_id': childId,
      'guardian_id': guardianId,
      'response': response.value,
      'notes': notes,
      'responded_at': now.toIso8601String(),
      'updated_at': now.toIso8601String(),
    };

    // Upsert - insert or update if exists
    final result = await _client
        .from(_responsesTable)
        .upsert(
          data,
          onConflict: 'event_id,child_id,guardian_id',
        )
        .select()
        .single();

    return EventResponse.fromJson(result);
  }

  /// Stream of events for real-time updates
  Stream<List<Event>> watchEvents() {
    return _client
        .from(_eventsTable)
        .stream(primaryKey: ['id'])
        .order('event_date', ascending: false)
        .map((data) => data.map((json) => Event.fromJson(json)).toList());
  }
}
