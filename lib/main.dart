import 'package:flutter/material.dart';
import 'package:study_evaluation/view/views/aboutus_screen.dart';
import 'package:study_evaluation/view/views/both_screen.dart';
import 'package:study_evaluation/view/views/confirmpassword_screen.dart';
import 'package:study_evaluation/view/views/english_screen.dart';
import 'package:study_evaluation/view/views/feedbackalertdialog.dart';
import 'package:study_evaluation/view/views/followus_screen.dart';
import 'package:study_evaluation/view/views/hindi_screen.dart';
import 'package:study_evaluation/view/views/home_view.dart';
import 'package:study_evaluation/view/views/login_home.dart';
import 'package:study_evaluation/view/views/myorder_screen.dart';
import 'package:study_evaluation/view/views/otpverification_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:study_evaluation/view/views/result_screen.dart';
import 'package:study_evaluation/view/widgets/bottomnavigation.dart';

/* Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}  */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: const ContableScreen(),
      //  home: TestSeriesScreen(),
      home: LoginHome(),
      // home: AnalysisScreen(),
      // home: FollowUsScreen(),
      // home: MYOrderScreen(),
      // home: CustomAlertDialog(),
      // home: FeedbackAlertDialog(),
      //home: BottomNavigation(),
    );
  }
}
