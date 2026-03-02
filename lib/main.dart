import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/controller/todo_controller.dart';
import 'package:todo_list/pages/loginpage.dart';
import 'package:todo_list/pages/todo_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> _backgroundMessageHandle(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(TodoController());

  await Hive.initFlutter();
  await Hive.openBox("mybox");

  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandle);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final TodoController todoController = TodoController();

  @override
  Widget build(BuildContext context) {
    //var box = Hive.box('mybox');
    //bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);

    return GetMaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}
