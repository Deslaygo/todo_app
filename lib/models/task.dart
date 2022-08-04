import 'package:todo_app/models/task_fields.dart';

class Task {
  String? name;
  String? documentId;
  TaskFields? fields;
  DateTime? createTime;
  DateTime? updateTime;

  Task({
    this.name,
    this.documentId,
    this.fields,
    this.createTime,
    this.updateTime,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        name: json['name'],
        documentId:
            json['name'].toString().substring(json['name']!.length - 20),
        fields: TaskFields.fromJson(json['fields']),
        createTime: DateTime.parse(json['createTime']),
        updateTime: DateTime.parse(json['updateTime']),
      );

  String getDocumentId() => name!.substring(name!.length - 20);
}
