import 'package:cursed_city/models/task_model.dart';
import 'package:cursed_city/presentation/home/home_screen.dart';
import 'package:cursed_city/repository/preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> progressAnimation;
  double progressValue = 0.0;
  int balance = 1000;
  int slotStage = 1;
  List<TaskModel> tasks = [
    TaskModel(text: 'Win 10,000 Chips'),
    TaskModel(text: 'Get 3 matches in the slot.'),
    TaskModel(text: 'Make 10 spins.'),
    TaskModel(text: 'Win 20,000 Chips'),
    TaskModel(text: 'Get matches in all three rows simultaneously'),
  ];
  bool isBdEmpty = false;

  @override
  void onInit() async {
    super.onInit();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    progressAnimation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        progressValue = progressAnimation.value;
        update();
      });

    controller.forward();

    await _getBalance();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offAll(
          () => HomeScreen(
            balanceFormBd: balance,
            slotStageFromBd: slotStage,
            tasksFromBd: tasks,
            isBdEmpty: isBdEmpty,
          ),
        );
      }
    });

    update();
  }

  Future<void> _getBalance() async {
    final getBalanceResult = await Preferences.instance.getBalance();
    final getSlotStageResult = await Preferences.instance.getSlotStage();
    final getTaskListResult = await Preferences.instance.getTaskList();
    if (getBalanceResult != null) {
      balance = getBalanceResult;
    }
    if (getSlotStageResult != null) {
      slotStage = getSlotStageResult;
    }
    if (getTaskListResult.isNotEmpty) {
      tasks = getTaskListResult;
    }
    if (getBalanceResult == null &&
        getSlotStageResult == null &&
        getTaskListResult.isEmpty) {
      isBdEmpty = !isBdEmpty;
    }
    update();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
