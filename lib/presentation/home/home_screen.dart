import 'package:cursed_city/models/task_model.dart';
import 'package:cursed_city/presentation/chips_store/chips_store_screen.dart';
import 'package:cursed_city/presentation/customs/button_widget.dart';
import 'package:cursed_city/presentation/customs/custom_app_bar.dart';
import 'package:cursed_city/presentation/home/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.balanceFormBd,
    required this.slotStageFromBd,
    required this.tasksFromBd,
    this.isBdEmpty = false,
  });

  final int? balanceFormBd;
  final int? slotStageFromBd;
  final List<TaskModel>? tasksFromBd;
  final bool isBdEmpty;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return SafeArea(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/bg/first_bg.png',
                    width: width,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    top: 26,
                    left: 25,
                    right: 25,
                    child: CustomAppBar(
                      balance: balanceFormBd.toString(),
                      onTap: controller.playPause,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonWidget(
                          text: 'NEW GAME',
                          onTap: () {
                            controller.goToGameScreen(
                              balanceFormBd,
                              slotStageFromBd,
                              tasksFromBd,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        ButtonWidget(
                          isBdEmpty: isBdEmpty,
                          text: 'CONTINUE',
                          onTap: isBdEmpty
                              ? () {}
                              : () {
                                  controller.goToGameScreen(
                                    balanceFormBd,
                                    slotStageFromBd,
                                    tasksFromBd,
                                  );
                                },
                        ),
                        const SizedBox(height: 20),
                        ButtonWidget(
                          text: 'STORE',
                          onTap: () => Get.to(
                            () => ChipStoreScreen(
                              balanceFormBd: balanceFormBd,
                              slotStageFromBd: slotStageFromBd,
                              tasksFromBd: tasksFromBd,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
