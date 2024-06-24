import 'package:cursed_city/presentation/customs/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MegaWinWidget extends StatelessWidget {
  const MegaWinWidget({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/mega_glow.png',
          width: width,
          fit: BoxFit.fill,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/mega_win.png'),
            const SizedBox(height: 30),
            Image.asset('assets/images/1ml.png'),
            const SizedBox(height: 60),
            ButtonWidget(
              text: 'GET',
              onTap: onTap,
            ),
          ],
        ),
      ],
    );
  }
}
