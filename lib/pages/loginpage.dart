import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/pages/otpScreen.dart';
import '../controller/todo_controller.dart';
import '../pages/todo_list.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  final TodoController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('mybox');

    return Scaffold(
      // appBar: AppBar(
      //   //title: Center(child: Text("Login Page")),
      //   //backgroundColor: Colors.amberAccent,
      // ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFf7971e), Color(0xFFffd200)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      "https://static.vecteezy.com/system/resources/thumbnails/011/976/274/small/stick-figures-welcome-free-vector.jpg",
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Email
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// Password
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (emailController.text ==
                                "adityashirsat1170@gmail.com" &&
                            passwordController.text == "aditya1170") {
                          box.put('isLoggedIn', true);
                          box.put('username', emailController.text);
                          box.put('password', passwordController.text);

                          Get.off(() => TodoList());
                        } else {
                          Get.snackbar(
                            "INVALID",
                            "TRY AGAIN",
                            duration: Duration(seconds: 1),
                          );
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                  const Divider(),
                  const SizedBox(height: 20),

                  /// Phone
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      labelText: "Phone Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// Send OTP Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.message, color: Colors.black),
                      label: const Text(
                        "Send OTP",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        String phone = phoneController.text.trim();

                        if (phone.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Enter phone number",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          return;
                        }

                        if (phone.length != 10) {
                          Get.snackbar(
                            "Error",
                            "Enter valid 10 digit phone number",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          return;
                        }

                        authController.sendOtp("+91$phone");
                        Get.to(() => OtpScreen());
                      },
                    ),
                  ),

                  const SizedBox(height: 25),
                  const Divider(),
                  const SizedBox(height: 25),

                  /// Google Sign In
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      icon: const Icon(
                        Icons.g_mobiledata,
                        size: 30,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "Sign in with Google",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.amber),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        authController.login();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
