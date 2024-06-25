import 'package:flutter/cupertino.dart';

class SlotItemWidget extends StatelessWidget {
  const SlotItemWidget({
    super.key,
    required this.items,
    required this.controller,
    required this.slotStage,
  });

  final List<String> items;
  final AnimationController controller;
  final int slotStage;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return SizedBox(
          height: height * (slotStage == 1 ? 0.42 : 0.5),
          width: 100,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemExtent: slotStage == 1 ? height * 0.138 : height * 0.121,
            itemCount: items.length,
            itemBuilder: (context, i) {
              double offset = controller.value * items.length * 80.0;
              int index = (i + offset ~/ 80) % items.length;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 12,
                ),
                child: Image.asset(items[index]),
              );
            },
          ),
        );
      },
    );
  }
}
