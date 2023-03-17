import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:study_evaluation/services/notifications/local_notification_service.dart';
import 'package:study_evaluation/utils/function_lib.dart';
import 'package:study_evaluation/utils/notification_utils.dart';
import 'package:study_evaluation/view/views/aboutus_view.dart';

import 'package:study_evaluation/view/views/category_list_view.dart';
import 'package:study_evaluation/view/views/contact_us_view.dart';
import 'package:study_evaluation/view/views/current_affairs_view.dart';
import 'package:study_evaluation/view/views/edit_profile_view.dart';
import 'package:study_evaluation/view/views/exam_view.dart';
import 'package:study_evaluation/view/views/feedback_view.dart';
import 'package:study_evaluation/view/views/feedbackalertdialog.dart';

import 'package:study_evaluation/view/views/home_view.dart';
import 'package:study_evaluation/view/views/login_home.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:study_evaluation/view/views/notifications_view.dart';
import 'package:study_evaluation/view_models/notifications_list_vm.dart';

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
  debug("_backgroundHandler");

  /* Navigator.push(
      NotificationUtil.context!,
      MaterialPageRoute(
          builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                      create: (_) => NotificationsListViewModel())
                ],
                child: const NotificationView(),
              ))); */
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
        "/testseries": (context) => const CategoryListView(),
        "/about_us": (context) => const AboutUsScreen(),
        "/contact_us": (context) => const ContactUsView(),
        "/current_affairs": (context) => const CurrentAffairsView(),
        "/edit_profile": (context) => const EditProfileView(),
        "/exam": (context) => ExamView(
              examId: '',
              userId: '',
            ),
        "/feedback": (context) => const FeedbackView(),
        "/feedback_alertdialog": (context) => const FeedbackAlertDialog(),
      },
    );
  }
}
