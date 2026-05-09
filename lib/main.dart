import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const BlurApp());
}

class BlurApp extends StatelessWidget {
  const BlurApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'blur',
      theme: ThemeData(fontFamily: 'sans'),
      home: const LoginPage(),
    );
  }
}