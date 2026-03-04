import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/todo_controller.dart';
import 'package:todo_list/pages/pofileScreen.dart';

// ignore: must_be_immutable
class TodoList extends StatelessWidget {
  TodoList({super.key});
  TextEditingController textEditingController = TextEditingController();
  final TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(Profile_Screen(), transition: Transition.leftToRight);
          },
          icon: Icon(Icons.account_circle, size: 30),
        ),
        title: const Text("T O D O"),
        centerTitle: true,
        backgroundColor: Colors.amber,

        actions: [
          //logout button
          TextButton(
            onPressed: () {
              Get.defaultDialog(
                backgroundColor: Colors.brown[200],
                middleText: "Are Your Sure",
                middleTextStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textCancel: "cancel",
                cancelTextColor: Colors.black,
                textConfirm: "Logout",
                confirmTextColor: Colors.white,
                buttonColor: const Color.fromARGB(255, 236, 202, 30),
                onCancel: () {
                  Get.back();
                },
                onConfirm: () {
                  //Hive.box('mybox').clear();

                  controller.logout();
                },
              );
            },
            child: Text("logout", style: TextStyle(color: Colors.black)),
          ),
          SizedBox(width: 10),
        ],
      ),

      //Bottom navigation bar
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.amber),
              ),
              onPressed: () {
                Get.defaultDialog(
                  title: "Enter new Task",
                  content: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                hint: Text("Enter task"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (textEditingController.text.isNotEmpty) {
                                await controller.postTodos(
                                  textEditingController.text,
                                );
                                textEditingController.clear();
                                Get.back();
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.amber,
                              ),
                            ),
                            child: const Text("Save"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: Text("ADD NEW", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: const Text(
                  "All todos",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.model.length,
                    itemBuilder: (context, i) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.place_outlined),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                controller.model[i].title ?? "",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                textEditingController.text =
                                    controller.model[i].title ?? "";

                                Get.defaultDialog(
                                  title: "Edit Task",
                                  content: Column(
                                    children: [
                                      TextFormField(
                                        controller: textEditingController,
                                        decoration: const InputDecoration(
                                          hintText: "Edit task",
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            style: const ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                    Colors.amber,
                                                  ),
                                            ),
                                            onPressed: () async {
                                              if (textEditingController
                                                  .text
                                                  .isNotEmpty) {
                                                await controller.updateTodo(
                                                  controller.model[i].id!,
                                                  textEditingController.text,
                                                  i,
                                                );
                                                textEditingController.clear();
                                                Get.back();
                                              }
                                            },
                                            child: const Text("Update"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),

                            IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "DELETE",
                                  content: Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              controller.deleteTodos(
                                                controller.model[i].id!,
                                              );
                                              Get.back();
                                            },
                                            child: Text("Delete"),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                    Colors.amber,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
