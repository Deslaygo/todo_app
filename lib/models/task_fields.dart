class TaskFields {
  String? categoryId;
  bool? isCompleted;
  int? date;
  String? name;

  TaskFields({
    this.categoryId,
    this.isCompleted,
    this.date,
    this.name,
  });

  factory TaskFields.fromJson(Map<String, dynamic> json) => TaskFields(
        categoryId: json['categoryId'] == null
            ? null
            : json['categoryId']['stringValue'].toString(),
        isCompleted: json['isCompleted'] == null
            ? null
            : json['isCompleted']['booleanValue'],
        date: json['date'] == null
            ? null
            : int.tryParse(json['date']['integerValue'].toString()),
        name: json['name'] == null
            ? null
            : json['name']['stringValue'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'categoryId': categoryId,
        'isCompleted': isCompleted,
        'date': date,
        'name': name,
      };
}
