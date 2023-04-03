// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/utils/enum.dart';
import 'package:study_evaluation/view/views/aboutus_view.dart';
import 'package:study_evaluation/view/views/contact_us_view.dart';
import 'package:study_evaluation/view/views/follow_us_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:study_evaluation/view/views/terms_conditions_view.dart';
import 'package:study_evaluation/view_models/user_view_model/user_list_vm.dart';
import '../../utils/app_constants.dart';
import '../../view_models/follow_us_list_vm.dart';
import '../views/feedback_view.dart';

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
          InkWell(
            onTap: () {
              AppUtils.launchTab(context,
                  selectedIndex: HomeTabsOptions.profile.index);
            },
            child: DrawerHeader(
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
                            fontSize: 18.0),
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
              AppUtils.launchTab(context,
                  selectedIndex: HomeTabsOptions.home.index);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.edit_note,
              color: AppColor.navBarIconColor,
            ),
            title: Text(
              'Test Series',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              AppUtils.launchTab(context,
                  selectedIndex: HomeTabsOptions.testSeries.index);
            },
          ),
          Divider(),
          ListTile(
              leading: Icon(
                Icons.notification_add,
                color: AppColor.navBarIconColor,
              ),
              title: Text(
                'Notifications',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                AppUtils.launchTab(context,
                    selectedIndex: HomeTabsOptions.notifications.index);
              }),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              color: AppColor.navBarIconColor,
            ),
            title: Text(
              'My Order',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              AppUtils.launchTab(context,
                  selectedIndex: HomeTabsOptions.myOrder.index);
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
              Icons.person,
              color: AppColor.navBarIconColor,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              AppUtils.launchTab(context,
                  selectedIndex: HomeTabsOptions.profile.index);
            },
          ),
          Divider(),
          ListTile(
              leading: Icon(
                Icons.info_outlined,
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
                Icons.alternate_email,
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
              Share.share(AppConstants.appUrlPath, subject: 'Welcome Message');
            },
          ),
          Divider(),
          ListTile(
              leading: Icon(
                Icons.sticky_note_2_outlined,
                color: AppColor.navBarIconColor,
              ),
              title: Text(
                'Terms & Conditions',
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
              showAlertDialog();
            },
          ),
        ],
      ),
    );
  }

  showAlertDialog() {
    Widget noButton = TextButton(
      child: Text("No"),
      onPressed: () {
        // debug("No");
        Navigator.pop(context);
      },
    );
    // set up the buttons
    Widget yesButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.pop(context);
        AppUtils.logout(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure you want to Logout"),
      actions: [
        noButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
