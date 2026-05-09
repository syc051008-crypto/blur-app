import 'package:flutter/material.dart';

import '../data/user_data.dart';
import 'login_page.dart';
import '../widgets/input_box.dart';
import '../widgets/main_button.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback onNicknameChanged;

  const ProfilePage({
    super.key,
    required this.onNicknameChanged,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nicknameController.text = currentNickname;
  }

  void changeNickname() {
    final newNickname = nicknameController.text.trim();

    if (newNickname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('닉네임을 입력해주세요.')),
      );
      return;
    }

    currentNickname = newNickname;
    widget.onNicknameChanged();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('닉네임이 변경되었습니다.')),
    );

    setState(() {});
  }

  void logout() {
    currentNickname = '';

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final nickname = currentNickname.isEmpty ? '사용자' : currentNickname;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F2FF),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF3B3355),
        ),
        title: const Text(
          '프로필 설정',
          style: TextStyle(
            color: Color(0xFF3B3355),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.75),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFB89CFF).withOpacity(0.25),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 52,
                      backgroundColor: Color(0xFFE8DCFF),
                      child: Icon(
                        Icons.person_outline,
                        size: 58,
                        color: Color(0xFF6D5A9D),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    nickname,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B3355),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '오늘도 꿈을 기록하러 왔군요 🌙',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF7A6C9D),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 34),
            Row(
              children: const [
                Expanded(
                  child: _ProfileStatCard(
                    title: '총 꿈 기록',
                    value: '0개',
                    icon: Icons.nightlight_round,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _ProfileStatCard(
                    title: '이번 달',
                    value: '0개',
                    icon: Icons.calendar_month_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(
                  child: _ProfileStatCard(
                    title: '연속 기록',
                    value: '0일',
                    icon: Icons.local_fire_department_outlined,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _ProfileStatCard(
                    title: '대표 감정',
                    value: '몽환',
                    icon: Icons.auto_awesome,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 34),
            const Text(
              '닉네임 변경',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B3355),
              ),
            ),
            const SizedBox(height: 14),
            InputBox(
              controller: nicknameController,
              hintText: '새 닉네임',
              icon: Icons.edit_outlined,
            ),
            const SizedBox(height: 18),
            MainButton(
              text: '닉네임 저장하기',
              onPressed: changeNickname,
            ),
            const SizedBox(height: 28),
            
            SizedBox(
              width: double.infinity,
              height: 58,
              child: OutlinedButton(
                onPressed: logout,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFFFF8A9A),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  backgroundColor: Colors.white.withOpacity(0.5),
                ),
                child: const Text(
                  '로그아웃',
                  style: TextStyle(
                    color: Color(0xFFE85D75),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
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

class _ProfileStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _ProfileStatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.72),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE2D7FF),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF8A6CFF),
            size: 24,
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3B3355),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF7A6C9D),
            ),
          ),
        ],
      ),
    );
  }
}

