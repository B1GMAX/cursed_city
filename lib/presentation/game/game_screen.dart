import 'package:cursed_city/models/task_model.dart';
import 'package:cursed_city/presentation/customs/custom_app_bar.dart';
import 'package:cursed_city/presentation/game/controller/controller.dart';
import 'package:cursed_city/presentation/game/widgets/slot_screen.dart';
import 'package:cursed_city/presentation/game/widgets/story_screen.dart';
import 'package:cursed_city/presentation/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({
    super.key,
    this.balanceFormBd,
    this.slotStageFromBd,
    this.tasksFromBd,
  });

  final int? balanceFormBd;
  final int? slotStageFromBd;
  final List<TaskModel>? tasksFromBd;

  @override
  Widget build(BuildContext context) {
    print('slotStageFromBd - $slotStageFromBd');
    return GetBuilder(
      init: GameController(
        balanceFormBd: balanceFormBd,
        slotStageFromBd: slotStageFromBd,
        tasksFromBd: tasksFromBd,
      ),
      builder: (controller)
      {
           return   Stack(
                children: [
                  slotStageFromBd == null
                      ? controller.startGame
                          ? SlotScreen(
                              balanceFormBd: balanceFormBd,
                              slotStageFromBd: slotStageFromBd,
                              tasksFromBd: tasksFromBd,
                            )
                          : StoryScreen(
                              balanceFormBd: balanceFormBd,
                              slotStageFromBd: slotStageFromBd,
                              tasksFromBd: tasksFromBd,
                            )
                      : SlotScreen(
                          balanceFormBd: balanceFormBd,
                          slotStageFromBd: slotStageFromBd,
                          tasksFromBd: tasksFromBd,
                        ),
                  Positioned(
                    top: 26,
                    left: 25,
                    right: 25,
                    child: CustomAppBar(
                      balance: controller.balance.toString(),
                      onTap: () => Get.to(
                        () => HomeScreen(
                          balanceFormBd: controller.balance,
                          slotStageFromBd: controller.slotStage,
                          tasksFromBd: controller.tasks,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            });
  }
}
