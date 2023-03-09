// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/models/login_model/user.dart';
import 'package:study_evaluation/models/package_model/test_series.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/aboutus_view.dart';
import 'package:study_evaluation/view/views/category_list_view.dart';
import 'package:study_evaluation/view/views/contact_us_view.dart';
import 'package:study_evaluation/view/views/follow_us_view.dart';
import 'package:study_evaluation/view/views/leardeboard_view.dart';
import 'package:study_evaluation/view/views/myorder_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:study_evaluation/view/views/profile_view.dart';
import 'package:study_evaluation/view/views/terms_conditions_view.dart';
import 'package:study_evaluation/view_models/category_list_vm.dart';
import 'package:study_evaluation/view_models/user_view_model/user_list_vm.dart';

import '../../core/models/base_list_view_model.dart';
import '../../utils/app_constants.dart';
import '../../view_models/feedback_list_vm.dart';
import '../../view_models/follow_us_list_vm.dart';
import '../../view_models/slider_image_list_vm.dart';
import '../views/feedback_view.dart';
import '../views/feedbackalertdialog.dart';
import '../views/home_main_view.dart';

class AppDrawerWidget extends StatefulWidget {
  const AppDrawerWidget({super.key});

  @override
  State<AppDrawerWidget> createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
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
                            'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png')
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
              Icons.home,
              color: AppColor.navBarIconColor,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                  create: (_) => CategoryListViewModel()),
                              ChangeNotifierProvider(
                                  create: (_) => SliderImageListViewModel()),
                              ChangeNotifierProvider(
                                  create: (_) => FeedbackListViewModel()),
                            ],
                            child: const HomeMainView(),
                          )));
            },
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
                MaterialPageRoute(
                    builder: (context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                                create: (_) => BaseListViewModel())
                          ],
                          child: const MyOrderView(),
                        )),
              );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const FollowUsView()),
              // )
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
                MaterialPageRoute(
                    builder: (context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                                create: (_) => FollowUSListViewModel())
                          ],
                          child: const FollowUsView(),
                        )),
              )
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const FollowUsView()),
              // )
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
              Icons.feedback,
              color: AppColor.navBarIconColor,
            ),
            title: Text(
              'Test Series',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                  create: (_) => CategoryListViewModel()),
                            ],
                            child: const CategoryListView(),
                          )));
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
                Icons.location_history_rounded,
                color: AppColor.navBarIconColor,
              ),
              title: Text(
                'Terms & Conditions ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TermsConditionsView()),
                );
              }),
          Divider(),
          ListTile(
              leading: Icon(
                Icons.location_history_rounded,
                color: AppColor.navBarIconColor,
              ),
              title: Text(
                'Contact Us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactUsView()),
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
              AppUtils.logout(context);
            },
          ),
        ],
      ),
    );
  }
}
