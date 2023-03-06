// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButton(color: Colors.white),
          title: const Text("COntact Us"),
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
                      Card(
                        elevation: 5,
                        child: Container(
                          height: 130,
                          width: 350,
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              // borderRadius: BorderRadius.only(
                              //   topLeft: Radius.circular(20),
                              //   bottomRight: Radius.circular(20),
                              // ),
                              color: Color(0xFFf8f9fa)),
                          child: Padding(
                            padding: EdgeInsets.only(
                              // top: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: Center(
                              child: Text(
                                'Our mission is "To educate Students and help them excel in Compitive exam prepartion to the best of their potential. To impart good values in eventually develop their personality."',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]))));
  }
}
