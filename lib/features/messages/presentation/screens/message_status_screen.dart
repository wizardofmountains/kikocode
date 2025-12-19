import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:coolicons/coolicons.dart';

class MessageStatusScreen extends StatelessWidget {
  const MessageStatusScreen({super.key});

  // Mock data for message status
  static final List<Map<String, dynamic>> _readReceipts = [
    {
      'name': 'David Schmidt',
      'initial': 'D',
      'readTime': '10:32',
      'status': 'read',
    },
    {
      'name': 'Maria Weber',
      'initial': 'M',
      'readTime': '10:35',
      'status': 'read',
    },
    {
      'name': 'Thomas Müller',
      'initial': 'T',
      'readTime': '10:45',
      'status': 'read',
    },
    {
      'name': 'Lisa Fischer',
      'initial': 'L',
      'readTime': 'Nicht gelesen',
      'status': 'delivered',
    },
    {
      'name': 'Anna Schmidt',
      'initial': 'A',
      'readTime': 'Nicht gelesen',
      'status': 'delivered',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final readCount = _readReceipts.where((r) => r['status'] == 'read').length;
    final totalCount = _readReceipts.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Coolicons.close_big, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Nachrichtenstatus',
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
          // Status summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deine Nachricht',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5EFE0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Danke Maria! Das wäre toll.',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Coolicons.check_all,
                      size: 20,
                      color: readCount > 0
                          ? const Color(0xFF9333EA)
                          : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$readCount von $totalCount gelesen',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Read receipts list
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _readReceipts.length,
                itemBuilder: (context, index) {
                  final receipt = _readReceipts[index];
                  return _buildReceiptItem(receipt);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptItem(Map<String, dynamic> receipt) {
    final isRead = receipt['status'] == 'read';
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFE9D5FF),
            child: Text(
              receipt['initial'],
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF9333EA),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Name
          Expanded(
            child: Text(
              receipt['name'],
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          
          // Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                isRead ? Coolicons.check_all : Coolicons.check,
                size: 18,
                color: isRead ? const Color(0xFF9333EA) : Colors.grey,
              ),
              const SizedBox(height: 2),
              Text(
                receipt['readTime'],
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: isRead ? const Color(0xFF9333EA) : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

