import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/groups_repository.dart';
import '../../data/children_repository.dart';
import '../../data/guardians_repository.dart';
import '../../data/events_repository.dart';
import '../../data/messages_repository.dart';
import '../../data/group_messages_repository.dart';
import '../../domain/models/models.dart';

// ============================================================================
// Repositories
// ============================================================================

/// Groups Repository Provider
final groupsRepositoryProvider = Provider<GroupsRepository>((ref) {
  return GroupsRepository();
});

/// Children Repository Provider
final childrenRepositoryProvider = Provider<ChildrenRepository>((ref) {
  return ChildrenRepository();
});

/// Guardians Repository Provider
final guardiansRepositoryProvider = Provider<GuardiansRepository>((ref) {
  return GuardiansRepository();
});

/// Events Repository Provider
final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  return EventsRepository();
});

/// Messages Repository Provider
final messagesRepositoryProvider = Provider<MessagesRepository>((ref) {
  return MessagesRepository();
});

/// Group Messages Repository Provider
final groupMessagesRepositoryProvider = Provider<GroupMessagesRepository>((ref) {
  return GroupMessagesRepository();
});

// ============================================================================
// Groups Providers
// ============================================================================

/// Provider for all groups
final groupsProvider = FutureProvider<List<Group>>((ref) async {
  final repository = ref.watch(groupsRepositoryProvider);
  return repository.getGroups();
});

/// Provider for groups with member counts
final groupsWithMemberCountsProvider = FutureProvider<List<Group>>((ref) async {
  final repository = ref.watch(groupsRepositoryProvider);
  return repository.getGroupsWithMemberCounts();
});

/// Provider for a single group by ID
final groupProvider = FutureProvider.family<Group?, String>((ref, groupId) async {
  final repository = ref.watch(groupsRepositoryProvider);
  return repository.getGroup(groupId);
});

/// Stream provider for real-time group updates
final groupsStreamProvider = StreamProvider<List<Group>>((ref) {
  final repository = ref.watch(groupsRepositoryProvider);
  return repository.watchGroups();
});

// ============================================================================
// Children Providers
// ============================================================================

/// Provider for all children
final childrenProvider = FutureProvider<List<Child>>((ref) async {
  final repository = ref.watch(childrenRepositoryProvider);
  return repository.getChildren();
});

/// Provider for children in a specific group
final childrenByGroupProvider =
    FutureProvider.family<List<Child>, String>((ref, groupId) async {
  final repository = ref.watch(childrenRepositoryProvider);
  return repository.getChildrenByGroup(groupId);
});

/// Provider for a single child by ID
final childProvider = FutureProvider.family<Child?, String>((ref, childId) async {
  final repository = ref.watch(childrenRepositoryProvider);
  return repository.getChild(childId);
});

// ============================================================================
// Guardians Providers
// ============================================================================

/// Provider for all guardians
final guardiansProvider = FutureProvider<List<Guardian>>((ref) async {
  final repository = ref.watch(guardiansRepositoryProvider);
  return repository.getGuardians();
});

/// Provider for guardians of a specific child
final guardiansForChildProvider =
    FutureProvider.family<List<Guardian>, String>((ref, childId) async {
  final repository = ref.watch(guardiansRepositoryProvider);
  return repository.getGuardiansForChild(childId);
});

/// Provider for primary contact of a child
final primaryContactForChildProvider =
    FutureProvider.family<Guardian?, String>((ref, childId) async {
  final repository = ref.watch(guardiansRepositoryProvider);
  return repository.getPrimaryContactForChild(childId);
});

// ============================================================================
// Events Providers
// ============================================================================

/// Provider for all events
final eventsProvider = FutureProvider<List<Event>>((ref) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return repository.getEvents();
});

/// Provider for events in a specific group
final eventsByGroupProvider =
    FutureProvider.family<List<Event>, String>((ref, groupId) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return repository.getEventsByGroup(groupId);
});

/// Provider for upcoming events
final upcomingEventsProvider = FutureProvider<List<Event>>((ref) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return repository.getUpcomingEvents();
});

/// Provider for a single event by ID
final eventProvider = FutureProvider.family<Event?, String>((ref, eventId) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return repository.getEvent(eventId);
});

/// Provider for events with response statistics
final eventsWithStatsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return repository.getEventsWithResponseStats();
});

/// Provider for event responses
final eventResponsesProvider =
    FutureProvider.family<List<EventResponse>, String>((ref, eventId) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return repository.getEventResponses(eventId);
});

/// Stream provider for real-time event updates
final eventsStreamProvider = StreamProvider<List<Event>>((ref) {
  final repository = ref.watch(eventsRepositoryProvider);
  return repository.watchEvents();
});

// ============================================================================
// Messages/Conversations Providers
// ============================================================================

/// Provider for all conversations
final conversationsProvider = FutureProvider<List<PrivateConversation>>((ref) async {
  final repository = ref.watch(messagesRepositoryProvider);
  return repository.getConversations();
});

/// Provider for a single conversation by ID
final conversationProvider =
    FutureProvider.family<PrivateConversation?, String>((ref, conversationId) async {
  final repository = ref.watch(messagesRepositoryProvider);
  return repository.getConversation(conversationId);
});

/// Provider for messages in a conversation
final messagesProvider =
    FutureProvider.family<List<PrivateMessage>, String>((ref, conversationId) async {
  final repository = ref.watch(messagesRepositoryProvider);
  return repository.getMessages(conversationId);
});

/// Stream provider for real-time message updates
final messagesStreamProvider =
    StreamProvider.family<List<PrivateMessage>, String>((ref, conversationId) {
  final repository = ref.watch(messagesRepositoryProvider);
  return repository.watchMessages(conversationId);
});

/// Stream provider for real-time conversation updates
final conversationsStreamProvider = StreamProvider<List<PrivateConversation>>((ref) {
  final repository = ref.watch(messagesRepositoryProvider);
  return repository.watchConversations();
});

// ============================================================================
// State Providers for Selection
// ============================================================================

/// State provider for selected groups (multi-select)
final selectedGroupsProvider = StateProvider<List<String>>((ref) => []);

// ============================================================================
// Group Messages Providers
// ============================================================================

/// Provider for all group messages
final groupMessagesProvider = FutureProvider<List<GroupMessage>>((ref) async {
  final repository = ref.watch(groupMessagesRepositoryProvider);
  return repository.getGroupMessages();
});

/// Provider for group messages with statistics (read/acknowledged counts)
final groupMessagesWithStatsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repository = ref.watch(groupMessagesRepositoryProvider);
  return repository.getGroupMessagesWithStats();
});

/// Provider for a single group message by ID
final groupMessageProvider =
    FutureProvider.family<GroupMessage?, String>((ref, messageId) async {
  final repository = ref.watch(groupMessagesRepositoryProvider);
  return repository.getGroupMessage(messageId);
});

/// Provider for group messages in a specific group
final groupMessagesByGroupProvider =
    FutureProvider.family<List<GroupMessage>, String>((ref, groupId) async {
  final repository = ref.watch(groupMessagesRepositoryProvider);
  return repository.getGroupMessagesByGroup(groupId);
});

/// Provider for message receipts
final groupMessageReceiptsProvider =
    FutureProvider.family<List<GroupMessageReceipt>, String>((ref, messageId) async {
  final repository = ref.watch(groupMessagesRepositoryProvider);
  return repository.getMessageReceipts(messageId);
});

/// Stream provider for real-time group message updates
final groupMessagesStreamProvider = StreamProvider<List<GroupMessage>>((ref) {
  final repository = ref.watch(groupMessagesRepositoryProvider);
  return repository.watchGroupMessages();
});

/// Stream provider for real-time group messages in a specific group
final groupMessagesStreamByGroupProvider =
    StreamProvider.family<List<GroupMessage>, String>((ref, groupId) {
  final repository = ref.watch(groupMessagesRepositoryProvider);
  return repository.watchGroupMessagesByGroup(groupId);
});
