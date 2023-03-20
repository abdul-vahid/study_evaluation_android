import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/view/views/confirmpassword_screen.dart';
import '../../utils/app_utils.dart';
import '../../view_models/user_view_model/user_list_vm.dart';
import '../widgets/widget_utils.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({
    super.key,
    required this.otp,
    required this.userName,
  });
  final int otp;
  final String userName;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  var otpVerification;
  int? oneTimePassword;

  List<String> char = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      if (i == 0 || i == 1 || i == 8 || i == 9) {
        char.add(widget.userName[i]);
      } else {
        char.add('X');
      }
    }
  }

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
                  WidgetUtils.getLoginImageContainer("assets/images/logo.jpg"),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Center(
                          child: Text(
                            'OTP Verification',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: AppColor.textColor),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            'Enter the OTP send to ${char.join("")}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  OTPTextField(
                      // controller: otpController,
                      length: 4,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 45,
                      //fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: const TextStyle(fontSize: 17),
                      onChanged: (pin) {
                        //print("Changed: " + pin);
                        otpVerification = pin;
                      },
                      onCompleted: (pin) {
                        //print("Completed: " + pin);
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  getSubmitButtonContainer(),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                      child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'Do not receive OTP?',
                        style: TextStyle(fontSize: 10, color: Colors.red),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          UserListViewModel()
                              .getOTP(widget.userName, "FORGOT_PASSWORD")
                              .then((records) {
                            oneTimePassword = records;
                            //showDialogOTP(records);
                          }).catchError((onError) {
                            Navigator.pop(context);
                            List<String> errorMessages =
                                AppUtils.getErrorMessages(onError);
                            AppUtils.getAlert(context, errorMessages,
                                title: "Error Alert");
                          });
                        },
                        child: const Text(
                          'Resend OTP',
                          style: TextStyle(
                              fontSize: 10, color: AppColor.textColor),
                        ),
                      ),
                    ],
                  )),
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
        child: WidgetUtils.getButton("Verify & Proceed",
            callback: onButtonPressed));
  }

  void onButtonPressed() {
    if (otpVerification.toString() == widget.otp.toString() ||
        otpVerification.toString() == oneTimePassword.toString()) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ConfirmPasswordScreen(userName: widget.userName)),
      );
    } else {
      AppUtils.showAlertDialog(context, 'Error', 'Wrong otp entered');
    }
  }
}
