import 'package:get/get_navigation/get_navigation.dart';
import 'package:todo_app/routes/routes.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/tasks/add_task_screen.dart';

final List<GetPage> pages = [
  GetPage(name: Routes.homeScreen, page: () => HomeScreen()),
  GetPage(name: Routes.addTaskScreen, page: () => const AddTaskScreen()),
];
