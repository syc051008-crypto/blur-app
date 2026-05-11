import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DreamStoragePage extends StatelessWidget {
  const DreamStoragePage({super.key});

  String formatDate(Timestamp? timestamp) {
    if (timestamp == null) {
      return '날짜 없음';
    }

    final date = timestamp.toDate();

    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F2FF),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF3B3355),
        ),
        title: const Text(
          '해몽보관함',
          style: TextStyle(
            color: Color(0xFF3B3355),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('dreams')
            .orderBy('timestamp', descending: true)
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFB89CFF),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                '꿈 기록을 불러오는 중 오류가 발생했어요.',
                style: TextStyle(
                  color: Color(0xFF7A6C9D),
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                '아직 저장된 꿈이 없어요.',
                style: TextStyle(
                  color: Color(0xFF7A6C9D),
                  fontSize: 16,
                ),
              ),
            );
          }

          final dreams = snapshot.data!.docs;

          return ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: dreams.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 14);
            },
            itemBuilder: (context, index) {
              final dream = dreams[index].data() as Map<String, dynamic>;

              final content = dream['content'] ?? '';
              final timestamp = dream['timestamp'] as Timestamp?;

              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.72),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFE2D7FF),
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8DCFF),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Text(
                            '꿈 기록',
                            style: TextStyle(
                              color: Color(0xFF6D5A9D),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),

                        const Spacer(),

                        Text(
                          formatDate(timestamp),
                          style: const TextStyle(
                            color: Color(0xFF9A8DB8),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      '내가 기록한 꿈',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3B3355),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      content,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Color(0xFF7A6C9D),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: const [
                        Icon(
                          Icons.auto_awesome,
                          size: 18,
                          color: Color(0xFF8A6CFF),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'AI 해몽 결과 준비 중',
                          style: TextStyle(
                            color: Color(0xFF8A6CFF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xFF9A8DB8),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}