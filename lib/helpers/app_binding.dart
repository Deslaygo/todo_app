import 'package:get/get.dart';
import 'package:todo_app/controllers/app_controller.dart';
import 'package:todo_app/controllers/categoy_controller.dart';
import 'package:todo_app/controllers/task_controller.dart';

class AppBinding {
  //En este metodo se definen todos los controller para ser inicializados
  static void bindingControllers() {
    Get.put(AppController(), permanent: true);
    Get.put(CategoryController(), permanent: true);
    Get.put(TaskController(), permanent: true);
  }
}
