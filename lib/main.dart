import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:study_evaluation/services/notifications/local_notification_service.dart';
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
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  LocalNotificationService.initialize();
  runApp(MyApp());
}

Future<void> _backgroundHandler(RemoteMessage message) async {
  print("Backgroun message");
  print(message.data.toString());
  print(message.notification!.title);
  print(message.notification!.body);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        "/": (context) => const HomeView(),
        "/login": (context) => const LoginHome(),
        "/testseries": (context) => const CategoryListView()
      },
    );
  }
}
