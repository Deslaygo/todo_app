import 'package:todo_app/models/category_fields.dart';

class Category {
  String? name;
  String? documentId;
  CategoryFields? fields;
  DateTime? createTime;
  DateTime? updateTime;

  Category({
    this.name,
    this.documentId,
    this.fields,
    this.createTime,
    this.updateTime,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json['name'],
        documentId: json['name'].toString().substring(json['name'].length - 20),
        fields: CategoryFields.fromJson(json['fields']),
        createTime: DateTime.parse(json['createTime']),
        updateTime: DateTime.parse(json['updateTime']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'fields': fields?.toJson(),
        'createTime': createTime?.toIso8601String(),
        'updateTime': updateTime?.toIso8601String(),
      };
}
