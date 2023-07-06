import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:study_evaluation/services/notifications/local_notification_service.dart';
import 'package:study_evaluation/utils/function_lib.dart';
import 'package:study_evaluation/view/views/aboutus_view.dart';

import 'package:study_evaluation/view/views/category_list_view.dart';
import 'package:study_evaluation/view/views/contact_us_view.dart';
import 'package:study_evaluation/view/views/current_affairs_view.dart';
import 'package:study_evaluation/view/views/edit_profile_view.dart';
import 'package:study_evaluation/view/views/exam_view.dart';
import 'package:study_evaluation/view/views/feedback_view.dart';
import 'package:study_evaluation/view/views/feedbackalertdialog.dart';
import 'package:study_evaluation/view/views/feedbacks_view.dart';
import 'package:study_evaluation/view/views/follow_us_view.dart';
import 'package:study_evaluation/view/views/forgetpassword_view.dart';
import 'package:study_evaluation/view/views/home_main_view.dart';

import 'package:study_evaluation/view/views/home_view.dart';
import 'package:study_evaluation/view/views/learderboard_view.dart';
import 'package:study_evaluation/view/views/login_home.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:study_evaluation/view/views/motivation_view.dart';
import 'package:study_evaluation/view/views/myorder_view.dart';
import 'package:study_evaluation/view/views/notifications_view.dart';
import 'package:study_evaluation/view/views/order_detail_view.dart';
import 'package:study_evaluation/view/views/package_detail_view.dart';
import 'package:study_evaluation/view/views/package_list_view.dart';
import 'package:study_evaluation/view/views/place_order_view.dart';
import 'package:study_evaluation/view/views/profile_view.dart';
import 'package:study_evaluation/view/views/signup_success.dart';
import 'package:study_evaluation/view/views/signup_view.dart';
import 'package:study_evaluation/view/views/splash_view.dart';
import 'package:study_evaluation/view/views/terms_conditions_view.dart';

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
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => const SplashView(),
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
        "/feedback_alertdialog": (context) => const FeedbackAlertDialog(),
        "/feedback": (context) => const FeedbackView(),
        "/feedBacks": (context) => const FeedBacksView(),
        "/follow_us": (context) => const FollowUsView(),
        "/forget_password": (context) => const ForgetPasswordView(),
        "/home": (context) => const HomeView(),
        "/home_main": (context) => HomeMainView(),
        "/learderbord": (context) => const LearderbordView(
              examId: null,
            ),
        "/motivation": (context) => const MotivationView(),
        "/myorder": (context) => const MyOrderView(),
        "/notification": (context) => const NotificationView(),
        "/orderdetail": (context) => const OrderDetailView(
              myOrder: null,
            ),
        "/package_detail": (context) => const PackageDetailView(
              packageLineItemId: '',
            ),
        "/package_list": (context) => PackageListView(),
        // ignore: prefer_const_constructors
        "/place_order": (context) => PlaceOrderView(
              amount: '',
              packageId: '',
            ),
        "/profile": (context) => const ProfileView(),

        "/signup_success": (context) => const SignupSuccess(),
        "/signup": (context) => const SignupView(),
        "/terms_conditions": (context) => const TermsConditionsView(),
      },
    );
  }
}
