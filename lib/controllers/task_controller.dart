import 'dart:convert';

import 'package:get/get.dart';
import 'package:todo_app/helpers/api_helper.dart';
import 'package:todo_app/models/task.dart';

class TaskController extends GetxController {
  final tasks = RxList<Task>([]);

  Future<void> getTasks(Map<String, dynamic> parameters) async {
    try {
      tasks.value = [];

      final data = await ApiHelper.get('tasks', parameters);

      if (data != null) {
        data.forEach((json) => tasks.add(Task.fromJson(json)));
      }
    } catch (e) {
      rethrow;
    }
  }
}
