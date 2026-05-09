import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;

  const GoogleButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return OutlinedButton(

      onPressed: onPressed,

      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 58),

        side: const BorderSide(
          color: Color(0xFFD6C8FF),
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),

      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF3B3355),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}