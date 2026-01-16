import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';
import '../providers/messages_providers.dart';
import '../../domain/models/group.dart';
import '../widgets/group_card.dart';

class GroupSelectionScreen extends ConsumerStatefulWidget {
  const GroupSelectionScreen({super.key});

  @override
  ConsumerState<GroupSelectionScreen> createState() =>
      _GroupSelectionScreenState();
}

class _GroupSelectionScreenState extends ConsumerState<GroupSelectionScreen> {
  final List<String> _selectedGroups = [];

  void _toggleGroupSelection(String groupId) {
    setState(() {
      if (_selectedGroups.contains(groupId)) {
        _selectedGroups.remove(groupId);
      } else {
        _selectedGroups.add(groupId);
      }
    });
  }

  void _sendMessage() {
    if (_selectedGroups.isNotEmpty) {
      // Navigate to message composition or message page
      context.go('/messages');
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupsAsync = ref.watch(groupsWithMemberCountsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Coolicons.chevron_left, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Gruppe auswählen',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey.shade200,
            height: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          // Selection counter
          if (_selectedGroups.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFE9D5FF).withOpacity(0.3),
              child: Text(
                '${_selectedGroups.length} ${_selectedGroups.length == 1 ? "Gruppe" : "Gruppen"} ausgewählt',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9333EA),
                ),
                textAlign: TextAlign.center,
              ),
            ),

          // Groups list
          Expanded(
            child: groupsAsync.when(
              data: (groups) => _buildGroupsList(groups),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Fehler beim Laden der Gruppen',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () =>
                          ref.invalidate(groupsWithMemberCountsProvider),
                      child: const Text('Erneut versuchen'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Send button
          if (_selectedGroups.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: _sendMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB794F6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Nachricht senden',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGroupsList(List<Group> groups) {
    if (groups.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.group,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Keine Gruppen vorhanden',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return GroupCard(
          groupName: group.name,
          groupIcon: group.emoji,
          memberCount: group.memberCount ?? 0,
          isSelected: _selectedGroups.contains(group.id),
          onTap: () => _toggleGroupSelection(group.id),
        );
      },
    );
  }
}
