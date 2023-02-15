import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/view/screens/confirmpassword_screen.dart';

import '../widgets/widget_utils.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
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
                    height: 40,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'OTP Verification',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: AppColor.textColor),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            'Enter the OTP send to 94XXXXXXXX3',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  OtpTextField(
                    numberOfFields: 4,
                    borderColor: Color(0xffF5591F),
                    focusedBorderColor: Colors.blue,
                    // styles: otpTextStyles,
                    showFieldAsBox: false,
                    borderWidth: 4.0,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here if necessary
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {},
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  getSubmitButtonContainer(),
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConfirmPasswordScreen()),
    );
    print("Login Button pressed!!!");
  }
}
//     return Scaffold(
//         body: SingleChildScrollView(
//             child: Container(
//       color: Colors.blue,
//       child: Column(
//         children: [
//           Container(height: 100, color: Colors.blue),
//           Container(
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(50), topRight: Radius.circular(50)),
//               color: Colors.white,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Container(
//                     // color: Colors.red,
//                     height: 200,
//                     margin: EdgeInsets.only(top: 10),
//                     child: Image.asset(
//                       "assets/images/logo.png",
//                       height: 150,
//                       width: 90,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 70,
//                   ),
//                   Container(
//                     child: Column(
//                       children: [
//                         Center(
//                           child: Text(
//                             'OTP Verification',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 30,
//                                 color: AppColor.textColor),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Center(
//                           child: Text(
//                             'Enter the OTP send to 94XXXXXXXX3',
//                             style: TextStyle(fontSize: 15),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 1.0,
//                       right: 1.0,
//                       top: 30,
//                     ),
//                     //padding: EdgeInsets.symmetric(horizontal: 15),
//                     child: OtpTextField(
//                       numberOfFields: 4,
//                       borderColor: Color(0xffF5591F),
//                       focusedBorderColor: Colors.blue,
//                       // styles: otpTextStyles,
//                       showFieldAsBox: false,
//                       borderWidth: 4.0,
//                       //runs when a code is typed in
//                       onCodeChanged: (String code) {
//                         //handle validation or checks here if necessary
//                       },
//                       //runs when every textfield is filled
//                       onSubmit: (String verificationCode) {},
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                       height: 50,
//                       width: 200,
//                       decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(25)),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 40.0, vertical: 18.0),
//                           shape: StadiumBorder(),
//                         ),
//                         child: const Text('Verify & Proceed'),
//                         onPressed: () {
//                           // print(nameController.text);
//                           // print(passwordController.text);
//                         },
//                       )),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     )));
//   }
// }
