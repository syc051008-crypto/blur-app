import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'home_page.dart';

import '../widgets/input_box.dart';
import '../widgets/main_button.dart';
import '../widgets/google_button.dart';
import '../data/user_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이메일과 비밀번호를 올바르게 입력해주세요.'),
        ),
      );
      return;
    }

    final emailExists = users.any(
      (user) => user['email'] == email,
    );

    if (!emailExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('회원가입이 되지 않은 이메일입니다. 먼저 회원가입해주세요.'),
        ),
      );
      return;
    }

    final loginUser = users.firstWhere(
      (user) =>
          user['email'] == email &&
          user['password'] == password,
      orElse: () => {},
    );

    if (loginUser.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('비밀번호가 올바르지 않습니다.'),
        ),
      );
      return;
    }

    currentNickname = loginUser['nickname'] ?? '';

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }

  void goToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SignupPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2FF),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 90),

              const Center(
                child: Text(
                  'blur',
                  style: TextStyle(
                    fontSize: 54,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    color: Color(0xFF3B3355),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  '모호한 밤의 기억을 선명하게',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF7A6C9D),
                  ),
                ),
              ),

              const SizedBox(height: 70),

              const Text(
                '로그인',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B3355),
                ),
              ),

              const SizedBox(height: 24),

              InputBox(
                controller: emailController,
                hintText: '이메일',
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 16),

              InputBox(
                controller: passwordController,
                hintText: '비밀번호',
                icon: Icons.lock_outline,
                obscureText: true,
              ),

              const SizedBox(height: 28),

              MainButton(
                text: '이메일로 로그인',
                onPressed: login,
              ),

              const SizedBox(height: 14),

              GoogleButton(
                text: 'Google로 계속하기',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Google 로그인은 나중에 연결할 예정입니다.'),
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  const Text(
                    '아직 계정이 없나요?',
                    style: TextStyle(
                      color: Color(0xFF7A6C9D),
                    ),
                  ),

                  TextButton(
                    onPressed: goToSignup,

                    child: const Text(
                      '회원가입',
                      style: TextStyle(
                        color: Color(0xFF7E61FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}