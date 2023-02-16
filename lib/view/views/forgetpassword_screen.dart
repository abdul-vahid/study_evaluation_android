import 'package:flutter/material.dart';
import 'package:study_evaluation/view/views/otpverification_screen.dart';

import '../../utils/app_color.dart';
import '../widgets/widget_utils.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      color: AppColor.primaryColor,
      child: Column(
        children: [
          Container(
            height: 100,
            color: AppColor.primaryColor,
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WidgetUtils.getLoginImageContainer("assets/images/logo.png"),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    child: Center(
                        child: Text(
                      'Create New Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColor.primaryColor,
                      ),
                    )),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    height: 460,
                    child: Column(children: [
                      WidgetUtils.getTextFormField('Mobile',
                          'Enter Mobile Number', Icons.mobile_screen_share),
                      const SizedBox(
                        height: 20,
                      ),
                      getSubmitButtonContainer(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )));
  }

  Container getSubmitButtonContainer() {
    return Container(
        height: 50,
        width: 345,
        decoration: BoxDecoration(
            color: AppColor.textColor,
            borderRadius: BorderRadius.circular(25.0)),
        child: WidgetUtils.getButton("Submit", callback: onButtonPressed));
  }

  void onButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OTPVerificationScreen()),
    );
    print("Login Button pressed!!!");
  }
}
