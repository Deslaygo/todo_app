// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/app_controller.dart';
import 'package:todo_app/controllers/categoy_controller.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/themes/color_palette.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgest/widgets.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  bool _isInit = true;
  final titleTxt = TextEditingController();
  final categoryTxt = TextEditingController();
  final dateTxt = TextEditingController();
  final categoryController = Get.find<CategoryController>();
  final taskController = Get.find<TaskController>();
  DateTime? selectedDate;
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  int selectedCategory = 0;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isInit = false;
      final arguments = Get.arguments as Map<String, dynamic>;
      updateDate(arguments['date'].toString());
    }
    super.didChangeDependencies();
  }

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate!,
        firstDate: DateTime.now().subtract(Duration(days: 15)),
        lastDate: DateTime(2200));

    if (pickedDate != null) updateDate(pickedDate.toIso8601String());
  }

  updateDate(String date) {
    selectedDate = DateTime.parse(date);
    dateTxt.text = dateFormat.format(selectedDate!);
    setState(() {});
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  Future<void> addTask() async {
    final appController = Get.find<AppController>();
    try {
      appController.loading(true);

      final data = <String, dynamic>{};

      final category = categoryController.categories[selectedCategory];

      data['date'] = {'integerValue': selectedDate?.millisecondsSinceEpoch};
      data['categoryId'] = {'stringValue': category.documentId};
      data['name'] = {'stringValue': titleTxt.text};
      data['isCompleted'] = {'booleanValue': false};

      final parameters = <String, dynamic>{
        'fields': data,
      };
      await taskController.addTask(parameters);
      appController.loading(false);
      Get.back();
    } catch (error) {
      appController.loading(false);
      Utils.showSnackbarError('Tasks', error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 155,
        leading: Row(
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              'To go back',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
      body: GetX<AppController>(
          init: AppController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'New Task',
                    style: context.textTheme.headline1?.copyWith(fontSize: 32),
                  ),
                  TextFormField(
                    controller: titleTxt,
                    decoration: Utils.getInputDecoration(hintText: 'Title'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: categoryTxt,
                    readOnly: true,
                    onTap: () => _showDialog(
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: true,
                        itemExtent: 32.0,
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          setState(() {
                            selectedCategory = selectedItem;
                          });
                          categoryTxt.text = categoryController
                                  .categories[selectedItem].fields?.name ??
                              '';
                        },
                        children: List<Widget>.generate(
                            categoryController.categories.length, (int index) {
                          return Center(
                            child: Text(
                              categoryController
                                      .categories[index].fields!.name ??
                                  '',
                            ),
                          );
                        }),
                      ),
                    ),
                    decoration: Utils.getInputDecoration(hintText: 'Category'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                      controller: dateTxt,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: Utils.getInputDecoration(
                        label: 'When?',
                        suffixIcon: Icon(
                          Icons.event,
                          color: primaryColor,
                        ),
                      )),
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      width: 95,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: controller.isLoading
                            ? null
                            : () {
                                addTask();
                              },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        child: Text(
                          'Add',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
