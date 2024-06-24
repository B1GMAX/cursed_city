import 'package:flutter/material.dart';

class AnswerWidget extends StatelessWidget {
  const AnswerWidget({
    super.key,
    required this.text,
    required this.ontTap,
  });

  final VoidCallback ontTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: GestureDetector(
        onTap: ontTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.transparent,
            shadows: [Shadow(color: Colors.white, offset: Offset(0, -5))],
            fontSize: 16,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
            decorationColor: Color(0xFF04D9FE),
            decorationThickness: 2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
