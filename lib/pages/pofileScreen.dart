import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/todo_controller.dart';

class Profile_Screen extends StatelessWidget {
  final TodoController todocontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                  "https://i.pinimg.com/736x/98/1d/b6/981db6bd8ddaf7d9bb381e502913dcd6.jpg",
                ),
              ),
            ),

            const SizedBox(height: 20),
            Divider(),
            Text(
              "Username: ${todocontroller.username}",
              style: TextStyle(fontSize: 18),
            ),
            Divider(),
            Text(
              "Password: ${todocontroller.password}",
              style: TextStyle(fontSize: 18),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(20),

              child: Obx(() {
                return Column(
                  children: [
                    Card(
                      color: Colors.amber,
                      child: ListTile(
                        title: const Text("Total Tasks"),
                        trailing: Text(
                          todocontroller.totalTasks.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),

                    Card(
                      color: Colors.amber,
                      child: ListTile(
                        title: const Text("Completed Tasks"),
                        trailing: Text(
                          todocontroller.completedTasks.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),

                    Card(
                      color: Colors.amber,
                      child: ListTile(
                        title: const Text("Pending Tasks"),
                        trailing: Text(
                          todocontroller.pendingTasks.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
