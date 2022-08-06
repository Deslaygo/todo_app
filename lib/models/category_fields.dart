class CategoryFields {
  String? color;
  String? name;

  CategoryFields({
    this.color,
    this.name,
  });

  factory CategoryFields.fromJson(Map<String, dynamic> json) => CategoryFields(
        color: json['color']['stringValue'],
        name: json['name']['stringValue'],
      );

  Map<String, dynamic> toJson() => {
        'color': {'stringValue': color},
        'name': {'stringValue': name},
      };
}
