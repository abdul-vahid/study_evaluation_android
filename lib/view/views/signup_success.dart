import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class SignupSuccess extends StatelessWidget {
  const SignupSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup Success"),
      ),
      body: const Center(
        child: Text("Signup Completed, Please login to continue."),
      ),
    );
  }
}
