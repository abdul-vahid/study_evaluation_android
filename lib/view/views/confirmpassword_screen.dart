import 'package:flutter/material.dart';
import 'package:study_evaluation/view/views/login_view.dart';

import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../view_models/user_view_model/user_list_vm.dart';
import '../widgets/widget_utils.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  const ConfirmPasswordScreen({
    super.key,
    required this.userName,
  });
  final String userName;

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  final passwordController = TextEditingController();
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
                            'Password', 'Enter New Password', Icons.lock,
                            controller: passwordController),
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
    UserListViewModel()
        .ChangePasword(widget.userName, passwordController.text)
        .then((records) {
      print("success");

      print('records.isNotEmpty$records');

      Navigator.pop(context);
    }).catchError((onError) {
      print('@@@Error${onError}');

      Navigator.pop(context);
      List<String> errorMessages = AppUtils.getErrorMessages(onError);
      AppUtils.getAlert(context, errorMessages, title: "Error Alert");
    });
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const LoginScreen()),
    // );
    print("Login Button pressed!!!");
  }
}
