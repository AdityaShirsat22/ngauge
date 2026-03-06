import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:todo_list/controller/todo_controller.dart';

class CustomSearchDelegate extends SearchDelegate {
  final TodoController controller = Get.put(TodoController());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = controller.model.where((todo) {
      return todo.title!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final todo = results[index];

        return ListTile(
          title: Text(todo.title ?? ""),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = controller.model.where((todo) {
      return todo.title!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final todo = suggestions[index];

        return Column(
          children: [
            SizedBox(height: 3),
            ListTile(
              tileColor: Color.fromARGB(255, 232, 215, 60),
              leading: Icon(Icons.location_city),

              title: Text(todo.title ?? ""),
            ),
            SizedBox(height: 3),
          ],
        );
      },
    );
  }
}
