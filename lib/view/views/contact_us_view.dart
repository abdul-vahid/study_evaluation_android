// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_color.dart';
import '../../utils/function_lib.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButton(color: Colors.white),
          title: const Text("Contact Us"),
          elevation: .1,
          backgroundColor: AppColor.appBarColor,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(children: [
                  getCard('Contact Us', '+9186199-90680',
                      'studyevaluation@gmail.com'),
                ]))));
  }

  Card getCard(String lable, String text, String textEmail) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Container(
            height: 40,
            width: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: AppColor.containerBoxColor),
            child: Center(
                child: Text(
              lable,
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 20, bottom: 10),
            child: InkWell(
              onTap: () {
                AppUtils.makePhoneCall(text);
              },
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    text,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 20, bottom: 20),
            child: InkWell(
              onTap: () async {
                final url = 'mailto:$textEmail?subject=&body=';
                final uri = Uri.parse(url);
                debug("url = $url");

                if (!await launchUrl(uri)) {}
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.email, color: Colors.black),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    textEmail,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
