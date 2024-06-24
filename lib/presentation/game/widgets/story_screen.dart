import 'package:cursed_city/models/task_model.dart';
import 'package:cursed_city/presentation/game/controller/controller.dart';
import 'package:cursed_city/presentation/game/widgets/story_container_widget.dart';
import 'package:cursed_city/presentation/game/widgets/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'answers_widget.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({
    super.key,
    required  this.balanceFormBd,
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
        child: GetBuilder<GameController>(
            init: GameController(
              balanceFormBd: balanceFormBd,
              slotStageFromBd: slotStageFromBd,
              tasksFromBd: tasksFromBd,
            ),
            builder: (controller) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    controller.storyCount < 4
                        ? 'assets/bg/story_bg_1.png'
                        : 'assets/bg/story_bg_2.png',
                    width: width,
                    fit: BoxFit.fill,
                  ),
                  controller.showTasks
                      ? TaskScreen(
                          showButton: controller.storyCount == 7,
                          onTap: controller.start,
                          buttonText: 'Start',
                          tasks: controller.tasks,
                          topPosition: controller.storyCount != 7 ? 30 : 100,
                        )
                      : Positioned(
                          top: 90,
                          left: 25,
                          right: 25,
                          child:
                              StoryContainerWidget(text: controller.storyText),
                        ),
                  if (controller.storyCount != 7)
                    Positioned(
                      bottom: 0,
                      left: 70,
                      child: Image.asset(
                        'assets/images/girl.png',
                        height: controller.showTasks ? 370 : 460,
                      ),
                    ),
                  if (controller.storyCount != 7)
                    Positioned(
                      left: 25,
                      right: 25,
                      bottom: 15,
                      child: AnswersWidget(
                        storyCount: controller.storyCount,
                        ontTap: controller.changeStory,
                      ),
                    ),
                ],
              );
            }),
      ),
    );
  }
}
