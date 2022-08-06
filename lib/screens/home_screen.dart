// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/app_controller.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/routes/routes.dart';
import 'package:todo_app/utils/app_assets.dart';
import 'package:todo_app/utils/utils.dart';
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

  DateTime selectedDate = DateTime.now();

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
      await loadData();
    }
    super.didChangeDependencies();
  }

  Future loadData() async {
    try {
      appController.loading(true);

      final parameters = <String, dynamic>{};
      await taskController.getTasks(parameters);

      appController.loading(false);
    } catch (error) {
      appController.loading(false);
      Utils.showSnackbarError('Tasks', error.toString());
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 15)),
        lastDate: DateTime(2200));

    if (pickedDate != null) {
      Get.toNamed(Routes.addTaskScreen, arguments: <String, dynamic>{
        'date': pickedDate.toIso8601String(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _selectDate(context),
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
        ),
        body: GetX<AppController>(
          init: AppController(),
          builder: ((controller) {
            return controller.isLoading
                ? CustomProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 16),
                          HeaderHome(currentDate: currentDate),
                          Text(
                            '${taskController.tasksIncomplete.length} incomplete, ${taskController.tasksCompleted.length} completed',
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
                              padding:
                                  const EdgeInsets.only(top: 32, bottom: 32),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: taskController.tasksIncomplete.length,
                              itemBuilder: (context, i) {
                                final task = taskController.tasksIncomplete[i];
                                return TaskItem(task: task);
                              }),
                          Text(
                            'Completed',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: taskController.tasksCompleted.length,
                              itemBuilder: (context, i) {
                                final task = taskController.tasksCompleted[i];
                                return TaskItem(task: task);
                              }),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                  );
          }),
        ));
  }
}
