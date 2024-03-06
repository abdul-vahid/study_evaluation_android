// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/app_utils.dart';

import '../../utils/app_color.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(color: Colors.white),
          title: Text("About Us"),
          elevation: .1,
          backgroundColor: AppColor.appBarColor,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'About Us',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.only(
                    // top: 20,
                    left: 30,
                    right: 20,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Center(
                    child: Text(
                      'Our mission is "To educate Students and help them excel in competitive exam prepartion to the best of their potential. To impart good values in eventually develop their personality."',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                color: AppColor.containerBoxColor,
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      Center(
                          child: Text(
                        'We Provide',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      BulletList(
                        const [
                          'Qualified and talented teachers.',
                          'Modern and tech-equipped premises.',
                          'Stable learning Test series and video courses.',
                          'Regular interaction with Students and their parents/guardians.',
                          'Here,we note only educate the student to be succesful,but also nurture them with values to be better humans.',
                        ],
                        children: [],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}

class BulletList extends StatelessWidget {
  final List<String> strings;

  BulletList(this.strings, {required List<Widget> children});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\u2022',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  height: 0.75,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    str,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      height: 1.10,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
