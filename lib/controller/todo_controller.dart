import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/model/model.dart';
import "package:dio/dio.dart";
import 'package:todo_list/pages/loginpage.dart';
import 'package:todo_list/pages/todo_list.dart';
import 'package:todo_list/service/notificationService.dart';

import '../service/auth_service.dart';

class TodoController extends GetxController {
  var model = RxList<TodoModel>();
  Dio dio = Dio();

  var todoList = [].obs;

  final AuthService _authService = AuthService();
  var isLoading = false.obs;

  String get username => Hive.box('mybox').get('username', defaultValue: "");
  String get password => Hive.box('mybox').get('password', defaultValue: "");

  int get totalTasks => model.length;

  int get completedTasks =>
      model.where((task) => task.isCompleted == true).length;

  int get pendingTasks =>
      model.where((task) => task.isCompleted != true).length;

  @override
  void onInit() {
    super.onInit();
    getTodos();

    Notificationservice service = Notificationservice();
    service.requestNotificationPermission();
    service.getFCMtoken();
    service.initLocalNotification();
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      service.showNotification(msg);
    });
  }

  //GET
  Future<RxList<TodoModel>> getTodos() async {
    try {
      final response = await dio.get(
        "https://699d402d83e60a406a459c39.mockapi.io/api/todolist",
      );

      if (response.statusCode == 200) {
        var data = response.data;

        model.clear();

        for (Map<String, dynamic> item in data) {
          model.add(TodoModel.fromJson(item));
        }
      }
    } catch (e) {
      print("Error fetching todos: $e");
    }

    return model;
  }

  //Post
  Future<void> postTodos(String title) async {
    try {
      final response = await dio.post(
        "https://699d402d83e60a406a459c39.mockapi.io/api/todolist",
        data: {"title": title},
      );

      if (response.statusCode == 201) {
        model.add(TodoModel.fromJson(response.data));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error while adding todo: $e");
      }
    }
  }

  //delete
  Future<void> deleteTodos(String id) async {
    try {
      final response = await dio.delete(
        "https://699d402d83e60a406a459c39.mockapi.io/api/todolist/$id",
      );

      if (response.statusCode == 200) {
        print("done");
        model.clear();
        getTodos();
      } else {
        print("failed");
      }
    } catch (e) {
      print("Error while adding todo: $e");
    }
  }

  //update
  Future<void> updateTodo(String id, String newTitle, int index) async {
    try {
      final response = await dio.put(
        "https://699d402d83e60a406a459c39.mockapi.io/api/todolist/$id",
        data: {"title": newTitle},
      );
      if (response.statusCode == 200) {
        model[index] = TodoModel.fromJson(response.data);
        model.refresh();
      }
    } catch (e) {
      print("Update Error: $e ");
    }
  }

  //login
  Future<void> login() async {
    final user = await _authService.signInWithGoogle();

    print("USER IS: $user");

    if (user != null) {
      Get.offAll(() => TodoList());
    } else {
      print("Login failed or returned null");
    }
  }

  //logout
  Future<void> logout() async {
    await _authService.signOut();
    Get.offAll(() => LoginPage());
  }

  // Send OTP
  void sendOtp(String phone) async {
    try {
      isLoading.value = true;
      await _authService.sendOtp(phone);
      Get.snackbar("Success", "OTP Sent", duration: Duration(seconds: 1));
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Verify OTP
  void verifyOtp(String otp) async {
    try {
      isLoading.value = true;

      final user = await _authService.verifyOtp(otp);

      if (user != null) {
        Get.offAll(TodoList());
      } else {
        Get.snackbar(
          "Error",
          "Invalid OTP",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Wrong OTP", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  List searchTodos(String query) {
    return todoList.where((todo) {
      final title = todo.title.toLowerCase();
      final input = query.toLowerCase();

      return title.contains(input);
    }).toList();
  }

  //update status
  Future<void> updateStatus(String id, bool status) async {
    try {
      await dio.put(
        "https://699d402d83e60a406a459c39.mockapi.io/api/todolist/$id",
        data: {"isCompleted": status},
      );

      getTodos(); // refresh list
    } catch (e) {
      print("Status update error: $e");
    }
  }
}
