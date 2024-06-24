import 'dart:ui';

import 'package:cursed_city/models/task_model.dart';
import 'package:cursed_city/presentation/chips_store/widgets/chip_widget.dart';
import 'package:cursed_city/presentation/customs/custom_app_bar.dart';
import 'package:cursed_city/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChipStoreScreen extends StatelessWidget {
  const ChipStoreScreen({
    super.key,
    required this.balanceFormBd,
    required this.slotStageFromBd,
    required this.tasksFromBd,
  });

  final int? balanceFormBd;
  final int? slotStageFromBd;
  final List<TaskModel>? tasksFromBd;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/bg/first_bg.png',
              width: width,
              fit: BoxFit.fill,
            ),
            Positioned(
              left: 23,
              right: 23,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2,
                  sigmaY: 2,
                ),
                child: Column(
                  children: [
                    CustomAppBar(
                      balance: balanceFormBd.toString(),
                      onTap: () => Get.to(
                        HomeScreen(
                          balanceFormBd: balanceFormBd,
                          slotStageFromBd: slotStageFromBd,
                          tasksFromBd: tasksFromBd,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChipWidget(
                          amount: 100000,
                          price: '0,99 USD',
                          index: 0,
                          onTap: (amount) {
                            Get.back(result: amount);
                          },
                        ),
                        ChipWidget(
                          amount: 700000,
                          price: '1,99 USD',
                          index: 1,
                          onTap: (amount) {
                            Get.back(result: amount);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChipWidget(
                          amount: 5000000,
                          price: '3,99 USD',
                          index: 2,
                          onTap: (amount) {
                            Get.back(result: amount);
                          },
                        ),
                        ChipWidget(
                          amount: 10000000,
                          price: '8,99 USD',
                          index: 3,
                          onTap: (amount) {
                            Get.back(result: amount);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
