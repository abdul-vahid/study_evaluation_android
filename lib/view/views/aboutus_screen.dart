import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
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
                child: Container(
                  height: 100,
                  width: 350,
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
                      top: 20,
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      'Our mission is "To educate Students and help them excel in Compitive exam prepartion to the best of their potential. To impart good values in eventually develop their personality."',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 300,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(20),
                    //   bottomRight: Radius.circular(20),
                    // ),
                    color: AppColor.containerBoxColor),
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 40),
                  child: Column(
                    children: [
                      Center(
                          child: Text(
                        'We Provide',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        Text(
                          "\u2022",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ), //bullet text
                        SizedBox(
                          width: 10,
                        ), //space between bullet and text
                        Expanded(
                          child: Text(
                            "Qualified and talented teachers.",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ), //text
                        )
                      ]),
                      Row(children: [
                        Text(
                          "\u2022",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ), //bullet text
                        SizedBox(
                          width: 10,
                        ), //space between bullet and text
                        Expanded(
                          child: Text(
                            "Modern and tech-equipped premises.",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ), //text
                        )
                      ]),
                      Row(children: [
                        Text(
                          "\u2022",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ), //bullet text
                        SizedBox(
                          width: 10,
                        ), //space between bullet and text
                        Expanded(
                          child: Text(
                            "Stable learning Test series and video courses.",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ), //text
                        )
                      ]),
                      Row(children: [
                        Text(
                          "\u2022",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ), //bullet text
                        SizedBox(
                          width: 10,
                        ), //space between bullet and text
                        Expanded(
                          child: Text(
                            "Stable learning Test series and video courses.",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ), //text
                        )
                      ]),
                      Row(children: [
                        Text(
                          "\u2022",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ), //bullet text
                        SizedBox(
                          width: 10,
                        ), //space between bullet and text
                        Expanded(
                          child: Text(
                            "Regular interacting with Student and their parent/guardians.",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ), //text
                        )
                      ]),
                      Row(children: [
                        Text(
                          "\u2022",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ), //bullet text
                        SizedBox(
                          width: 10,
                        ), //space between bullet and text
                        Expanded(
                          child: Text(
                            "Here we not only the students to be successful, but also nurture them with values to be better humans",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ), //text
                        )
                      ]),
                    ],
                  ),
                ),
              ),

              // Expanded(
              //     flex: 1,
              //     child: Container(
              //       height: 100,
              //     ))
            ],
          ),
        )));
  }
}