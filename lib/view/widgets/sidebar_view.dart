// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/models/login_model/user.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/aboutus_view.dart';
import 'package:study_evaluation/view/views/followus_screen.dart';
import 'package:study_evaluation/view/views/myorder_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:study_evaluation/view/views/profile_view.dart';
import 'package:study_evaluation/view_models/user_view_model/user_list_vm.dart';

import '../../utils/app_constants.dart';
import '../views/feedback_view.dart';
import '../views/feedbackalertdialog.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  UserListViewModel userListViewModel = UserListViewModel();

  //  final SharedPreferences pref = await SharedPreferences.getInstance();

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

  // final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(SharedPrefsConstants.prefsAccessTokenKey);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColor.appBarColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  // height: 120,
                  // width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),

                    borderRadius: BorderRadius.circular(50), //<-- SEE HERE
                  ),
                  child: CircleAvatar(
                    backgroundImage: profileUrl == null
                        ? NetworkImage(
                            'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg')
                        : NetworkImage(profileUrl!),
                    radius: 40.0,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Text(
                      userModel?.name ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      userModel?.mobileNo ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14.0),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.task_sharp,
              color: AppColor.navBarIconColor,
            ),
            title: Text(
              'My Order',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyOrderView()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.touch_app,
              color: AppColor.navBarIconColor,
            ),
            title: Text(
              'Follow Us',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FollowUsScreen()),
              )
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.feedback,
              color: AppColor.navBarIconColor,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileView()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.feedback,
              color: AppColor.navBarIconColor,
            ),
            title: Text(
              'Feedback',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedbackView()),
              );
            },
          ),
          Divider(),
          ListTile(
              leading: Icon(
                Icons.location_history_rounded,
                color: AppColor.navBarIconColor,
              ),
              title: Text(
                'About Us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AboutUsScreen()),
                );
              }),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.share,
              color: AppColor.navBarIconColor,
            ),
            title: Text(
              'Share App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Share.share('com.example.share_app', subject: 'Welcome Message');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: AppColor.navBarIconColor,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
