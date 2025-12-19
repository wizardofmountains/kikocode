import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coolicons/coolicons.dart';

class GroupCard extends StatelessWidget {
  final String groupName;
  final String groupIcon;
  final bool isSelected;
  final VoidCallback onTap;
  final int? memberCount;

  const GroupCard({
    super.key,
    required this.groupName,
    required this.groupIcon,
    required this.isSelected,
    required this.onTap,
    this.memberCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFB794F6)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Group icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE9D5FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  groupIcon,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Group info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    groupName,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  if (memberCount != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      '$memberCount Mitglieder',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            // Selection indicator
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFB794F6)
                      : Colors.grey.shade400,
                  width: 2,
                ),
                color: isSelected
                    ? const Color(0xFFB794F6)
                    : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                      Coolicons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

