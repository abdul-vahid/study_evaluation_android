import 'package:flutter/material.dart';
import 'package:study_evaluation/view/views/login_home.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/validator_util.dart';
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
  final confirmpasswordController = TextEditingController();
  final GlobalKey<FormState> _forgetFormKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = true;
    confirmPasswordVisible = true;
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
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _forgetFormKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          WidgetUtils.getLoginImageContainer(
                              "assets/images/logo.jpg"),
                          const SizedBox(
                            height: 40,
                          ),
                          const Center(
                              child: Text(
                            'Create New Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColor.primaryColor,
                            ),
                          )),
                          const SizedBox(
                            height: 40,
                          ),
                          WidgetUtils.getTextFormFieldPassword(
                            'Password', 'Enter New Password', Icons.lock,
                            // obscureText: true,
                            controller: passwordController,
                            onValidator: validatePassword,
                            obscureText: passwordVisible,
                            suffix: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 10.0),
                              child: InkWell(
                                child: Icon(
                                  // Based on passwordVisible state choose the icon
                                  passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColor.iconColor,
                                ),
                                onTap: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          WidgetUtils.getTextFormFieldPassword(
                            'Password',
                            'Enter Confirm Password',
                            obscureText: confirmPasswordVisible,
                            Icons.lock,
                            controller: confirmpasswordController,
                            onValidator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please re-enter password';
                              }

                              if (passwordController.text !=
                                  confirmpasswordController.text) {
                                return "Password does not match";
                              }
                              return null;
                            },
                            suffix: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 10.0),
                              child: InkWell(
                                child: Icon(
                                  // Based on passwordVisible state choose the icon
                                  confirmPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColor.iconColor,
                                ),
                                onTap: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    confirmPasswordVisible =
                                        !confirmPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
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
    if (_forgetFormKey.currentState!.validate()) {
      AppUtils.onLoading(context, "Please wait...");
      UserListViewModel()
          .changePasword(widget.userName, passwordController.text)
          .then((records) {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginHome()));
      }).catchError((onError) {
        Navigator.pop(context);
        List<String> errorMessages = AppUtils.getErrorMessages(onError);
        AppUtils.getAlert(context, errorMessages, title: "Error Alert");
      });
    }
  }
}
