import 'package:flutter/material.dart';

class StoryContainerWidget extends StatelessWidget {
  const StoryContainerWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.244,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/dialog_container.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
      padding: const EdgeInsets.all(27),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
