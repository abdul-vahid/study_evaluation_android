// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
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
      body: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 400,
                width: 400,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    CircleAvatar(
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: Colors.white,
                        size: 120,
                      ),
                      radius: 60,
                      backgroundColor: Colors.green,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Thank You!',
                        style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Registration done Successfully!',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        'You will be redirected to the Login page shortly \n        or click here to return to Login page!',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 50,
                        width: 200,
                        //margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.green),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginHome()),
                              );
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//       body: SingleChildScrollView(
//         child: Column(
//           // ignore: prefer_const_literals_to_create_immutables
//           children: [
//             SizedBox(
//               height: 300,
//             ),
//             Container(
//               height: 30,
//               color: AppColor.containerBoxColor,
//               child: Center(
//                 child: Text("Signup Completed, Please login to continue."),
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             ElevatedButton(
//               child: Text('Login'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColor.buttonColor,
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginHome()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
