import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F2FF),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF3B3355)),
        title: const Text(
          '설정',
          style: TextStyle(
            color: Color(0xFF3B3355),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: const [
            _SettingTile(
              icon: Icons.lock_outline,
              title: '개인정보 및 공개 범위',
              subtitle: '꿈 공개 여부와 계정 정보를 관리해요',
            ),
            SizedBox(height: 14),
            _SettingTile(
              icon: Icons.dark_mode_outlined,
              title: '다크모드',
              subtitle: '어두운 테마를 사용할 수 있어요',
            ),
            SizedBox(height: 14),
            _SettingTile(
              icon: Icons.notifications_none,
              title: '알림 설정',
              subtitle: '꿈 기록 알림을 설정해요',
            ),
            SizedBox(height: 14),
            _SettingTile(
              icon: Icons.palette_outlined,
              title: '앱 테마',
              subtitle: 'blur의 색감과 분위기를 바꿔요',
            ),
            SizedBox(height: 14),
            _SettingTile(
              icon: Icons.mail_outline,
              title: '문의하기',
              subtitle: '버그 및 피드백을 보낼 수 있어요',
            ),
            SizedBox(height: 14),
            _SettingTile(
              icon: Icons.info_outline,
              title: '앱 정보',
              subtitle: 'blur version 1.0',
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE2D7FF),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFFE8DCFF),
            child: Icon(
              icon,
              color: const Color(0xFF6D5A9D),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3B3355),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF7A6C9D),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Color(0xFF9A8DB8),
          ),
        ],
      ),
    );
  }
}