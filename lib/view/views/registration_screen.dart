import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/controller/user_controller.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/signup_success.dart';
import 'package:study_evaluation/view_models/result_view_model/role_list_vm.dart';

import '../../utils/app_color.dart';
import '../../utils/validator_util.dart';
import '../widgets/widget_utils.dart';

class RegistrationScreen extends StatefulWidget {
  //RegistrationScreen(this.roleListVM);
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var roleListVM;
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<RoleListViewModel>(context, listen: false).fetch();
    super.initState();
  }

  UserController? userController;
  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();
  String? _name;
  String? _mobileNumber;
  String? _email;
  String? _password;
  String? _confirmPassword;

  final List<String> _role = [
    'QA',
    'Uploader',
    'Postman',
    'Tester',
    'Admin',
    'Testing',
  ]; // Option 2
  String? _selectedRole; // Option 2
  @override
  Widget build(BuildContext context) {
    roleListVM = Provider.of<RoleListViewModel>(context);
    userController = UserController(context);
    return SingleChildScrollView(
      child: Form(
        key: _registrationFormKey,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            WidgetUtils.getTextFormField('Name', 'Enter Name', Icons.person,
                onSaved: ((value) {
              _name = value;

              print('_userName @@@@ $_name');
            }), onValidator: validateName),
            const SizedBox(
              height: 20,
            ),
            WidgetUtils.getTextFormField(
                'Mobile', 'Enter Mobile Number', Icons.mobile_screen_share,
                onSaved: ((value) {
              _mobileNumber = value;

              print('_mobileNumber @@@@ $_mobileNumber');
            }), onValidator: validatePhone),
            const SizedBox(
              height: 20,
            ),
            WidgetUtils.getTextFormField('Email', 'Enter Email', Icons.email,
                onSaved: ((value) {
              _email = value;

              print('_email @@@@ $_email');
            })),
            const SizedBox(
              height: 20,
            ),
            WidgetUtils.getTextFormField(
                'Password', 'Enter Password', Icons.lock, onSaved: ((value) {
              _password = value;

              print('_password @@@@ $_password');
            }), onValidator: validatePassword, obscureText: true),
            const SizedBox(
              height: 20,
            ),
            WidgetUtils.getTextFormField(
                'Confirm Password', 'Enter Confirm Password', Icons.lock,
                onSaved: ((value) {
              _confirmPassword = value;

              print('_confirmPassword @@@@ $_password');
            }), onValidator: validatePassword, obscureText: true),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    prefixIcon: Icon(Icons.person, color: AppColor.iconColor),
                  ),
                  hint: const Text('Select Role'),
                  // Not necessary for Option 1
                  value: _selectedRole,
                  validator: (value) => value == null ? 'Required' : null,
                  isDense: true,
                  isExpanded: false,
                  menuMaxHeight: 350,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedRole = newValue;
                    });
                  },
                  items: getItems()),
            ),
            const SizedBox(
              height: 20,
            ),
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
      AppUtil().onLoading(context, "Please wait...");
      _registrationFormKey.currentState!.save();

      int min = 5;
      int max = 10;
      Random rnd = new Random();
      var val = min + rnd.nextInt(max - min);
      print("$val is in the range of $min and $max");

      UserModel userModel = UserModel(
          roleId: "4",
          userName: _mobileNumber,
          email: _email,
          name: _name,
          mobileNo: _mobileNumber,
          password: _password,
          status: "Active");

      userController?.signUp(userModel).then((value) {
        print("success");
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignupSuccess()));
      }).catchError((onError) {
        Navigator.pop(context);
        List<String> errorMessages = AppUtil.getErrorMessages(onError);
        AppUtil().getAlert(context, errorMessages, title: "Error Alert");
      });
    }
  }

  List<DropdownMenuItem<String>>? getItems() {
    if (roleListVM.viewModels.isNotEmpty) {
      return roleListVM.viewModels.map<DropdownMenuItem<String>>((viewModel) {
        return DropdownMenuItem<String>(
          value: viewModel.model.id,
          child: Text(viewModel.model.role),
        );
      }).toList();
    }
    return null;
  }
}
