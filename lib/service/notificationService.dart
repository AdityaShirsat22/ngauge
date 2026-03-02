import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificationservice {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //object responsible for displaying local notification
  FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initLocalNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher"); //app icon used for notification

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    flutterLocalNotificationPlugin.initialize(initializationSettings);
  }

  //requesting use for the notification permission
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true, //popup in the screen
      badge: true, //no of notification on app icon
      criticalAlert: true, // high priority notification
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("permission granted by the use");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("Permission granted provisionally");
    } else {
      print("permission denied by user");
    }
  }

  // very important method for push notification functions
  Future<String> getFCMtoken() async {
    String? token = await messaging.getToken();
    print(token);
    return token!;
  }

  void showNotification(RemoteMessage msg) {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'high_importance_channel',
          "High Importance Channel",
          importance: Importance.high,
          priority: Priority.high,
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    flutterLocalNotificationPlugin.show(
      0,
      msg.notification?.title ?? "no title",
      msg.notification?.body ?? "no body",
      notificationDetails,
    );
  }
}
