import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/view/screens/aboutus_screen.dart';
import 'package:study_evaluation/view/screens/followus_screen.dart';
import 'package:study_evaluation/view/screens/myorder_screen.dart';
import 'package:share_plus/share_plus.dart';

import '../screens/feedbackalertdialog.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
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
                    backgroundImage: NetworkImage(
                        'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                    radius: 40.0,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Leon Roy',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      '9876543234',
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
                MaterialPageRoute(builder: (context) => const MYOrderScreen()),
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
              showDialog(
                barrierColor: Colors.black26,
                context: context,
                builder: (context) {
                  return FeedbackAlertDialog();
                },
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
