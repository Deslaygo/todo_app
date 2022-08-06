import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/config_reader.dart';
import 'package:todo_app/helpers/app_binding.dart';
import 'package:todo_app/routes/pages.dart';
import 'package:todo_app/routes/routes.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDo',
      home: HomeScreen(),
      theme: AppTheme.getAppTheme(),
      defaultTransition: Transition.rightToLeft,
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(AppBinding.bindingControllers),
      getPages: pages,
      routingCallback: (routing) => Routes.fnRoutingCallback(routing!),
    );
  }
}
