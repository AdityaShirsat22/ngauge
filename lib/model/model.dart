class TodoModel {
  String? title;
  String? des;
  String? id;

  TodoModel({this.title, this.des, this.id});

  TodoModel.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    des = json["des"];
    id = json["id"];
  }

  static List<TodoModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(TodoModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["des"] = des;
    data["id"] = id;
    return data;
  }
}
