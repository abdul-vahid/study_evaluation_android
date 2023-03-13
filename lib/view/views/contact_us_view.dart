// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/app_utils.dart';

import '../../utils/app_color.dart';

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
                  getCard('Contact Us', '+91 86199-90680'),
                  SizedBox(
                    height: 20,
                  ),
                  getCard('Address',
                      'Study Evaluation Police Line, Ajmer, Rajasthan 305001'),
                ]))));
  }

  Card getCard(String lable, String text) {
    return Card(
      elevation: 5,
      child: Container(
          height: 130,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              color: Color(0xFFf8f9fa)),
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
                padding: const EdgeInsets.only(left: 45, right: 45),
                child: Center(
                    child: Text(
                  text,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                )),
              )
            ],
          )),
    );
  }
}
