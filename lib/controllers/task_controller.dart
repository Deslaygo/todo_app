import 'package:get/get.dart';
import 'package:todo_app/helpers/api_helper.dart';
import 'package:todo_app/models/task.dart';

class TaskController extends GetxController {
  final _tasks = RxList<Task>([]);

  List<Task> get tasks => _tasks;

  List<Task> get tasksIncomplete =>
      tasks.where((ts) => ts.fields?.isCompleted == false).toList();

  List<Task> get tasksCompleted =>
      tasks.where((ts) => ts.fields?.isCompleted == true).toList();

  Future<void> getTasks(Map<String, dynamic> parameters) async {
    try {
      _tasks.value = [];

      final data = await ApiHelper.get('tasks', parameters);

      if (data != null) {
        data.forEach((json) => _tasks.add(Task.fromJson(json)));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateTask(Task task) async {
    final index = _tasks.indexWhere((ts) => ts.documentId == task.documentId);

    _tasks[index] = task;
  }
}
