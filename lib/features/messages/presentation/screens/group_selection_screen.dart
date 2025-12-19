import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';
import '../widgets/group_card.dart';

class GroupSelectionScreen extends StatefulWidget {
  const GroupSelectionScreen({super.key});

  @override
  State<GroupSelectionScreen> createState() => _GroupSelectionScreenState();
}

class _GroupSelectionScreenState extends State<GroupSelectionScreen> {
  final List<String> _selectedGroups = [];

  // Mock data for groups
  final List<Map<String, dynamic>> _groups = [
    {'name': 'Sonnenscheingruppe', 'icon': '☀️', 'members': 15},
    {'name': 'Regenbogengruppe', 'icon': '🌈', 'members': 18},
    {'name': 'Sternengruppe', 'icon': '⭐', 'members': 16},
    {'name': 'Mondgruppe', 'icon': '🌙', 'members': 14},
    {'name': 'Wolkengruppe', 'icon': '☁️', 'members': 17},
  ];

  void _toggleGroupSelection(String groupName) {
    setState(() {
      if (_selectedGroups.contains(groupName)) {
        _selectedGroups.remove(groupName);
      } else {
        _selectedGroups.add(groupName);
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
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _groups.length,
              itemBuilder: (context, index) {
                final group = _groups[index];
                return GroupCard(
                  groupName: group['name'],
                  groupIcon: group['icon'],
                  memberCount: group['members'],
                  isSelected: _selectedGroups.contains(group['name']),
                  onTap: () => _toggleGroupSelection(group['name']),
                );
              },
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
}

