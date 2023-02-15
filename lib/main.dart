import 'package:flutter/material.dart';
import 'package:study_evaluation/view/screens/aboutus_screen.dart';
import 'package:study_evaluation/view/screens/both_screen.dart';
import 'package:study_evaluation/view/screens/confirmpassword_screen.dart';
import 'package:study_evaluation/view/screens/english_screen.dart';
import 'package:study_evaluation/view/screens/feedbackalertdialog.dart';
import 'package:study_evaluation/view/screens/followus_screen.dart';
import 'package:study_evaluation/view/screens/hindi_screen.dart';
import 'package:study_evaluation/view/screens/home_view.dart';
import 'package:study_evaluation/view/screens/login_home.dart';
import 'package:study_evaluation/view/screens/myorder_screen.dart';
import 'package:study_evaluation/view/screens/otpverification_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:study_evaluation/view/screens/result_screen.dart';
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
