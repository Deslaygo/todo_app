import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task? task;
  const TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskController>();
    return CheckboxListTile(
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      checkboxShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: Color(0XFFDADADA),
      enableFeedback: false,
      contentPadding: const EdgeInsets.only(left: 0, top: 0, bottom: 0),
      value: task?.fields?.isCompleted,
      title: Text(
        '${task?.fields?.name}',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(
        task?.category?.fields?.name ?? '',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      onChanged: (value) {
        task?.fields?.isCompleted = value;
        taskController.updateTask(task!);
      },
    );
  }
}
