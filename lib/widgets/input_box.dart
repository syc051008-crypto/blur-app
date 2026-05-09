import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;

  const InputBox({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: controller,
      obscureText: obscureText,

      decoration: InputDecoration(

        prefixIcon: Icon(
          icon,
          color: const Color(0xFF7A6C9D),
        ),

        hintText: hintText,

        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}