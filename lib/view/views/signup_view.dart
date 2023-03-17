import 'dart:math';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:study_evaluation/controller/user_controller.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/utils/function_lib.dart';
import 'package:study_evaluation/view/views/signup_success.dart';
import '../../utils/app_color.dart';
import '../../utils/validator_util.dart';
import '../../view_models/user_view_model/user_list_vm.dart';
import '../widgets/widget_utils.dart';

class SignupView extends StatefulWidget {
  //RegistrationScreen(this.roleListVM);
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  UserController? userController;
  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  String otpVerification = "";
  OtpFieldController otpController = OtpFieldController();
  final TextEditingController _mobileController = TextEditingController();

  String? _mobileNumber;
  String? _password;
  String? _firstName;
  String? _lastName;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    confirmPasswordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    userController = UserController(context);
    return SingleChildScrollView(
      child: Form(
        key: _registrationFormKey,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            WidgetUtils.getTextFormField(
                'First Name', 'Enter First Name', Icons.person,
                onSaved: ((value) {
              debug("onsave firstname = $value");
              _firstName = value;
            }), onValidator: validateName),
            const SizedBox(
              height: 20,
            ),
            WidgetUtils.getTextFormField(
                'Last Name', 'Enter Last Name', Icons.person,
                onSaved: ((value) {
              _lastName = value;
            }), onValidator: validateName),
            const SizedBox(
              height: 20,
            ),
            WidgetUtils.getTextFormField(
              'Mobile',
              'Enter Mobile Number',
              Icons.phone_android,
              onSaved: ((value) {
                _mobileNumber = value;
              }),
              keyboardType: TextInputType.phone,
              onValidator: validatePhone,
            ),
            const SizedBox(
              height: 20,
            ),
            WidgetUtils.getTextFormFieldPassword(
              'Password',
              'Enter Password',
              Icons.lock,
              onSaved: ((value) {
                _password = value;

                print('_password @@@@ $_password');
              }),
              onValidator: validatePassword,
              obscureText: passwordVisible,
              controller: passwordController,
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
            WidgetUtils.getTextFormFieldPassword(
              'Confirm Password',
              'Enter Confirm Password',
              Icons.lock,
              onSaved: ((value) {
                print('_confirmPassword @@@@ $_password');
              }),
              obscureText: confirmPasswordVisible,
              controller: confirmpasswordController,
              onValidator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please re-enter password';
                }
                print(passwordController.text);
                print(confirmpasswordController.text);
                if (passwordController.text != confirmpasswordController.text) {
                  return "Password does not match";
                }
              },
              suffix: Padding(
                padding: const EdgeInsetsDirectional.only(end: 10.0),
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
                      confirmPasswordVisible = !confirmPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // DropdownButtonHideUnderline(
            //   child: DropdownButtonFormField<String>(
            //       decoration: InputDecoration(
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(25)),
            //         prefixIcon: Icon(Icons.person, color: AppColor.iconColor),
            //       ),
            //       hint: const Text('Select Role'),
            //       // Not necessary for Option 1
            //       value: _selectedRole,
            //       validator: (value) => value == null ? 'Required' : null,
            //       isDense: true,
            //       isExpanded: false,
            //       menuMaxHeight: 350,
            //       onChanged: (newValue) {
            //         setState(() {
            //           _selectedRole = newValue;
            //         });
            //       },
            //       items: getItems()),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            getSubmitButtonContainer(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Container getSubmitButtonContainer() {
    return Container(
        height: 50,
        width: 345,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(25.0)),
        child: WidgetUtils.getButton("Submit", callback: onButtonPressed));
  }

  void onButtonPressed() {
    if (_registrationFormKey.currentState!.validate()) {
      // AppUtils.onLoading(context, "Please wait...");
      debug("onbutton pressed _firstName = $_firstName");
      _registrationFormKey.currentState!.save();
      _displayDialog(context);
    }
  }

  _displayDialog(BuildContext context, {OtpFieldController? controller}) async {
    AppUtils.onLoading(context, "Please Wait...");

    UserListViewModel()
        .getOTP(_mobileNumber!, "REGISTRATION")
        .then((records) => showDialogOTP(records))
        .catchError((onError) {
      Navigator.pop(context);
      List<String> errorMessages = AppUtils.getErrorMessages(onError);
      AppUtils.getAlert(context, errorMessages, title: "Error Alert");
    });

    // Navigator.pop(context);
  }

  Future<dynamic> showDialogOTP(otp) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('${otp}')),
            content: OTPTextField(
                controller: otpController,
                length: 4,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 45,
                //fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                style: const TextStyle(fontSize: 17),
                onChanged: (pin) {
                  otpVerification = pin;
                },
                onCompleted: (pin) {}),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFfef5e6),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.buttonColor,
                      ),
                      onPressed: (() {
                        _submit(otp);
                        // AppUtils.onLoading(context, "Saving...");
                      }),
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  void _submit(otp) {
    //AppUtils.onLoading(context, "Logging You, please wait...");
    debug("_firstName = $_firstName");
    if (otpVerification == otp.toString()) {
      UserModel userModel = UserModel(
        role: "student",
        firstName: _firstName,
        lastName: _lastName,
        userName: _mobileNumber,
        mobileNo: _mobileNumber,
        password: _password,
      );

      userController?.signUp(userModel).then((value) {
        print("success");
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignupSuccess()));
      }).catchError((onError) {
        Navigator.pop(context);
        List<String> errorMessages = AppUtils.getErrorMessages(onError);
        AppUtils.getAlert(context, errorMessages, title: "Error Alert");
      });
      Navigator.pop(context, "Registration");
    } else {
      // Navigator.pop(context);
      AppUtils.showAlertDialog(context, 'Error', 'Wrong otp entered');
    }
  }

  // List<DropdownMenuItem<String>>? getItems() {
  //   if (roleListVM!.viewModels.isNotEmpty) {
  //     return roleListVM!.viewModels.map<DropdownMenuItem<String>>((viewModel) {
  //       return DropdownMenuItem<String>(
  //         value: viewModel.model.id,
  //         child: Text(viewModel.model.role),
  //       );
  //     }).toList();
  //   }
  //   return null;
  // }
}
