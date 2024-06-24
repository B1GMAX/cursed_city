import 'package:collection/collection.dart';
import 'package:cursed_city/models/task_model.dart';
import 'package:flutter/material.dart';

class TasksWidget extends StatelessWidget {
  const TasksWidget({super.key, required this.tasks});

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.538,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/sheet.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          ...tasks.mapIndexed((index, task) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 45,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                          color: const Color(0xFFB78A5A).withOpacity(0.5),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        task.text,
                        style: TextStyle(
                          color: const Color(0xFF391500),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          decoration: task.isCrossed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationThickness: 2.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
