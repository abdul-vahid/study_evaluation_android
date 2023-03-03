// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/view/views/profile_view.dart';
import 'package:study_evaluation/view_models/user_view_model/user_list_vm.dart';
import 'package:intl/intl.dart';

import '../../models/user_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/validator_util.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final GlobalKey<FormState> _feedbackFormKey = GlobalKey<FormState>();

  // String? profileUrl;
  UserModel? userModel;

  final _firstNameCtrl = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  // ignore: prefer_final_fields
  List<String> _gender = ['Male', 'Female', 'Other']; // Option 2
  String? _selectedGender; // Option 2

  // ignore: prefer_final_fields
  List<String> _states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];
  String? _selectedState;

  void _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    // _firstNameCtrl.text = userModel?.firstName;
    setState(() {
      userModel = AppUtils.getSessionUser(prefs);
      _firstNameController.text = (userModel?.firstName)!;
      _lastNameController.text = (userModel?.lastName)!;
      _mobileController.text = (userModel?.mobileNo)!;
      _genderController.text = (userModel?.gender)!;
      _dobController.text = (userModel?.dob)!;
      _stateController.text = (userModel?.state)!;
      _cityController.text = (userModel?.city)!;
      print('state@@ ${userModel?.state}');
      print('gender@@ ${userModel?.gender}');
      _selectedGender =
          (userModel?.gender == null || (userModel?.gender?.isEmpty)!)
              ? 'Male'
              : userModel?.gender;
      _selectedState =
          (userModel?.state == null || (userModel?.state?.isEmpty)!)
              ? 'Rajasthan'
              : userModel?.state;
    });
  }

  TextEditingController _textFieldController = TextEditingController();

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('OTP Verification')),
            content: OtpTextField(
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
                        AppUtils.onLoading(context, "Saving...");
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

  @override
  void initState() {
    // TODO: implement initState
    _loadProfileData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButton(color: Colors.white),
          title: const Text('My Profile'),
          elevation: .1,
          backgroundColor: AppColor.appBarColor,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Form(
            key: _feedbackFormKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                getTextField(ProfileConstants.firstNameLabel,
                    ProfileConstants.firstNameHint, _firstNameController),
                getTextField(ProfileConstants.lastNameLabel,
                    ProfileConstants.lastNameHint, _lastNameController),
                getTextField(ProfileConstants.mobileLabel,
                    ProfileConstants.mobileHint, _mobileController,
                    validator: validatePhone),
                getDropdown(ProfileConstants.genderLabel,
                    ProfileConstants.genderHint, _genderController),
                getDateTextField(ProfileConstants.dobLabel,
                    ProfileConstants.dobHint, _dobController),
                getDropdownState(ProfileConstants.stateLabel,
                    ProfileConstants.stateHint, _stateController),
                getTextField(ProfileConstants.cityLabel,
                    ProfileConstants.cityHint, _cityController),
                getButton()
              ],
            ),
          )
        ])));
  }

  Padding getButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFfef5e6),
            ),
            onPressed: () {
              _displayDialog(context);
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
            onPressed: _save,
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  void _save() {
    print('@@mobileController${_mobileController.text}');
    print('@@userModel${(userModel?.mobileNo)!}');

    if (_mobileController.text != (userModel?.mobileNo)!) {
      _displayDialog(context);
    } else {
      userModel?.firstName = _firstNameController.text;
      userModel?.lastName = _lastNameController.text;
      userModel?.mobileNo = _mobileController.text;
      userModel?.dob = _dobController.text;
      userModel?.city = _cityController.text;
      userModel?.state = _selectedState;
      userModel?.gender = _selectedGender;
      AppUtils.onLoading(context, "Saving...");
      UserListViewModel().updateStudentProfile(userModel!).then((value) {
        print("success");
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileView()));
      }).catchError((error) {
        AppUtils.onError(context, error);
      });
    }
  }

  /* Padding getAddressTextField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text(
            'Address',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const SizedBox(
            height: 150,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    'M​-​15, Ana Sagar Link Rd, near City Hospital, Mali Mohalla, Ajmer, Rajasthan 305001',
              ),
              maxLines: null,
              expands: true,
              keyboardType: TextInputType.multiline,
            ),
          ),
        ],
      ),
    );
  } */

  Padding getDateTextField(
      String label, String text, TextEditingController contorller) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: contorller,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              suffix: Icon(
                Icons.calendar_today,
                color: AppColor.buttonColor,
              ),
              hintText: text,
              border: OutlineInputBorder(),
            ), //editing controller of this TextField
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2101));
              if (pickedDate != null) {
                // print(
                //     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat("dd-MM-yyyy").format(pickedDate);
                // print(
                //     formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  contorller.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ],
      ),
    );
  }

  Padding getTextField(
      String label, String text, TextEditingController contorller,
      {String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: contorller,
            validator: validator,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: text,

              // labelText: 'First Name',
            ),
          ),
        ],
      ),
    );
  }

  Padding getDropdown(
      String label, String text, TextEditingController contorller) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 8),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: Text(text),
              // Not necessary for Option 1

              value: _selectedGender,
              isDense: true,
              isExpanded: true,
              menuMaxHeight: 350,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
              validator: (value) => value == null ? 'Required**' : null,
              items: _gender.map((gender) {
                return DropdownMenuItem(
                  child: new Text(gender),
                  value: gender,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Padding getDropdownState(
      String label, String text, TextEditingController contorller) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 8),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: Text(text),
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
              validator: (value) => value == null ? 'Required**' : null,
              items: _states.map((state) {
                return DropdownMenuItem(
                  child: new Text(state),
                  value: state,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
