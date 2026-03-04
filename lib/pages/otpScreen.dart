import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_list/controller/todo_controller.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final TodoController controller = Get.find();

  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(
              "https://img.freepik.com/premium-vector/otp-authentication-secure-verification_7087-3082.jpg",
            ),
            SizedBox(height: 30),
            Pinput(
              length: 6,
              autofocus: true,
              controller: otpController,
              
            ),

            // TextField(
            //   controller: otpController,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(labelText: "Enter OTP"),
            // ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                String otp = otpController.text.trim();

                if (otp.isEmpty) {
                  Get.snackbar(
                    "Error",
                    "Enter OTP",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                if (otp.length != 6) {
                  Get.snackbar(
                    "Error",
                    "Enter valid OTP",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                controller.verifyOtp(otp);
              },

              child: Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
