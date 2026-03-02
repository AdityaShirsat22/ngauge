import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/todo_controller.dart';

class LoginPageGoogle extends StatelessWidget {
  LoginPageGoogle({super.key});

  final TodoController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          // if (authController.isLoading.value) {
          //   return CircularProgressIndicator();
          // }

          return ElevatedButton(
            onPressed: () {
              //authController.loginWithGoogle();
            },
            child: Text("Sign in with Google"),
          );
        }),
      ),
    );
  }
}
