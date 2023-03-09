import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:study_evaluation/services/notifications/local_notification_service.dart';
import 'package:study_evaluation/utils/notification_utils.dart';
import 'package:study_evaluation/view/views/category_list_view.dart';

import 'package:study_evaluation/view/views/home_view.dart';
import 'package:study_evaluation/view/views/login_home.dart';

/* Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}  */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _firebaseMessaging = await Firebase.initializeApp();

  LocalNotificationService.initialize();
  runApp(MyApp());
}

Future<void> _backgroundHandler(RemoteMessage message) async {
  print("Backgroun message");
  print(message.data.toString());
  print(message.notification!.title);
  print(message.notification!.body);
  return Future.value();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotificationUtil(context);
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    // ignore: prefer_const_constructors
    return MaterialApp(
      initialRoute: "/login",
      routes: {
        "/": (context) => const HomeView(),
        "/login": (context) => const LoginHome(),
        "/testseries": (context) => const CategoryListView()
      },
    );
  }
}
