import 'package:flutter/material.dart';
import 'home_page.dart';

import '../widgets/input_box.dart';
import '../widgets/main_button.dart';
import '../widgets/google_button.dart';

import '../data/user_data.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final nicknameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signup() {

    if (nicknameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('모든 정보를 입력해주세요.'),
        ),
      );

      return;
    }

    bool alreadyExists = users.any(
      (user) => user['email'] == emailController.text,
    );

    if (alreadyExists) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이미 가입된 이메일입니다.'),
        ),
      );

      return;
    }

    users.add({
      'nickname': nicknameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });

    currentNickname = nicknameController.text.trim();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('회원가입 완료!'),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(),
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

              const SizedBox(height: 30),

              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                icon: const Icon(
                  Icons.arrow_back_ios_new,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                '회원가입',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B3355),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'blur에서 오늘의 꿈을 기록해보세요.',
                style: TextStyle(
                  color: Color(0xFF7A6C9D),
                ),
              ),

              const SizedBox(height: 40),

              InputBox(
                controller: nicknameController,
                hintText: '닉네임',
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 16),

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
                text: '회원가입',
                onPressed: signup,
              ),

              const SizedBox(height: 14),

              GoogleButton(
                text: 'Google로 회원가입',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}