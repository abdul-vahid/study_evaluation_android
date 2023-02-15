import 'package:flutter/material.dart';
import 'package:study_evaluation/view/screens/login_screen.dart';

import '../../utils/app_color.dart';
import '../widgets/widget_utils.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  const ConfirmPasswordScreen({super.key});

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
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
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        WidgetUtils.getLoginImageContainer(
                            "assets/images/logo.png"),
                        const SizedBox(
                          height: 40,
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
                          height: 40,
                        ),
                        WidgetUtils.getTextFormField(
                            'Password', 'Enter New Password', Icons.lock),
                        const SizedBox(
                          height: 20,
                        ),
                        WidgetUtils.getTextFormField(
                            'Password', 'Enter Confirm Password', Icons.lock),
                        const SizedBox(
                          height: 20,
                        ),
                        WidgetUtils.getButton("Submit",
                            callback: onButtonPressed),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const LoginScreen()),
    // );
    print("Login Button pressed!!!");
  }
}
