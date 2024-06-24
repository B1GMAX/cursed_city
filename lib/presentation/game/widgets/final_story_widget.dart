import 'package:cursed_city/presentation/customs/button_widget.dart';
import 'package:flutter/material.dart';

class FinalStoryWidget extends StatelessWidget {
  const FinalStoryWidget({
    super.key,
    required this.onTap,
    required this.slotStage,
  });

  final VoidCallback onTap;
  final int slotStage;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          slotStage == 1
              ? 'assets/bg/slot_screen_bg_2.png'
              : 'assets/bg/bg_3.png',
          fit: BoxFit.fill,
          width: width,
        ),
        Positioned(
          top: height * 0.142,
          left: 25,
          right: 25,
          child: Container(
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/dialog_container.png'),
                fit: BoxFit.fill,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            child: Center(
              child: Text(
                slotStage == 1
                    ? "Something's happening! It looks like everything is starting to heal! Look!"
                    : "Thank you for your help. Together, we've lifted the curse and restored the town. I couldn't have done it without you.",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Image.asset(
            'assets/images/girl.png',
            height: height * 0.637,
          ),
        ),
        slotStage == 1
            ? Positioned(
                bottom: 30,
                right: 30,
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/${slotStage == 1 ? 'icon_container' : 'button'}.png'),
                      ),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : Positioned(
                bottom: 30,
                child: ButtonWidget(text: 'LEAVE', onTap: onTap),
              ),
      ],
    );
  }
}
