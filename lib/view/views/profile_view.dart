import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/view/widgets/app_drawer_widget.dart';

import '../../models/user_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
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
                    child: Container(
                      // height: 120,
                      // width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),

                        borderRadius: BorderRadius.circular(60), //<-- SEE HERE
                      ),
                      child: CircleAvatar(
                        backgroundImage: profileUrl == null
                            ? const NetworkImage(
                                'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg')
                            : NetworkImage(profileUrl!),
                        radius: 60.0,
                      ),
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
            // const SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  getColumn('Mobile No.', '${userModel?.mobileNo}'),
                  getColumn('Date of Birth', '${userModel?.dob}'),
                  getColumn('Gender', '${userModel?.gender}'),
                  getColumn('State', '${userModel?.state}'),
                  getColumn('City', '${userModel?.city}'),
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

  Column getColumn(String label, String profileInput) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.grey,
          ),
        ),

        // ignore: prefer_const_constructors
        SizedBox(
          height: 10,
        ),
        Text(
          profileInput,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        const Divider(
          color: Colors.grey,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
