import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:study_evaluation/services/notifications/local_notification_service.dart';

import 'package:study_evaluation/view/views/category_list_view.dart';

import 'package:study_evaluation/view/views/home_view.dart';
import 'package:study_evaluation/view/views/login_home.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

/* Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}  */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationService.initialize();

  FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  runApp(const MyApp());
}

Future<void> _backgroundHandler(RemoteMessage message) async {
  return Future.value();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //NotificationUtil(context);
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    // ignore: prefer_const_constructors

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        "/login": (context) => const LoginHome(),
        "/testseries": (context) => const CategoryListView()
      },
    );
  }
}
