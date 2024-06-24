import 'package:cursed_city/presentation/customs/button_widget.dart';
import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    super.key,
    required this.amount,
    required this.price,
    required this.index,
    required this.onTap,
  });

  final int amount;
  final String price;
  final int index;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 19),
      child: Stack(
        children: [
          Container(
            width: 150,
            height: 180,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/container.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 25,
            child: Column(
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    border: Border.all(
                      color: const Color(0xFF1A8BC0),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                  ),
                  child: Center(
                    child: Text(
                      amount.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/chip_$index.png',
                  height: index == 1 ? 90 : 75,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 5,
            child: ButtonWidget(
              width: 140,
              height: 43,
              text: price,
              smallButton: true,
              onTap: () {
                onTap(amount);
              },
            ),
          ),
        ],
      ),
    );
  }
}
