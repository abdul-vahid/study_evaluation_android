import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:study_evaluation/apis/app_exception.dart';
import 'package:study_evaluation/controller/user_controller.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/screens/signup_success.dart';

import '../../utils/app_color.dart';
import '../widgets/widget_utils.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  UserController? userController;
  final List<String> _state = [
    'Andhra Pradesh',
    'Bihar',
    'Karnataka',
    'Punjab',
    'Assam'
  ]; // Option 2
  String? _selectedState; // Option 2
  @override
  Widget build(BuildContext context) {
    userController = UserController(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 60,
          ),
          WidgetUtils.getTextFormField('Name', 'Enter Name', Icons.person),
          const SizedBox(
            height: 20,
          ),
          WidgetUtils.getTextFormField(
              'Mobile', 'Enter Mobile Number', Icons.mobile_screen_share),
          const SizedBox(
            height: 20,
          ),
          WidgetUtils.getTextFormField(
              'Password', 'Enter Password', Icons.lock),
          const SizedBox(
            height: 20,
          ),
          WidgetUtils.getTextFormField(
              'Password', 'Enter Confirm Password', Icons.lock),
          const SizedBox(
            height: 20,
          ),
          InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text('Select States'),
                // Not necessary for Option 1
                value: _selectedState,
                isDense: true,
                isExpanded: true,
                menuMaxHeight: 350,
                onChanged: (newValue) {
                  setState(() {
                    _selectedState = newValue;
                  });
                },
                items: _state.map((state) {
                  return DropdownMenuItem(
                    child: new Text(state),
                    value: state,
                  );
                }).toList(),
              ),
            ),
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
    AppUtil().onLoading(context, "Please wait...");

    int min = 5;
    int max = 10;
    Random rnd = new Random();
    var val = min + rnd.nextInt(max - min);
    print("$val is in the range of $min and $max");

    UserModel userModel = UserModel(
        roleId: "5",
        email: "test$val@gmail.com",
        name: "vijay",
        mobileNo: "2323112323",
        password: "test1234",
        status: "Active");

    userController?.signUp(userModel).then((value) {
      print("success");
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SignupSuccess()));
    }).catchError((onError) {
      Navigator.pop(context);
      AppException exception = onError;
      Map<String, dynamic> data = jsonDecode(exception.getMessage());
      List<String> errorMessages = [];
      data.forEach((key, value) {
        errorMessages.add(value);
      });

      AppUtil().getAlert(context, errorMessages, title: "Error Alert");
    });
  }
}
