import 'package:todo_app/models/category.dart';
import 'package:todo_app/models/task_fields.dart';

class Task {
  String? name;
  String? documentId;
  TaskFields? fields;
  DateTime? createTime;
  DateTime? updateTime;
  Category? category;

  Task({
    this.name,
    this.documentId,
    this.fields,
    this.createTime,
    this.updateTime,
    this.category,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        name: json['name'],
        documentId:
            json['name'].toString().substring(json['name']!.length - 20),
        fields: TaskFields.fromJson(json['fields']),
        createTime: DateTime.parse(json['createTime']),
        updateTime: DateTime.parse(json['updateTime']),
        category: json['category'] == null
            ? null
            : Category.fromJson(json['category']),
      );

  String getDocumentId() => name!.substring(name!.length - 20);
}
