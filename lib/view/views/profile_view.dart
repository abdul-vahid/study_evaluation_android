import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/function_lib.dart';
import 'package:study_evaluation/view/widgets/app_drawer_widget.dart';

import '../../models/user_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/enum.dart';
import '../../view_models/user_view_model/user_list_vm.dart';
import '../widgets/widget_utils.dart';
import 'edit_profile_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? profileUrl;
  UserModel? userModel;

  File? selectedImage;
  String base64Image = "";
  Future<String> chooseImage(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);

        base64Image = base64Encode(selectedImage!.readAsBytesSync());

        // won't have any error now
      });
    }

    return base64Image;
  }

  void getProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userModel = AppUtils.getSessionUser(prefs);
      if (userModel?.profileUrl != null) {
        profileUrl = AppUtils.getImageUrl(userModel?.profileUrl);
      }
    });
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      var userModel = AppUtils.getSessionUser(prefs);
      userModel ?? AppUtils.logout(context);
    });
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    return Scaffold(
      drawer: const AppDrawerWidget(),
      appBar: AppUtils.getAppbar("My Profile"),
      body: _getBody(context),
    );
  }

  SingleChildScrollView _getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              color: AppColor.primaryColor,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(0), // Border radius
                            child: ClipOval(
                                child: FadeInImage.assetNetwork(
                              placeholder: "assets/images/loading.gif",
                              image: profileUrl ?? "",
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/profile-image.png',
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                );
                              },
                            )),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: AppColor.containerBoxColor,
                              ),
                              child: InkWell(
                                onTap: () {
                                  uploadImage();

                                  // (base64Image, id);
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Text(
                    userModel?.fullName ?? "",
                    style: const TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  getColumn('Mobile No.', userModel?.mobileNo ?? ''),
                  getColumn('Date of Birth', userModel?.dob ?? ''),
                  getColumn('Gender', userModel?.gender ?? ''),
                  getColumn('State', userModel?.state ?? ''),
                  getColumn('City', userModel?.city ?? ''),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      backgroundColor: AppColor.containerBoxColor,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfileView()),
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }

  void uploadImage() async {
    // ignore: use_build_context_synchronously
    AppUtils.onLoading(context, "Please Wait...");
    String seletedImage = await chooseImage("Gallery");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (selectedImage != null) {
      UserListViewModel()
          .updateProfilePicture((userModel?.id)!, seletedImage)
          .then((records) {
        setState(() {
          userModel?.profileUrl = records;
          prefs.setString(SharedPrefsConstants.userKey, (userModel?.toJson())!);
          profileUrl = AppUtils.getImageUrl(records);
          debug('profileUrl $profileUrl');
        });
        Timer(const Duration(seconds: 1), (() {
          Navigator.pop(context);
        }));
      }).catchError((onError) {
        Navigator.pop(context);
        List<String> errorMessages = AppUtils.getErrorMessages(onError);
        AppUtils.getAlert(context, errorMessages, title: "Error Alert");
      });
    } else {
      Navigator.pop(context);
    }
  }

  Column getColumn(String label, String profileInput) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.grey[700],
          ),
        ),

        // ignore: prefer_const_constructors
        SizedBox(
          height: 10,
        ),
        Text(
          profileInput,
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Divider(
          color: Colors.grey[700],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
