import 'package:cursed_city/models/task_model.dart';
import 'package:cursed_city/presentation/chips_store/chips_store_screen.dart';
import 'package:cursed_city/presentation/game/controller/controller.dart';
import 'package:cursed_city/presentation/game/widgets/buy_chips_widget.dart';
import 'package:cursed_city/presentation/game/widgets/final_story_widget.dart';
import 'package:cursed_city/presentation/game/widgets/make_bet_widget.dart';
import 'package:cursed_city/presentation/game/widgets/mega_win_widget.dart';
import 'package:cursed_city/presentation/game/widgets/slot_item_widget.dart';
import 'package:cursed_city/presentation/game/widgets/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SlotScreen extends StatelessWidget {
  const SlotScreen({
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
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GetBuilder<GameController>(
          init: GameController(
            balanceFormBd: balanceFormBd,
            slotStageFromBd: slotStageFromBd,
            tasksFromBd: tasksFromBd,
          ),
          builder: (controller) {
            return controller.showFinalStory
                ? FinalStoryWidget(
                    slotStage: controller.slotStage,
                    onTap: controller.slotStage == 1
                        ? controller.changeSlotStage
                        : controller.finishGame,
                  )
                : Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image.asset(
                        controller.showTasks
                            ? 'assets/bg/story_bg_2.png'
                            : 'assets/bg/slot_screen_bg_${controller.slotStage == 1 ? 1 : 2}.png',
                        width: width,
                        fit: BoxFit.fill,
                      ),
                      if (!controller.showTasks && !controller.isMegaWin) ...[
                        Positioned(
                          top: controller.slotStage == 1 ? 50 : 70,
                          left: controller.slotStage == 1 ? 0 : 23,
                          right: controller.slotStage == 1 ? 0 : 23,
                          child: Image.asset(
                            'assets/bg/slot_${controller.slotStage == 1 ? 1 : 2}_bg.png',
                            width: width,
                            height: height *
                                (controller.slotStage == 1 ? 0.55 : 0.58),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: controller.slotStage == 1 ? 125 : 87,
                          left: 23,
                          right: 23,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SlotItemWidget(
                                items: controller.slotListItems1,
                                controller: controller.controller1,
                                slotStage: controller.slotStage,
                              ),
                              SlotItemWidget(
                                items: controller.slotListItems2,
                                controller: controller.controller2,
                                slotStage: controller.slotStage,
                              ),
                              SlotItemWidget(
                                items: controller.slotListItems3,
                                controller: controller.controller3,
                                slotStage: controller.slotStage,
                              ),
                            ],
                          ),
                        ),
                        if (!controller.showEmptyBalance) ...[
                          Positioned(
                            bottom: height *
                                (controller.slotStage == 1 ? 0.25 : 0.141),
                            child: GestureDetector(
                              onTap: controller.next,
                              child: Container(
                                height: 74,
                                width: 257,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/chips_sheet.png',
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    controller.getNotFinishedTask(),
                                    style: const TextStyle(
                                      color: Color(0xFF391500),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: height *
                                (controller.slotStage == 1 ? 0.15 : 0.13),
                            child: GestureDetector(
                              onTap: controller.betController.text == '0' ||
                                      controller.betController.text.isEmpty
                                  ? () {}
                                  : controller.startSpinning,
                              child: Container(
                                height: 57,
                                width: 80,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/spin_button.png',
                                    ),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'SPIN',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: controller.slotStage == 1 ? 45 : 6,
                            left: 25,
                            right: 25,
                            child: MakeBetWidget(
                              onMinusTap: controller.decreaseBet,
                              onAddTap: controller.increaseBet,
                              controller: controller.betController,
                            ),
                          ),
                        ],
                        if (controller.showEmptyBalance)
                          Positioned(
                            bottom: 0,
                            child: BuyChipsWidget(
                              onTap: () async {
                                final result = await Get.to(
                                  () => ChipStoreScreen(
                                    balanceFormBd: balanceFormBd,
                                    slotStageFromBd: slotStageFromBd,
                                    tasksFromBd: tasksFromBd,
                                  ),
                                );
                                if (result != null) {
                                  controller.updateBalance(result);
                                }
                              },
                            ),
                          ),
                      ],
                      if (controller.showTasks) ...[
                        TaskScreen(
                          showButton: true,
                          onTap: controller.next,
                          buttonText: 'Next',
                          tasks: controller.tasks,
                        )
                      ],
                      if (controller.isMegaWin) ...[
                        MegaWinWidget(onTap: controller.closeMegaWin),
                      ],
                    ],
                  );
          },
        ),
      ),
    );
  }
}
