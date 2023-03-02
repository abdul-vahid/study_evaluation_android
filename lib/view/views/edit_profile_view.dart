import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  TextEditingController _firstNameController = TextEditingController();
  // TextEditingController nameController = new TextEditingController(text: userModel?.firstName);

  String? _firstName = "Hwllo";
  String? lastname;

  void getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    _firstName = userModel?.firstName;

    // _firstNameCtrl.text = userModel?.firstName;
    setState(() {
      userModel = AppUtils.getSessionUser(prefs);
      _firstName = userModel?.firstName;
      _firstNameController.text = _firstName!;
      print("First Name = $_firstName");
      // if (userModel?.profileUrl != null) {
      //   profileUrl = AppUtils.getImageUrl(userModel?.profileUrl);
      // }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    getProfileData();

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
                getTextField('First Name', 'Enter ', _firstNameController),
                getTextField('Last Name', 'Sahu', _firstNameController),
                getTextField('Mobile No.', '9876543212', _firstNameController),
                getTextField(
                    'Date/of/birth', '13-03-1995', _firstNameController),
                getTextField('Gander', 'Male', _firstNameController),
                getAddressTextField(),
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
            onPressed: () {},
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Padding getAddressTextField() {
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
  }

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
            // key: formKeyList[0] as Glo,
            controller: contorller,

            keyboardType: TextInputType.text,
            onSaved: (value) {
              _firstName = value;
            },
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
