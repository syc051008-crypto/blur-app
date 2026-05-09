import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;

  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(

      onPressed: onPressed,

      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFB89CFF),
        minimumSize: const Size(double.infinity, 58),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),

      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}