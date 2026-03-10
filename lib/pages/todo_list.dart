import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/todo_controller.dart';
import 'package:todo_list/pages/CategoryScreen.dart';
import 'package:todo_list/pages/customSearchDelegate.dart';
import 'package:todo_list/pages/pofileScreen.dart';

// ignore: must_be_immutable
class TodoList extends StatelessWidget {
  TodoList({super.key});
  TextEditingController textEditingController = TextEditingController();
  final TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(Profile_Screen(), transition: Transition.leftToRight);
          },
          icon: Icon(Icons.account_circle, size: 30),
        ),
        title: const Text(
          "T O D O",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
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

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: const Text(
                      "All todos",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 102, 102, 102),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(),
                      );
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.model.length,
                    itemBuilder: (context, i) {
                      final todo = controller.model[i];
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
                                todo.title ?? "",
                                style: TextStyle(
                                  fontSize: 18,
                                  decoration: todo.isCompleted == true
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ),

                            Checkbox(
                              value: todo.isCompleted ?? false,
                              onChanged: (value) {
                                controller.updateStatus(todo.id!, value!);
                              },
                            ),

                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                textEditingController.text = todo.title ?? "";

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
                                            onPressed: () => Get.back(),
                                            child: const Text("Cancel"),
                                          ),

                                          ElevatedButton(
                                            onPressed: () async {
                                              if (textEditingController
                                                  .text
                                                  .isNotEmpty) {
                                                await controller.updateTodo(
                                                  todo.id!,
                                                  textEditingController.text,
                                                  i,
                                                );

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
                            ),

                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "DELETE",
                                  content: Column(
                                    children: [
                                      const SizedBox(height: 20),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () => Get.back(),
                                            child: const Text("Cancel"),
                                          ),

                                          ElevatedButton(
                                            onPressed: () {
                                              controller.deleteTodos(todo.id!);
                                              Get.back();
                                            },
                                            child: const Text("Delete"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
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
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
          if (index == 1) {
            Get.to(() => Categoryscreen());
          }
        },
      ),
      floatingActionButton: Center(
        heightFactor: 0.2,
        widthFactor: 6.7,
        child: FloatingActionButton(
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
                          decoration: InputDecoration(hint: Text("Enter task")),
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
                          backgroundColor: WidgetStatePropertyAll(Colors.amber),
                        ),
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          backgroundColor: Color.fromARGB(255, 255, 226, 37),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
