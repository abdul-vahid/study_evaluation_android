import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/view/views/login_home.dart';
import 'package:study_evaluation/view_models/result_view_model/role_list_vm.dart';
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
        home: const LoginHome()
        // home: AnalysisScreen(),
        // home: FollowUsScreen(),
        // home: MYOrderScreen(),
        // home: CustomAlertDialog(),
        // home: FeedbackAlertDialog(),
        //home: BottomNavigation(),
        );
  }
}
