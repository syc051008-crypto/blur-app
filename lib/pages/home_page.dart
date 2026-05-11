import 'package:flutter/material.dart';

import '../data/user_data.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'friend_page.dart';
import 'dream_storage_page.dart';
import 'dream_journal_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime currentMonth = DateTime(2026, 5);

  final Map<String, List<int>> dreamDaysByMonth = {};

  void goToPreviousMonth() {
    setState(() {
      currentMonth = DateTime(
        currentMonth.year,
        currentMonth.month - 1,
      );
    });
  }

  void goToNextMonth() {
    setState(() {
      currentMonth = DateTime(
        currentMonth.year,
        currentMonth.month + 1,
      );
    });
  }

  int getDaysInMonth() {
    return DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    ).day;
  }

  int getFirstWeekday() {
    final firstDay = DateTime(
      currentMonth.year,
      currentMonth.month,
      1,
    );

    return firstDay.weekday % 7;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2FF),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _topBar(),
                    _greeting(),
                    _monthHeader(),
                    _weekHeader(),
                    _calendar(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            _bottomNav(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFB89CFF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const DreamJournalPage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfilePage(
                    onNicknameChanged: () {
                      setState(() {});
                    },
                  ),
                ),
              );
            },
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xFFE8DCFF),
              child: Icon(
                Icons.person_outline,
                color: Color(0xFF6D5A9D),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Text(
            currentNickname.isEmpty ? '사용자' : currentNickname,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3B3355),
            ),
          ),

          const Spacer(),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsPage(),
                ),
              );
            },
            child: const Icon(
              Icons.settings_outlined,
              size: 30,
              color: Color(0xFF3B3355),
            ),
          ),
        ],
      ),
    );
  }

  Widget _greeting() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 900),
      tween: Tween<double>(
        begin: 0,
        end: 1,
      ),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 14, 24, 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '${currentNickname.isEmpty ? '사용자' : currentNickname}님, 어젯밤엔 어떤 꿈을 꾸셨나요?',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _monthHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: goToPreviousMonth,
            icon: const Icon(
              Icons.chevron_left,
              size: 34,
              color: Color(0xFF6D5A9D),
            ),
          ),

          const SizedBox(width: 18),

          Text(
            '${currentMonth.year}년 ${currentMonth.month}월',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3B3355),
            ),
          ),

          const SizedBox(width: 18),

          IconButton(
            onPressed: goToNextMonth,
            icon: const Icon(
              Icons.chevron_right,
              size: 34,
              color: Color(0xFF6D5A9D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _weekHeader() {
    const weeks = ['일', '월', '화', '수', '목', '금', '토'];

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 25, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weeks.map((day) {
          return SizedBox(
            width: 38,
            child: Center(
              child: Text(
                day,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6D5A9D),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _calendar() {
    final daysInMonth = getDaysInMonth();
    final firstWeekday = getFirstWeekday();

    final monthKey = '${currentMonth.year}-${currentMonth.month}';
    final dreamDays = dreamDaysByMonth[monthKey] ?? [];

    final totalCells = firstWeekday + daysInMonth;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: totalCells,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 14,
          crossAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          if (index < firstWeekday) {
            return const SizedBox();
          }

          final day = index - firstWeekday + 1;

          final hasDream = dreamDays.contains(day);

          final today = DateTime.now();

          final isToday =
              today.year == currentMonth.year &&
              today.month == currentMonth.month &&
              today.day == day;

          return Stack(
            alignment: Alignment.center,
            children: [
              if (isToday)
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB89CFF).withOpacity(0.35),
                    shape: BoxShape.circle,
                  ),
                ),

              Text(
                '$day',
                style: TextStyle(
                  fontSize: 20,
                  color: isToday
                      ? const Color(0xFF5B3FD6)
                      : const Color(0xFF332B4A),
                  fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
                ),
              ),

              if (hasDream)
                Positioned(
                  top: 1,
                  right: 6,
                  child: Icon(
                    Icons.star,
                    size: 18,
                    color: Colors.yellow.shade600,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _bottomNav() {
  return Container(
    height: 82,
    padding: const EdgeInsets.symmetric(horizontal: 22),
    decoration: const BoxDecoration(
      color: Color(0xFFEFE7FF),
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(28),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const _NavItem(
          icon: Icons.calendar_month_outlined,
          label: '캘린더',
        ),
        const _NavItem(
          icon: Icons.auto_stories_outlined,
          label: '해몽보관함',
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const FriendPage(),
              ),
            );
          },
          child: const _NavItem(
            icon: Icons.group_outlined,
            label: '친구 관리',
          ),
        ),
      ],
    ),
  );
}}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: const Color(0xFF6D5A9D),
          size: 28,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6D5A9D),
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}