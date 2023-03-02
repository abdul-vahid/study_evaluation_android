import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/view/views/profile_view.dart';
import 'package:study_evaluation/view_models/user_view_model/user_list_vm.dart';

import '../../models/user_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final GlobalKey<FormState> _feedbackFormKey = GlobalKey<FormState>();

  // String? profileUrl;
  UserModel? userModel;

  //late TextEditingController name = TextEditingController.fromValue(TextEditingValue(text: userModel?.firstName));
  final _firstNameCtrl = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

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
          title: Text('${userModel?.email}'),
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
                    ProfileConstants.mobileHint, _mobileController),
                getTextField(
                    ProfileConstants.genderLabel, 'Male', _genderController),
                getTextField(ProfileConstants.dobLabel,
                    ProfileConstants.dobHint, _dobController),
                getTextField(ProfileConstants.cityLabel,
                    ProfileConstants.cityHint, _cityController),
                getTextField(ProfileConstants.stateLabel,
                    ProfileConstants.stateHint, _stateController),
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
            onPressed: () {},
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
    userModel?.firstName = _firstNameController.text;
    userModel?.lastName = _lastNameController.text;
    userModel?.mobileNo = _mobileController.text;
    userModel?.dob = _dobController.text;
    userModel?.city = _cityController.text;
    userModel?.state = _stateController.text;
    userModel?.gender = _genderController.text;
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

  Padding getTextField(
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
}
