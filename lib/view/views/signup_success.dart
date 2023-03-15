// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/login_home.dart';

class SignupSuccess extends StatelessWidget {
  const SignupSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    return Scaffold(
        appBar: AppUtils.getAppbar("Signup Success",
            leading: const BackButton(
              color: Colors.white,
            )),
      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 300,
            ),
            Container(
              height: 30,
              color: AppColor.containerBoxColor,
              child: Center(
                child: Text("Signup Completed, Please login to continue."),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.buttonColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginHome()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
