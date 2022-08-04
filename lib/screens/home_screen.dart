import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/app_controller.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/utils/app_assets.dart';
import 'package:todo_app/widgest/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateFormat dateFormat = DateFormat('MMM d, yyyy');
  String currentDate = '';
  bool _isInit = true;
  final appController = Get.find<AppController>();
  final taskController = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();
    currentDate = dateFormat.format(DateTime.now());
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isInit = false;
      setState(() {});
      await getTasks();
    }
    super.didChangeDependencies();
  }

  Future getTasks() async {
    try {
      appController.isLoading.value = true;
      print('get tasks');
      final parameters = <String, dynamic>{};
      await taskController.getTasks(parameters);
      appController.isLoading.value = false;
    } catch (error) {
      appController.isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = taskController.tasks.value;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
        ),
        body: GetX<AppController>(
          init: AppController(),
          builder: ((controller) {
            return controller.isLoading.value
                ? CustomProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 16),
                        SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                currentDate,
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.grey[100],
                                radius: 32,
                                child: Image.asset(
                                  AppAssets.defaultUser,
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          '5 incomplete, 5 completed',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Divider(),
                        ),
                        Text(
                          'Incomplete',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: tasks.length,
                            itemBuilder: (context, i) {
                              return Text('${tasks[i].fields!.name}');
                            }),
                        SizedBox(height: 32),
                        Text(
                          'Completed',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                  );
          }),
        ));
  }
}
