import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kikocode/core/config/supabase_config.dart';
import '../domain/models/group_message.dart';
import '../domain/models/group_message_receipt.dart';

/// Repository for managing group messages and receipts
class GroupMessagesRepository {
  /// Lazy access to Supabase client to avoid initialization issues
  SupabaseClient get _client => SupabaseConfig.client;

  static const String _messagesTable = 'group_messages';
  static const String _receiptsTable = 'group_message_receipts';

  /// Get the current user's ID
  String? get currentUserId => _client.auth.currentUser?.id;

  /// Get all group messages for the current user's kindergarten
  Future<List<GroupMessage>> getGroupMessages() async {
    try {
      final response = await _client.from(_messagesTable).select('''
            *,
            groups (*),
            profiles:sender_id (full_name)
          ''').order('created_at', ascending: false);

      return (response as List)
          .map((json) => GroupMessage.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Get group messages with read/acknowledged statistics
  Future<List<Map<String, dynamic>>> getGroupMessagesWithStats() async {
    try {
      // First get all group messages
      final messages = await _client.from(_messagesTable).select('''
            *,
            groups (*),
            profiles:sender_id (full_name)
          ''').order('created_at', ascending: false);

      // For each message, get receipt statistics
      final result = <Map<String, dynamic>>[];

      for (final message in messages) {
        final messageId = message['id'] as String;

        // Get receipt counts using count queries
        final receiptsResponse = await _client
            .from(_receiptsTable)
            .select('id')
            .eq('message_id', messageId);

        final totalRecipients = (receiptsResponse as List).length;

        final readResponse = await _client
            .from(_receiptsTable)
            .select('id')
            .eq('message_id', messageId)
            .not('read_at', 'is', null);

        final readCount = (readResponse as List).length;

        final acknowledgedResponse = await _client
            .from(_receiptsTable)
            .select('id')
            .eq('message_id', messageId)
            .not('acknowledged_at', 'is', null);

        final acknowledgedCount = (acknowledgedResponse as List).length;

        // Add stats to message data
        final messageWithStats = Map<String, dynamic>.from(message);
        messageWithStats['total_recipients'] = totalRecipients;
        messageWithStats['read_count'] = readCount;
        messageWithStats['acknowledged_count'] = acknowledgedCount;
        messageWithStats['progress'] = totalRecipients > 0
            ? readCount / totalRecipients
            : 0.0;

        result.add(messageWithStats);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  /// Get a specific group message by ID
  Future<GroupMessage?> getGroupMessage(String messageId) async {
    try {
      final response = await _client.from(_messagesTable).select('''
            *,
            groups (*),
            profiles:sender_id (full_name)
          ''').eq('id', messageId).single();

      return GroupMessage.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  /// Get group messages for a specific group
  Future<List<GroupMessage>> getGroupMessagesByGroup(String groupId) async {
    try {
      final response = await _client.from(_messagesTable).select('''
            *,
            groups (*),
            profiles:sender_id (full_name)
          ''').eq('group_id', groupId).order('created_at', ascending: false);

      return (response as List)
          .map((json) => GroupMessage.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Send a group message to a single group
  Future<GroupMessage> sendGroupMessage({
    required String groupId,
    required String content,
    String? title,
    GroupMessageType messageType = GroupMessageType.general,
    bool requiresAcknowledgment = false,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('No authenticated user');
    }

    final now = DateTime.now();
    final data = {
      'group_id': groupId,
      'sender_id': userId,
      'title': title,
      'content': content,
      'message_type': messageType.name,
      'requires_acknowledgment': requiresAcknowledgment,
      'created_at': now.toIso8601String(),
      'updated_at': now.toIso8601String(),
    };

    final result = await _client.from(_messagesTable).insert(data).select('''
          *,
          groups (*),
          profiles:sender_id (full_name)
        ''').single();

    // Create receipts for all guardians of children in the group
    await _createReceiptsForMessage(result['id'] as String, groupId);

    return GroupMessage.fromJson(result);
  }

  /// Send a group message to multiple groups
  Future<List<GroupMessage>> sendGroupMessageToMultiple({
    required List<String> groupIds,
    required String content,
    String? title,
    GroupMessageType messageType = GroupMessageType.general,
    bool requiresAcknowledgment = false,
  }) async {
    final messages = <GroupMessage>[];

    for (final groupId in groupIds) {
      final message = await sendGroupMessage(
        groupId: groupId,
        content: content,
        title: title,
        messageType: messageType,
        requiresAcknowledgment: requiresAcknowledgment,
      );
      messages.add(message);
    }

    return messages;
  }

  /// Create receipts for all guardians of children in a group
  Future<void> _createReceiptsForMessage(
      String messageId, String groupId) async {
    try {
      // Get all children in the group
      final childrenResponse = await _client
          .from('children')
          .select('id')
          .eq('group_id', groupId);

      final childIds =
          (childrenResponse as List).map((c) => c['id'] as String).toList();

      if (childIds.isEmpty) return;

      // Get all guardian-child relationships
      final guardiansResponse = await _client
          .from('child_guardians')
          .select('guardian_id, child_id')
          .inFilter('child_id', childIds);

      // Create receipts
      final receipts = <Map<String, dynamic>>[];
      final now = DateTime.now();

      for (final relation in guardiansResponse) {
        receipts.add({
          'message_id': messageId,
          'guardian_id': relation['guardian_id'],
          'child_id': relation['child_id'],
          'created_at': now.toIso8601String(),
        });
      }

      if (receipts.isNotEmpty) {
        await _client.from(_receiptsTable).insert(receipts);
      }
    } catch (e) {
      // Log error but don't fail the message send
      // ignore: avoid_print
      print('Error creating receipts: $e');
    }
  }

  /// Get receipts for a specific message
  Future<List<GroupMessageReceipt>> getMessageReceipts(String messageId) async {
    try {
      final response = await _client.from(_receiptsTable).select('''
            *,
            guardians (*),
            children (*)
          ''').eq('message_id', messageId).order('created_at');

      return (response as List)
          .map((json) =>
              GroupMessageReceipt.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Stream of group messages for real-time updates
  Stream<List<GroupMessage>> watchGroupMessages() {
    return _client
        .from(_messagesTable)
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data.map((json) => GroupMessage.fromJson(json)).toList());
  }

  /// Stream of group messages for a specific group
  Stream<List<GroupMessage>> watchGroupMessagesByGroup(String groupId) {
    return _client
        .from(_messagesTable)
        .stream(primaryKey: ['id'])
        .eq('group_id', groupId)
        .order('created_at', ascending: false)
        .map((data) => data.map((json) => GroupMessage.fromJson(json)).toList());
  }

  /// Delete a group message (only by sender)
  Future<void> deleteGroupMessage(String messageId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('No authenticated user');
    }

    // First delete all receipts
    await _client.from(_receiptsTable).delete().eq('message_id', messageId);

    // Then delete the message
    await _client
        .from(_messagesTable)
        .delete()
        .eq('id', messageId)
        .eq('sender_id', userId);
  }
}
