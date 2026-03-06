class TodoModel {
  String? id;
  String? title;
  String? description;
  bool? isCompleted;

  TodoModel({this.id, this.title, this.description, this.isCompleted});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "isCompleted": isCompleted,
    };
  }
}
