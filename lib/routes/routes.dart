import 'package:get/route_manager.dart';

class Routes {
  static void fnRoutingCallback(Routing routing) {
    switch (routing.current) {
      case '/':
        break;
    }
  }

  static const homeScreen = '/home';
  static const addTaskScreen = '/add-task';
}
