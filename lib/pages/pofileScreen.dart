import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/todo_controller.dart';

class Profile_Screen extends StatelessWidget {
  final Todocontroller = Get.find<TodoController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.account_box, size: 60),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username: " + Todocontroller.username,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Password: " + Todocontroller.password,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
