import 'package:cursed_city/models/task_model.dart';
import 'package:cursed_city/presentation/customs/button_widget.dart';
import 'package:cursed_city/presentation/game/widgets/tasks_widget.dart';
import 'package:flutter/cupertino.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({
    super.key,
    required this.showButton,
    this.topPosition = 100,
    required this.onTap,
    required this.buttonText,
    required this.tasks,
  });

  final bool showButton;
  final double topPosition;
  final VoidCallback onTap;
  final String buttonText;
  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: topPosition,
          left: 25,
          right: 25,
          child: TasksWidget(tasks: tasks),
        ),
       if(showButton) Positioned(
          bottom: 90,
          child: ButtonWidget(
            text: buttonText,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
