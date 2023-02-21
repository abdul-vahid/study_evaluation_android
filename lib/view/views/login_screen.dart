import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/controller/user_controller.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/forgetpassword_screen.dart';
import 'package:study_evaluation/view/views/home_main_view.dart';
import 'package:study_evaluation/view_models/category_view_model/category_list_vm.dart';
import 'package:study_evaluation/view_models/feedback_view_model/feedback_list_vm.dart';
import 'package:study_evaluation/view_models/slider_image_view_model/slider_image_list_vm.dart';
import '../../utils/app_color.dart';
import '../widgets/widget_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  UserController? _userController;
  @override
  Widget build(BuildContext context) {
    _userController = UserController(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 60,
          ),
          WidgetUtils.getTextFormField(
              'Mobile', 'Enter Mobile Number', Icons.mobile_screen_share,
              controller: userNameController),
          const SizedBox(
            height: 20,
          ),
          WidgetUtils.getTextFormField('Password', 'Enter Password', Icons.lock,
              controller: passwordController),
          const SizedBox(
            height: 20,
          ),
          WidgetUtils.getButton("Submit", callback: onButtonPressed),
          const SizedBox(
            height: 20,
          ),
          getTextButton(context),
        ],
      ),
    );
  }

  TextButton getTextButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()),
        );
      },
      child: Text(
        'Forgot Password',
        style: TextStyle(color: AppColor.textColor),
      ),
    );
  }

  void onButtonPressed() {
    AppUtil().onLoading(context, "Logging You, please wait...");
    //var loginList = LoginListViewModel();

    _userController?.login("raj@gmail.com", "test1234").then((records) {
      Navigator.pop(context);
      if (records.isNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                            create: (_) => CategoryListViewModel()),
                        ChangeNotifierProvider(
                            create: (_) => SliderImageListViewModel()),
                        ChangeNotifierProvider(
                            create: (_) => FeedbackListViewModel()),
                      ],
                      child: const HomeMainView(),
                    )));
      }
    }).catchError((error) {
      Navigator.pop(context);
      List<String> errorMessages = [];
      if (error.runtimeType == AppException) {
        AppException exception = error;
        Map<String, dynamic> data = jsonDecode(exception.getMessage());

        data.forEach((key, value) {
          errorMessages.add(value);
        });
      } else {
        errorMessages.add(error.toString());
      }

      AppUtil().getAlert(context, errorMessages, title: "Error Alert");
    });
  }
}
