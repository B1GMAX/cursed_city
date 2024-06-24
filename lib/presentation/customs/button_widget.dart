import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
    this.smallButton = false,
    this.height,
    this.width,
    this.isBdEmpty = false,
  });

  final String text;
  final VoidCallback onTap;
  final bool smallButton;
  final double? height;
  final double? width;
  final bool isBdEmpty;

  @override
  Widget build(BuildContext context) {
    final widthMediaQuery = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 66,
        width: width ?? widthMediaQuery * 0.55,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/button.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Amarante',
              color: isBdEmpty ? const Color(0xFF4D4D4D) : Colors.white,
              fontSize: smallButton ? 14 : 22,
            ),
          ),
        ),
      ),
    );
  }
}
