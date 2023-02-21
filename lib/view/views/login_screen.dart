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
import '../../utils/validator_util.dart';
import '../widgets/widget_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = new GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  String? _userName;
  String? _password;
  UserController? _userController;
  @override
  Widget build(BuildContext context) {
    _userController = UserController(context);
    return SingleChildScrollView(
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            WidgetUtils.getTextFormField(
                'Mobile', 'Enter Mobile Number', Icons.mobile_screen_share,
                onSaved: ((value) {
              _userName = value;

              print('_userName @@@@ $_userName');
            }), onValidator: validateUserName, initialValue: "raj@gmail.com"),
            const SizedBox(
              height: 20,
            ),
            WidgetUtils.getTextFormField(
                'Password', 'Enter Password', Icons.lock,
                onValidator: validatePassword,
                initialValue: "test1234", onSaved: ((value) {
              _password = value;
              print('_Password @@@@ $_password');
            }), obscureText: true),
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
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();

      AppUtil().onLoading(context, "Logging You, please wait...");
      //var loginList = LoginListViewModel();

      _userController?.login(_userName!, _password!).then((records) {
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
        List<String> errorMessages = AppUtil.getErrorMessages(error);
        AppUtil().getAlert(context, errorMessages, title: "Error Alert");
      });
    }
  }
}
