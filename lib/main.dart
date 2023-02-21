import 'package:flutter/material.dart';
import 'package:study_evaluation/view/views/login_home.dart';
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
