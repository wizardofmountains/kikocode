# Plan: Update Flutter Code to Fetch from Supabase

## Overview
Replace hardcoded mockup data in 4 Flutter files with Supabase data fetching, following existing repository and Riverpod patterns.

## Current State Analysis

### Hardcoded Data to Replace
| File | Data | Count |
|------|------|-------|
| `message_status_screen.dart` | Groups, Chats (children), Parent info, Messages | ~24 items |
| `message_screen.dart` | Event details, Parent info | ~7 items |
| `groups_section.dart` | Groups (emoji, name) | 3 items |
| `group_selection_screen.dart` | Groups (name, icon, members) | 5 items |

### Existing Patterns to Follow
- **Repository Pattern**: `AuthRepository`, `ProfileRepository` in `features/*/data/`
- **Riverpod Providers**: `Provider`, `StreamProvider`, `FutureProvider` in `features/*/providers/`
- **Models**: Classes with `fromJson()`, `toJson()`, `copyWith()`
- **Supabase Config**: Already initialized via `SupabaseConfig.client`

## Implementation Steps

### Step 1: Create Domain Models
Create models in `lib/features/messages/domain/models/`:

**Files to create:**
- `kindergarten.dart` - Kindergarten entity
- `child.dart` - Child with group reference
- `guardian.dart` - Parent/guardian contact info
- `event.dart` - Event details (Laternenwanderung, etc.)
- `event_response.dart` - Attendance response
- `group_message.dart` - Broadcast messages
- `private_conversation.dart` - Chat threads
- `private_message.dart` - Individual messages

**Update existing:**
- `group.dart` - Add `id`, `kindergartenId`, `description`, `color`, `icon`, `memberCount`

### Step 2: Create Data Repositories
Create in `lib/features/messages/data/`:

**Files to create:**
- `groups_repository.dart`
  - `getGroups()` - Fetch all groups for staff's kindergarten
  - `getGroupsForGuardian()` - Fetch groups for parent's children
  - `getGroupWithMemberCount(groupId)` - Single group with child count

- `children_repository.dart`
  - `getChildrenInGroup(groupId)` - Children in a specific group
  - `getChildrenForGuardian()` - Guardian's own children
  - `getChildWithGuardians(childId)` - Child with parent contact info

- `events_repository.dart`
  - `getEventsForGroup(groupId)` - Events for a group
  - `getEventWithResponses(eventId)` - Event with attendance stats
  - `submitEventResponse(eventId, childId, response)` - Submit/update response

- `messages_repository.dart`
  - `getGroupMessages(groupId)` - Broadcast messages for group
  - `getPrivateConversations()` - Staff/guardian conversations
  - `getPrivateMessages(conversationId)` - Messages in a thread
  - `sendPrivateMessage(conversationId, content)` - Send message
  - `markMessageRead(messageId)` - Mark as read

### Step 3: Create Riverpod Providers
Create in `lib/features/messages/providers/`:

**File: `messages_providers.dart`**
```dart
// Repository providers (singleton)
final groupsRepositoryProvider = Provider<GroupsRepository>((ref) => GroupsRepository());
final childrenRepositoryProvider = Provider<ChildrenRepository>((ref) => ChildrenRepository());
final eventsRepositoryProvider = Provider<EventsRepository>((ref) => EventsRepository());
final messagesRepositoryProvider = Provider<MessagesRepository>((ref) => MessagesRepository());

// Data providers
final groupsProvider = FutureProvider<List<Group>>((ref) async {...});
final childrenInGroupProvider = FutureProvider.family<List<Child>, String>((ref, groupId) async {...});
final eventsForGroupProvider = FutureProvider.family<List<Event>, String>((ref, groupId) async {...});
final privateConversationsProvider = FutureProvider<List<PrivateConversation>>((ref) async {...});

// Stream providers for real-time updates
final privateMessagesStreamProvider = StreamProvider.family<List<PrivateMessage>, String>((ref, conversationId) {...});
```

### Step 4: Update Screen Files

#### 4a. `groups_section.dart`
- Replace hardcoded `_GroupData` list with `ref.watch(groupsProvider)`
- Handle loading/error states with `AsyncValue`
- Keep existing UI structure, just change data source

#### 4b. `group_selection_screen.dart`
- Replace hardcoded groups map with `ref.watch(groupsWithMemberCountProvider)`
- Show loading spinner during fetch
- Handle empty state

#### 4c. `message_status_screen.dart`
- Replace `_groupMessages` with events from `eventsForGroupProvider`
- Replace `_chats` with children from `childrenInGroupProvider`
- Replace `_getParentInfo()` with guardian data from repository
- Replace `_getGroupChatMessages()` with `groupMessagesProvider`
- Replace `_getPrivateChatMessages()` with `privateMessagesStreamProvider`
- Convert to `ConsumerStatefulWidget`

#### 4d. `message_screen.dart`
- Replace `_getEventInfo()` with event data from provider
- Replace `_getParentInfo()` with guardian data from repository
- Replace initial messages with real message history
- Convert to `ConsumerStatefulWidget`

## File Changes Summary

### New Files (10)
```
lib/features/messages/
├── domain/models/
│   ├── kindergarten.dart
│   ├── child.dart
│   ├── guardian.dart
│   ├── event.dart
│   ├── event_response.dart
│   ├── group_message.dart
│   ├── private_conversation.dart
│   └── private_message.dart
├── data/
│   ├── groups_repository.dart
│   ├── children_repository.dart
│   ├── events_repository.dart
│   └── messages_repository.dart
└── providers/
    └── messages_providers.dart
```

### Modified Files (5)
```
lib/features/messages/domain/models/group.dart  (extend model)
lib/features/messages/presentation/screens/message_status_screen.dart
lib/features/messages/presentation/screens/message_screen.dart
lib/features/home/presentation/widgets/groups_section.dart
lib/features/messages/presentation/screens/group_selection_screen.dart
```

## Database Tables Used
- `groups` - Group info (name, emoji/icon, color)
- `children` - Children in groups
- `guardians` + `child_guardians` - Parent contact info
- `events` + `event_responses` - Events and attendance
- `group_messages` - Broadcast announcements
- `private_conversations` + `private_messages` - Private chats

## Verification

1. **Groups Section** (`/home`): Verify groups load from database
2. **Group Selection** (`/group-selection`): Verify groups with member counts
3. **Message Status** (`/message-status`):
   - Verify events load with response counts
   - Verify children list loads
   - Verify parent info displays correctly
   - Verify group/private messages load
4. **Message Screen** (`/message/:groupName`):
   - Verify event details load
   - Verify message history loads
   - Verify sending messages works

**Test commands:**
```bash
flutter analyze
flutter test
flutter run
```

## Notes
- All screens convert from `StatefulWidget` to `ConsumerStatefulWidget` for Riverpod
- Use `AsyncValue.when()` pattern for loading/error/data states
- Real-time updates via Supabase streams for private messages
- RLS policies ensure data isolation (staff sees their kindergarten, parents see their children)
