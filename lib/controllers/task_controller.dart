import 'package:get/get.dart';
import 'package:todo_app/controllers/app_controller.dart';
import 'package:todo_app/controllers/categoy_controller.dart';
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
      final categoryController = Get.find<CategoryController>();
      final appController = Get.find<AppController>();
      await appController.validateToken();

      await categoryController.getCategories(parameters);

      final data = await ApiHelper.get('tasks', parameters);

      if (data != null) {
        data.forEach((json) {
          final categoryId =
              json['fields']['categoryId']['stringValue'].toString();
          final category = categoryController.getCategoryById(categoryId);
          json['category'] = category?.toJson();
          final task = Task.fromJson(json);
          _tasks.add(task);
        });
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future updateTask(Task task) async {
    final appController = Get.find<AppController>();
    await appController.validateToken();
    final index = _tasks.indexWhere((ts) => ts.documentId == task.documentId);

    final data = <String, dynamic>{};

    data['date'] = {'integerValue': task.fields?.date};
    data['categoryId'] = {'stringValue': task.fields?.categoryId};
    data['name'] = {'stringValue': task.fields?.name};
    data['isCompleted'] = {'booleanValue': task.fields?.isCompleted};

    final parameters = <String, dynamic>{
      'fields': data,
    };

    await ApiHelper.patch('tasks', task.documentId!, parameters);

    _tasks[index] = task;
  }

  Future addTask(Map<String, dynamic> parameters) async {
    final appController = Get.find<AppController>();
    await appController.validateToken();
    await ApiHelper.post('tasks', parameters);
    await getTasks(<String, dynamic>{});
  }
}
