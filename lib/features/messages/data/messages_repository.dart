import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kikocode/core/config/supabase_config.dart';
import '../domain/models/private_conversation.dart';
import '../domain/models/private_message.dart';

/// Repository for managing private conversations and messages
class MessagesRepository {
  /// Lazy access to Supabase client to avoid initialization issues
  SupabaseClient get _client => SupabaseConfig.client;

  static const String _conversationsTable = 'private_conversations';
  static const String _messagesTable = 'private_messages';

  /// Get the current user's ID
  String? get currentUserId => _client.auth.currentUser?.id;

  /// Get all conversations for the current staff member
  Future<List<PrivateConversation>> getConversations() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return [];

      final response = await _client
          .from(_conversationsTable)
          .select('''
            *,
            children (*),
            guardians (*)
          ''')
          .eq('staff_id', userId)
          .order('last_message_at', ascending: false);

      return (response as List)
          .map((json) =>
              PrivateConversation.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Get a specific conversation by ID
  Future<PrivateConversation?> getConversation(String conversationId) async {
    try {
      final response = await _client
          .from(_conversationsTable)
          .select('''
            *,
            children (*),
            guardians (*)
          ''')
          .eq('id', conversationId)
          .single();

      return PrivateConversation.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  /// Get or create a conversation for a child
  Future<PrivateConversation> getOrCreateConversation({
    required String childId,
    required String guardianId,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('No authenticated user');
    }

    // Try to find existing conversation
    try {
      final existing = await _client
          .from(_conversationsTable)
          .select('''
            *,
            children (*),
            guardians (*)
          ''')
          .eq('child_id', childId)
          .eq('guardian_id', guardianId)
          .eq('staff_id', userId)
          .single();

      return PrivateConversation.fromJson(existing);
    } catch (_) {
      // Create new conversation if not found
      final now = DateTime.now();
      final data = {
        'child_id': childId,
        'guardian_id': guardianId,
        'staff_id': userId,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      final result = await _client
          .from(_conversationsTable)
          .insert(data)
          .select('''
            *,
            children (*),
            guardians (*)
          ''')
          .single();

      return PrivateConversation.fromJson(result);
    }
  }

  /// Get messages for a conversation
  Future<List<PrivateMessage>> getMessages(String conversationId) async {
    try {
      final response = await _client
          .from(_messagesTable)
          .select('''
            *,
            profiles:sender_id (full_name)
          ''')
          .eq('conversation_id', conversationId)
          .order('created_at');

      return (response as List)
          .map((json) => PrivateMessage.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Send a message in a conversation
  Future<PrivateMessage> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('No authenticated user');
    }

    final now = DateTime.now();
    final data = {
      'conversation_id': conversationId,
      'sender_id': userId,
      'content': content,
      'created_at': now.toIso8601String(),
    };

    final result = await _client
        .from(_messagesTable)
        .insert(data)
        .select('''
          *,
          profiles:sender_id (full_name)
        ''')
        .single();

    // Update conversation's last_message_at
    await _client
        .from(_conversationsTable)
        .update({
          'last_message_at': now.toIso8601String(),
          'updated_at': now.toIso8601String(),
        })
        .eq('id', conversationId);

    return PrivateMessage.fromJson(result);
  }

  /// Mark messages as read
  Future<void> markMessagesAsRead(String conversationId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    await _client
        .from(_messagesTable)
        .update({'read_at': DateTime.now().toIso8601String()})
        .eq('conversation_id', conversationId)
        .neq('sender_id', userId)
        .isFilter('read_at', null);
  }

  /// Stream of messages for real-time updates
  Stream<List<PrivateMessage>> watchMessages(String conversationId) {
    return _client
        .from(_messagesTable)
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .order('created_at')
        .map((data) => data.map((json) => PrivateMessage.fromJson(json)).toList());
  }

  /// Stream of conversations for real-time updates
  Stream<List<PrivateConversation>> watchConversations() {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      return Stream.value([]);
    }

    return _client
        .from(_conversationsTable)
        .stream(primaryKey: ['id'])
        .eq('staff_id', userId)
        .order('last_message_at', ascending: false)
        .map((data) =>
            data.map((json) => PrivateConversation.fromJson(json)).toList());
  }
}
