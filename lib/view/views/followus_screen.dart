import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class FollowUsScreen extends StatefulWidget {
  const FollowUsScreen({super.key});

  @override
  State<FollowUsScreen> createState() => _FollowUsScreenState();
}

class _FollowUsScreenState extends State<FollowUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(color: Colors.white),
          title: Text("Follow Us"),
          elevation: .1,
          backgroundColor: AppColor.appBarColor,
        ),
        body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
          Card(
              child: ListTile(
            title: Text(
              "Follow On Facebook",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColor.textColor),
            ),
            leading: Image.asset(
              'assets/images/facebook.png',
              height: 60,
              width: 60,
            ),
          )),
          Card(
              child: ListTile(
            title: Text(
              "Follow On Instagram",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColor.textColor),
            ),
            leading: Image.asset(
              'assets/images/instagram.png',
              height: 60,
              width: 60,
            ),
          )),
          Card(
              child: ListTile(
            title: Text(
              "Subscribe on Youtube",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColor.textColor),
            ),
            leading: Image.asset(
              'assets/images/youtube.png',
              height: 60,
              width: 60,
            ),
          )),
          Card(
              child: ListTile(
            title: Text(
              "Contact Us",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColor.textColor),
            ),
            leading: Image.asset(
              'assets/images/whatsapp.png',
              height: 70,
              width: 60,
            ),
          )),
        ]));
  }
}
