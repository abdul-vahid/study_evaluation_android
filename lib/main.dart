import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/view/views/exam_view.dart';
import 'package:study_evaluation/view/views/login_home.dart';
import 'package:study_evaluation/view_models/question_answer_list_vm.dart';

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
        debugShowCheckedModeBanner: false, home: const LoginHome()
        /* home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => QuestionAnswerListViewModel())
      ], child: const ExamView()), */
        );
  }
}
