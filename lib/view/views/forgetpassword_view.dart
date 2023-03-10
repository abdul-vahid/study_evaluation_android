import 'package:flutter/material.dart';
import 'package:study_evaluation/view/views/otpverification_screen.dart';
import 'package:study_evaluation/view/views/signup_success.dart';

import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/validator_util.dart';
import '../../view_models/user_view_model/user_list_vm.dart';
import '../widgets/widget_utils.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  String? _userName;
  String? _reason = 'FORGOT_PASSWORD';
  final GlobalKey<FormState> _ForgetFormKey = new GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
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
                    child: Form(
                      key: _ForgetFormKey,
                      child: Column(children: [
                        WidgetUtils.getTextFormField('Mobile',
                            'Enter Mobile Number', Icons.mobile_screen_share,
                            onValidator: validatePhone,
                            keyboardType: TextInputType.phone,
                            controller: _mobileController),
                        const SizedBox(
                          height: 20,
                        ),
                        getSubmitButtonContainer(),
                      ]),
                    ),
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
    if (_ForgetFormKey.currentState!.validate()) {
      AppUtils.onLoading(context, "Please Wait...");

      _userName = _mobileController.text;
      print('_userName$_userName');
      print('_reason$_reason');

      UserListViewModel().getOTP(_userName!, "FORGOT_PASSWORD").then((records) {
        print("success");

        print('records.isNotEmpty$records');

        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OTPVerificationScreen(
                      otp: records,
                      userName: _userName!,
                    )));
      }).catchError((onError) {
        print('@@@Error${onError}');

        Navigator.pop(context);
        List<String> errorMessages = AppUtils.getErrorMessages(onError);
        AppUtils.getAlert(context, errorMessages, title: "Error Alert");
      });

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const OTPVerificationScreen()),
      // );
      print("Login Button pressed!!!");
    }
  }
}
