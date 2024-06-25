import 'package:cursed_city/presentation/customs/button_widget.dart';
import 'package:flutter/material.dart';

class BuyChipsWidget extends StatelessWidget {
  const BuyChipsWidget({super.key, required this.onTap,});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.45,
      width: width,
      child: Stack(
        children: [
          Positioned(
            left: 30,
            bottom: 0,
            child: Image.asset(
              'assets/images/girl.png',
              height: 320,
            ),
          ),
          Positioned(
            bottom: 90,
            right: 50,
            child: Container(
              width: height * 0.316,
              height: width * 0.27,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/dialog_container.png',
                  ),
                ),
              ),
              child: const Center(
                child: Text(
                  "You don't have enough chips to complete the task",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 90,
            child: SizedBox(
              height: 42,
              width: width * 0.327,
              child: ButtonWidget(
                smallButton: true,
                text: 'BUY CHIPS',
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
