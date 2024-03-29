// ignore_for_file: unnecessary_new

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/enum.dart';
import 'package:study_evaluation/view_models/user_view_model/user_list_vm.dart';
import 'package:intl/intl.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../../models/user_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/function_lib.dart';
import '../../utils/validator_util.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();
  UserModel? userModel;
  String? mobileNo;
  String? reason;
  String otp = "";
  int? oneTimePassword;
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var appSignatureID;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();

  String otpVerification = "";
  // ignore: prefer_final_fields
  List<String> _gender = ['Male', 'Female', 'Other']; // Option 2
  String? _selectedGender; // Option 2
  // ignore: prefer_final_fields
  List<String> _states = [
    'None',
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
    setState(() {
      userModel = AppUtils.getSessionUser(prefs);

      _firstNameController.text = (userModel?.firstName)!;
      _lastNameController.text = (userModel?.lastName)!;
      _mobileController.text = (userModel?.mobileNo)!;
      _genderController.text = (userModel?.gender)!;
      _dobController.text = (userModel?.dob)!;
      _stateController.text = (userModel?.state)!;
      _cityController.text = (userModel?.city)!;
      _selectedGender =
          (userModel?.gender == null || (userModel?.gender?.isEmpty)!)
              ? 'Male'
              : userModel?.gender;
      _selectedState =
          (userModel?.state == null || (userModel?.state?.isEmpty)!)
              ? 'None'
              : userModel?.state;
    });
  }

  @override
  void codeUpdated() {
    //print("Update code $code");
    setState(() {
      print("codeUpdated");
    });
  }

  void listenOtp() async {
    await SmsAutoFill().listenForCode;
   // debug("await SmsAutoFill().listenForCode ${SmsAutoFill().listenForCode}");
    //print("OTP listen Called");
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    //print("unregisterListener");
    super.dispose();
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      var userModel = AppUtils.getSessionUser(prefs);
      userModel ?? AppUtils.logout(context);
    });

    _loadProfileData();
    listenOtp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    return Scaffold(
        appBar: AppUtils.getAppbar("Edit Profile",
            leading: const BackButton(
              color: Colors.white,
            )),
        body: _getBody());
  }

  SingleChildScrollView _getBody() {
    return SingleChildScrollView(
        child: Column(children: [
      Form(
        key: _FormKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            getTextField(ProfileConstants.firstNameLabel,
                ProfileConstants.firstNameHint, _firstNameController,
                validator: validateName),
            getTextField(ProfileConstants.lastNameLabel,
                ProfileConstants.lastNameHint, _lastNameController,
                validator: validateName),
            getTextField(ProfileConstants.mobileLabel,
                ProfileConstants.mobileHint, _mobileController,
                keyboardType: TextInputType.phone, validator: validatePhone),
            getDropdown(ProfileConstants.genderLabel,
                ProfileConstants.genderHint, _genderController),
            getDateTextField(ProfileConstants.dobLabel,
                ProfileConstants.dobHint, _dobController),
            getDropdownState(ProfileConstants.stateLabel,
                ProfileConstants.stateHint, _stateController),
            getTextField(ProfileConstants.cityLabel, ProfileConstants.cityHint,
                _cityController),
            getButton()
          ],
        ),
      )
    ]));
  }

  Padding getButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
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
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.buttonColor,
            ),
            onPressed: _save,
            child: const Text(
              'Update',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  void _save() {
    if (_FormKey.currentState!.validate()) {
      if (_mobileController.text != (userModel?.mobileNo)!) {
        _displayDialog(context).then((value) {
          if (value == "update_user") {
            _updateUser();
          }
        });
      } else {
        _updateUser();
      }
    }
  }

  void _updateUser() {
    userModel?.firstName = _firstNameController.text;
    userModel?.lastName = _lastNameController.text;
    userModel?.mobileNo = _mobileController.text;
    userModel?.dob = _dobController.text;
    userModel?.city = _cityController.text;
    userModel?.state = _selectedState;
    userModel?.gender = _selectedGender;
    AppUtils.onLoading(context, "Saving...");
    UserListViewModel()
        .updateStudentProfile(userModel!)
        .then(_onSuccess)
        .catchError(_onError);
  }

  _onError(error, stacktrace) {
    AppUtils.onError(context, error);
  }

  FutureOr<void> _onSuccess(value) {
    SharedPreferences.getInstance().then((prefs) {
      prefs
          .setString(SharedPrefsConstants.userKey, userModel!.toJson())
          .then((value) {
        Navigator.pop(context);
        AppUtils.launchTab(context,
            selectedIndex: HomeTabsOptions.profile.index);
      });
    });
  }

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
            readOnly: true,
            controller: contorller,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              // ignore: prefer_const_constructors
              suffix: Icon(
                Icons.calendar_today,
                color: AppColor.buttonColor,
              ),
              hintText: text,
              border: const OutlineInputBorder(),
            ), //editing controller of this TextField
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now());
              if (pickedDate != null) {
                String formattedDate =
                    DateFormat("dd-MM-yyyy").format(pickedDate);

                setState(() {
                  contorller.text =
                      formattedDate; //set output date to TextField value.
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Padding getTextField(
      String label, String text, TextEditingController contorller,
      {String? Function(String?)? validator, keyboardType}) {
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
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: text,
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

  _displayDialog(BuildContext context, {OtpFieldController? controller}) async {
    AppUtils.onLoading(context, "Please Wait...");
    mobileNo = _mobileController.text;
    reason = 'UPDATE_USER';
    appSignatureID = await SmsAutoFill().getAppSignature;

    // ignore: avoid_single_cascade_in_expression_statements
    UserListViewModel()
        .getOTP(mobileNo!, "UPDATE_USER", appSignatureID)
        .then((otp) {
      Navigator.pop(context);

      oneTimePassword = otp;
      showDialogOTP();
    }).catchError((onError) {
      Navigator.pop(context);
      List<String> errorMessages = AppUtils.getErrorMessages(onError);
      AppUtils.getAlert(context, errorMessages, title: "Error Alert");
    });

    // Navigator.pop(context);
  }

  Future<dynamic> showDialogOTP() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('OTP Verification')),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //position
              mainAxisSize: MainAxisSize.min,
              children: [
                PinFieldAutoFill(
                  currentCode: otpVerification,
                  codeLength: 4,
                  onCodeChanged: (code) {
                    otpVerification = code.toString();

                    // print("onCodeChanged $code");
                    // setState(() {
                    //   otpVerification = code.toString();
                    // });
                  },
                  onCodeSubmitted: (val) {
                    print("onCodeSubmitted $val");
                  },
                ),
                // OTPTextField(
                //     controller: otpController,
                //     length: 4,
                //     width: MediaQuery.of(context).size.width,
                //     textFieldAlignment: MainAxisAlignment.spaceAround,
                //     fieldWidth: 45,
                //     //fieldStyle: FieldStyle.box,
                //     outlineBorderRadius: 15,
                //     style: const TextStyle(fontSize: 17),
                //     onChanged: (pin) {
                //       otpVerification = pin;
                //     },
                //     onCompleted: (pin) {}),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      'Do not receive OTP?',
                      style: TextStyle(fontSize: 10, color: Colors.red),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        UserListViewModel()
                            .getOTP(mobileNo!, "UPDATE_USER", appSignatureID)
                            .then((records) {
                          oneTimePassword = records;
                          //showDialogOTP(records);
                        }).catchError((onError) {
                          Navigator.pop(context);
                          List<String> errorMessages =
                              AppUtils.getErrorMessages(onError);
                          AppUtils.getAlert(context, errorMessages,
                              title: "Error Alert");
                        });
                      },
                      child: const Text(
                        'Resend OTP',
                        style:
                            TextStyle(fontSize: 10, color: AppColor.textColor),
                      ),
                    ),
                  ],
                )
              ],
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
                        _submit();
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

  void _submit() {
    if (otpVerification == oneTimePassword.toString()) {
      userModel?.firstName = _firstNameController.text;
      userModel?.lastName = _lastNameController.text;
      userModel?.mobileNo = _mobileController.text;
      userModel?.dob = _dobController.text;
      userModel?.city = _cityController.text;
      userModel?.state = _selectedState;
      userModel?.gender = _selectedGender;
      UserListViewModel()
          .updateStudentProfile(userModel!)
          .then(_onSuccess)
          .catchError(_onError);
      Navigator.pop(context, "update_user");
    } else {
      Navigator.pop(context);
      AppUtils.showAlertDialog(context, 'Error', 'Wrong otp entered');
    }
  }
}
