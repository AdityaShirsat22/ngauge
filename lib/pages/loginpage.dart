import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../controller/todo_controller.dart';
import '../pages/todo_list.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final TodoController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('mybox');

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Login")),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.amber),
              ),
              onPressed: () {
                if (emailController.text == "aadi" &&
                    passwordController.text == "aadi") {
                  box.put('isLoggedIn', true);
                  box.put('username', emailController.text);
                  box.put('password', passwordController.text);

                  Get.off(() => TodoList());
                }
              },
              child: Text("Login", style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.amber),
              ),
              onPressed: () {
                authController.login();
              },
              child: Text(
                "Sign in with Google",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
