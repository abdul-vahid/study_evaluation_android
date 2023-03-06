import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/controller/user_controller.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/signup_success.dart';
import 'package:study_evaluation/view_models/role_list_vm.dart';
import '../../utils/app_color.dart';
import '../../utils/validator_util.dart';
import '../widgets/widget_utils.dart';

class SignupView extends StatefulWidget {
  //RegistrationScreen(this.roleListVM);
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  // RoleListViewModel? roleListVM;
  @override
  void initState() {
    Provider.of<RoleListViewModel>(context, listen: false).fetch();
    super.initState();
  }

  UserController? userController;
  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  String? _mobileNumber;
  String? _password;
  String? _firstName;
  String? _lastName;

// Option 2
  // String? _selectedRole; // Option 2
  @override
  Widget build(BuildContext context) {
    //  roleListVM = Provider.of<RoleListViewModel>(context);
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
              Icons.mobile_screen_share,
              onSaved: ((value) {
                _mobileNumber = value;
              }),
              keyboardType: TextInputType.phone,
              onValidator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter a Phone Number";
                } else if (!RegExp(
                        r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                    .hasMatch(value)) {
                  return "Please Enter a Valid Phone Number";
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            WidgetUtils.getTextFormField(
                'Password', 'Enter Password', Icons.lock, onSaved: ((value) {
              _password = value;

              print('_password @@@@ $_password');
            }),
                onValidator: validatePassword,
                obscureText: true,
                controller: passwordController),
            const SizedBox(
              height: 20,
            ),
            WidgetUtils.getTextFormField(
              'Confirm Password',
              'Enter Confirm Password',
              Icons.lock,
              onSaved: ((value) {
                print('_confirmPassword @@@@ $_password');
              }),
              obscureText: true,
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
      AppUtils.onLoading(context, "Please wait...");
      _registrationFormKey.currentState!.save();

      int min = 5;
      int max = 10;
      Random rnd = new Random();
      var val = min + rnd.nextInt(max - min);
      print("$val is in the range of $min and $max");

      UserModel userModel = UserModel(
        roleName: "student",
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
