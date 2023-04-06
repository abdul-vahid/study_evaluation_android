import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/controller/user_controller.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/utils/enum.dart';
import 'package:study_evaluation/view/views/forgetpassword_view.dart';
import '../../utils/app_color.dart';
import '../../utils/validator_util.dart';
import '../widgets/widget_utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _loginFormKey = new GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  String? _userName;
  String? _password;
  bool passwordVisible = false;

  UserController? _userController;
  bool displayLogin = false;
  @override
  void initState() {
    _isLoggedIn();
    super.initState();
    passwordVisible = true;
  }

  void _isLoggedIn() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey(SharedPrefsConstants.accessTokenKey)) {
        //_pushHomePage();
        AppUtils.launchTab(context, selectedIndex: HomeTabsOptions.home.index)
            .then((value) => _isLoggedIn());
      } else {
        setState(() {
          displayLogin = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    _userController = UserController(context);
    return displayLogin ? _getBody(context) : const CircularProgressIndicator();
  }

  SingleChildScrollView _getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            WidgetUtils.getTextFormField(
              'Mobile',
              'Enter Mobile Number',
              Icons.phone_android,
              onSaved: ((value) {
                _userName = value;
              }),
              onValidator: validatePhone,
              // initialValue: "0987654326",
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 20,
            ),
            WidgetUtils.getTextFormFieldPassword(
              'Password',
              'Enter Password',
              Icons.lock,
              onValidator: validatePassword,
              // initialValue: "Admin@123",
              onSaved: ((value) {
                _password = value;
              }),
              obscureText: passwordVisible,
              suffix: Padding(
                padding: const EdgeInsetsDirectional.only(end: 10.0),
                child: InkWell(
                  child: Icon(
                    // Based on passwordVisible state choose the icon
                    passwordVisible ? Icons.visibility_off : Icons.visibility,
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
          MaterialPageRoute(builder: (context) => const ForgetPasswordView()),
        );
      },
      child: const Text(
        'Forgot Password',
        style: TextStyle(color: AppColor.textColor),
      ),
    );
  }

  void onButtonPressed() {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();

      AppUtils.onLoading(context, "Logging You, please wait...");
      //var loginList = LoginListViewModel();

      _userController?.login(_userName!, _password!).then((records) {
        Navigator.pop(context);
        if (records.isNotEmpty) {
          AppUtils.launchTab(context);
        }
      }).catchError((error, stackTrace) {
        Navigator.pop(context);
        List<String> errorMessages = AppUtils.getErrorMessages(error);
        AppUtils.getAlert(context, errorMessages, title: "Error Alert");
      });
    }
  }
}
