import 'dart:async';
import 'dart:math';

import 'package:cursed_city/consts/consts.dart';
import 'package:cursed_city/models/task_model.dart';
import 'package:cursed_city/presentation/home/home_screen.dart';
import 'package:cursed_city/repository/preferences/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GameController extends GetxController with GetTickerProviderStateMixin {
  final int? balanceFormBd;
  final int? slotStageFromBd;
  final List<TaskModel>? tasksFromBd;

  GameController({
    required this.balanceFormBd,
    required this.slotStageFromBd,
    required this.tasksFromBd,
  });

  late final AnimationController controller1;
  late final AnimationController controller2;
  late final AnimationController controller3;
  Timer? _timer;
  TextEditingController betController = TextEditingController(text: '0');
  int balance = 1000;
  int generalChipBalance = 0;
  int matchesCount = 0;
  int spinCount = 0;
  bool isMegaWin = false;
  bool startGame = false;
  int chipsCount = 0;
  int slotStage = 1;
  int storyCount = 1;
  bool showTasks = false;
  bool showEmptyBalance = false;
  bool showFinalStory = false;
  String storyText =
      "Hi. I'm Maria, and I'm one of the few left in this cursed town. This used to be a place of joy and winnings, but now... look around.";

  List<String> slotListItems1 = [];

  List<String> slotListItems2 = [];

  List<String> slotListItems3 = [];

  @override
  void onInit() {
    super.onInit();
    controller1 =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller3 =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    if (balanceFormBd != null) {
      balance = balanceFormBd!;
    }
    if (slotStageFromBd != null) {
      slotStage = slotStageFromBd!;
    } else {
      startGame = false;
    }
    if (tasksFromBd != null) {
      tasks = tasksFromBd!;
    }



    slotListItems1.addAll(defaultSLot1Items1);
    slotListItems2.addAll(defaultSLot1Items2);
    slotListItems3.addAll(defaultSLot1Items3);
    update();
  }

  void _shuffleItems() {
    slotListItems1.shuffle();
    slotListItems2.shuffle();
    slotListItems3.shuffle();
    update();
  }

  void updateBalance(int newBalance) {
    balance += newBalance;
    showEmptyBalance = !showEmptyBalance;
    Preferences.instance.saveBalance(balance);
    update();
  }

  int _getRandomNumber() {
    var rng = Random();
    int min = 150;
    int max = 350;
    int randomNumber = min + rng.nextInt(max - min + 1);
    return randomNumber;
  }

  void startSpinning() {
    if (balance < int.parse(betController.text)) {
      showEmptyBalance = !showEmptyBalance;
      update();
      return;
    } else {
      showEmptyBalance = false;
    }
    slotListItems1.clear();
    slotListItems2.clear();
    slotListItems3.clear();
    if (slotStage == 1) {
      slotListItems1.addAll(defaultSLot1Items1);
      slotListItems2.addAll(defaultSLot1Items2);
      slotListItems3.addAll(defaultSLot1Items3);
    } else {
      slotListItems1.addAll(defaultSlot2Items1);
      slotListItems2.addAll(defaultSlot2Items2);
      slotListItems3.addAll(defaultSlot2Items3);
    }

    _shuffleItems();
    const int spinDuration = 3;
    controller1.repeat(period: Duration(milliseconds: _getRandomNumber()));
    controller2.repeat(period: Duration(milliseconds: _getRandomNumber()));
    controller3.repeat(period: Duration(milliseconds: _getRandomNumber()));

    _timer = Timer(const Duration(seconds: spinDuration), () {
      controller1.stop();
      controller2.stop();
      controller3.stop();
      _checkResult();
    });
    spinCount += 1;
    update();
  }

  void _checkResult() {
    int index1 = _getIndex(controller1.value, slotListItems1);
    int index2 = _getIndex(controller2.value, slotListItems2);
    int index3 = _getIndex(controller3.value, slotListItems3);

    List<String> row1 = _getRow(index1, index2, index3, 0);
    List<String> row2 = _getRow(index1, index2, index3, 1);
    List<String> row3 = _getRow(index1, index2, index3, 2);
    List<String> row4 = _getRow(index1, index2, index3, 3);

    if (spinCount == 10) {
      _crossTask('Make 10 spins.');
      Preferences.instance.saveTaskList(tasks);
      showTasks = !showTasks;
    }
    _checkLoosOrWin(row1, row2, row3, row4);
    Preferences.instance.saveBalance(balance);
    update();
  }

  void _checkLoosOrWin(List<String> row1, List<String> row2, List<String> row3,
      List<String> row4) {
    final bool isWin = slotStage == 1
        ? _allElementsEqual(row1) ||
            _allElementsEqual(row2) ||
            _allElementsEqual(row3)
        : _allElementsEqual(row1) ||
            _allElementsEqual(row2) ||
            _allElementsEqual(row3) ||
            _allElementsEqual(row4);

    final bool isMegaWin = slotStage == 1
        ? _allElementsEqual(row1) &&
            _allElementsEqual(row2) &&
            _allElementsEqual(row3)
        : _allElementsEqual(row1) &&
            _allElementsEqual(row2) &&
            _allElementsEqual(row3) &&
            _allElementsEqual(row4);

    if (isMegaWin) {
      _getBalanceAfterMegaWin();
    }
    if (isWin) {
      _getBalanceResultAfterWin();
    } else {
      _getBalanceResultAfterLoos();
    }
    update();
  }

  int _getIndex(double value, List<String> slotListItems) {
    return (value * slotListItems.length).floor() % slotListItems.length;
  }

  List<String> _getRow(int index1, int index2, int index3, int number) {
    return [
      slotListItems1[(index1 + number) % slotListItems1.length],
      slotListItems2[(index2 + number) % slotListItems2.length],
      slotListItems3[(index3 + number) % slotListItems3.length]
    ];
  }

  bool _allElementsEqual(List<String> items) {
    final result = items.every((element) => element == items[0]);

    return result;
  }

  void closeMegaWin() {
    _crossTask('Get matches in all three rows simultaneously', isMegaWin);
    isMegaWin = !isMegaWin;
    update();
  }

  void checkIsAllTaskFinished() {
    showFinalStory = tasks.every((element) => element.isCrossed);
    update();
  }

  void changeSlotStage() {
    slotStage = 2;
    Preferences.instance.saveSlotStage(slotStage);
    showFinalStory = !showFinalStory;
    for (int i = 0; i < tasks.length; i++) {
      tasks[i] = tasks[i].copyWith(isCrossed: false);
    }
    Preferences.instance.saveTaskList(tasks);
    slotListItems1.clear();
    slotListItems2.clear();
    slotListItems3.clear();
    slotListItems1.addAll(defaultSlot2Items1);
    slotListItems2.addAll(defaultSlot2Items2);
    slotListItems3.addAll(defaultSlot2Items3);
    update();
  }

  void _getBalanceAfterMegaWin() {
    isMegaWin = !isMegaWin;
    balance += 1000000;

    _crossTask('Get matches in all three rows simultaneously');

    update();
  }

  void _getBalanceResultAfterWin() {
    final prise = int.parse(betController.text) * 5;
    balance += prise;
    chipsCount += prise;
    generalChipBalance += prise;
    betController.text = '0';
    matchesCount += 1;
    if (chipsCount >= 10000) {
      _crossTask('Win 10,000 Chips');
      showTasks = !showTasks;
    }
    if (chipsCount >= 20000) {
      _crossTask('Win 20,000 Chips');
      showTasks = !showTasks;
    }
    if (matchesCount == 3) {
      _crossTask('Get 3 matches in the slot.');
      showTasks = !showTasks;
    }
    Preferences.instance.saveTaskList(tasks);
    update();
  }

  void _crossTask(String text, [bool? isMegaWin]) {
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].text == text && !tasks[i].isCrossed) {
        tasks[i] = tasks[i].copyWith(isCrossed: true);
        if (text == 'Get matches in all three rows simultaneously' &&
            isMegaWin != null &&
            !isMegaWin) {
          showTasks = !showTasks;
        }
      }
    }
    update();
  }

  void _getBalanceResultAfterLoos() {
    balance -= int.parse(betController.text);
    betController.text = '0';
    update();
  }

  void increaseBet() {
    int bet = int.parse(betController.text);
    bet += 10;
    betController.text = bet.toString();

    update();
  }

  void next() {
    showTasks = !showTasks;
    update();
  }

  void finishGame() async {
    (await Preferences.instance.pref).clear();

    Get.offAll(
      () => HomeScreen(
        balanceFormBd: balanceFormBd,
        slotStageFromBd: slotStageFromBd,
        tasksFromBd: tasksFromBd,
        isBdEmpty: true,
      ),
    );
  }

  void decreaseBet() {
    int bet = int.parse(betController.text);
    if (bet != 0 && bet > 0) {
      bet -= 10;
      betController.text = bet.toString();
    }
    update();
  }

  List<TaskModel> tasks = [
    TaskModel(text: 'Win 10,000 Chips'),
    TaskModel(text: 'Get 3 matches in the slot.'),
    TaskModel(text: 'Make 10 spins.'),
    TaskModel(text: 'Win 20,000 Chips'),
    TaskModel(text: 'Get matches in all three rows simultaneously'),
  ];

  void changeStory() {
    storyCount++;

    if (storyCount == 2) {
      storyText =
          "I stayed because my grandfather owned one of these casinos. I want to restore the town to its former glory, but I can't do it alone.";
    }
    if (storyCount == 3) {
      storyText =
          "I can't leave until the curse is lifted. I have a scroll that explains how to lift the curse. But to do that, we need to complete several challenges in the casino.";
    }
    if (storyCount == 5) {
      storyText =
          "These tasks symbolize the stages of happiness and luck that were once part of this town. If we complete them, the curse will be lifted, and the town will return to its former glory.";
    }
    if (storyCount == 6) {
      storyText =
          "I live with the hope that we can bring this town back. If the curse is lifted, people will start coming back, and the town will come alive again.";
    }
    if (storyCount == 4 || storyCount == 7) {
      showTasks = !showTasks;
    } else {
      showTasks = false;
    }

    update();
  }

  String getNotFinishedTask() {
    final task = tasks.firstWhere((element) => !element.isCrossed);

    if (task.text == 'Win 10,000 Chips') {
      return '$chipsCount/10000 Chips';
    }
    if (task.text == 'Get 3 matches in the slot.') {
      return '$matchesCount/3 Matches';
    }
    if (task.text == 'Make 10 spins.') {
      return '$spinCount/10 Spins';
    }
    if (task.text == 'Win 20,000 Chips') {
      return '$chipsCount/20000 Chips';
    }
    if (task.text == 'Get matches in all three rows simultaneously') {
      return 'Get matches in all three rows simultaneously';
    }

    return '';
  }

  void start() {
    startGame = !startGame;
    showTasks = !showTasks;
    Preferences.instance.saveSlotStage(slotStage);
    update();
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }
}
