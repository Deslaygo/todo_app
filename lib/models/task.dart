import 'package:todo_app/models/task_fields.dart';

class Task {
  String? name;
  TaskFields? fields;
  DateTime? createTime;
  DateTime? updateTime;

  Task({
    this.name,
    this.fields,
    this.createTime,
    this.updateTime,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        name: json['name'],
        fields: TaskFields.fromJson(json['fields']),
        createTime: DateTime.parse(json['createTime']),
        updateTime: DateTime.parse(json['updateTime']),
      );
}
