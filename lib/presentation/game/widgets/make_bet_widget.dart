import 'package:flutter/material.dart';

class MakeBetWidget extends StatelessWidget {
  const MakeBetWidget({
    super.key,
    required this.onMinusTap,
    required this.onAddTap,
    required this.controller,
  });

  final VoidCallback onMinusTap;
  final VoidCallback onAddTap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: onMinusTap,
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/action_container.png'),
              ),
            ),
            child: Image.asset(
              'assets/images/minus.png',
            ),
          ),
        ),
        Container(
          width: 127,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bet_container.png'),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 14,
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
          ),
        ),
        GestureDetector(
          onTap: onAddTap,
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/action_container.png'),
              ),
            ),
            child: Image.asset(
              'assets/images/add.png',
            ),
          ),
        ),
      ],
    );
  }
}
