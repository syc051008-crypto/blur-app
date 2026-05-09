import 'package:flutter/material.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  final searchController = TextEditingController();

  final List<Map<String, String>> friends = [
    {'name': '수민', 'status': '어젯밤 꿈을 기록했어요'},
    {'name': '지훈', 'status': '오늘은 아직 기록이 없어요'},
    {'name': '예린', 'status': '악몽을 길몽으로 해석했어요'},
    {'name': '민서', 'status': '새로운 꿈을 공유했어요'},
    {'name': '하준', 'status': '3일 연속 꿈을 기록 중이에요'},
  ];

  String searchText = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredFriends = friends.where((friend) {
      final name = friend['name'] ?? '';
      return name.contains(searchText);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F2FF),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF3B3355),
        ),
        title: const Text(
          '친구 관리',
          style: TextStyle(
            color: Color(0xFF3B3355),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.75),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFFE2D7FF),
                ),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchText = value.trim();
                  });
                },
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.search,
                    color: Color(0xFF6D5A9D),
                  ),
                  hintText: '친구 검색',
                  hintStyle: const TextStyle(
                    color: Color(0xFF9A8DB8),
                  ),
                  border: InputBorder.none,
                  suffixIcon: searchText.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            searchController.clear();
                            setState(() {
                              searchText = '';
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Color(0xFF9A8DB8),
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                const Text(
                  '내 친구',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3B3355),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${filteredFriends.length}명',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF7A6C9D),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Expanded(
              child: filteredFriends.isEmpty
                  ? const Center(
                      child: Text(
                        '검색 결과가 없어요.',
                        style: TextStyle(
                          color: Color(0xFF7A6C9D),
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: filteredFriends.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 12);
                      },
                      itemBuilder: (context, index) {
                        final friend = filteredFriends[index];

                        return Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.72),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFFE2D7FF),
                            ),
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 26,
                                backgroundColor: Color(0xFFE8DCFF),
                                child: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFF6D5A9D),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      friend['name']!,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF3B3355),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      friend['status']!,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF7A6C9D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: Color(0xFF9A8DB8),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.person_add_alt_1),
                label: const Text(
                  '친구 추가하기',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB89CFF),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}