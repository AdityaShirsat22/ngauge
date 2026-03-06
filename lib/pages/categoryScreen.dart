import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:todo_list/pages/todo_list.dart';

class Categoryscreen extends StatelessWidget {
  const Categoryscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CATEGORY", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 232, 205, 53),
      ),
      body: Text("hrllo"),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Get.off(() => TodoList());
          }
        },
      ),
    );
  }
}
