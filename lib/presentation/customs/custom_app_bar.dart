import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.balance,
    required this.onTap,
    this.isHomaPage = false,
    this.playMusic = false,
  });

  final String balance;
  final VoidCallback onTap;
  final bool isHomaPage;
  final bool playMusic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/icon_container.png'),
                ),
              ),
              child: isHomaPage
                  ? const Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 18,
                    )
                  : Image.asset(
                      'assets/images/${playMusic ? 'no_music' : 'music'}.png'),
            ),
          ),
          SizedBox(
            width: 150,
            height: 40,
            child: Stack(
              children: [
                Positioned(
                  top: 5,
                  right: 0,
                  child: Container(
                    width: 137,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D1D44),
                      border: Border.all(
                        color: const Color(0xFF07D5FE),
                      ),
                    ),
                    padding: const EdgeInsets.only(right: 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        child: Text(
                          balance,
                        ),
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/chip.png',
                  height: 40,
                  width: 40,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
