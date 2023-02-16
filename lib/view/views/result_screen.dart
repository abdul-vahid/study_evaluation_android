import 'package:flutter/material.dart';
import 'package:study_evaluation/view/screens/Hindi_screen.dart';
import 'package:study_evaluation/view/views/analysis_screen.dart';
import 'package:study_evaluation/view/views/both_screen.dart';
import 'package:study_evaluation/view/views/english_screen.dart';
import 'package:study_evaluation/view/views/leardebord.dart';

import '../../utils/app_color.dart';
import '../widgets/custom_alertdialog.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Result"),
          leading: GestureDetector(
            onTap: () {
              showDialog(
                barrierColor: Colors.black26,
                context: context,
                builder: (context) {
                  return CustomAlertDialog();
                },
              );
            },
            child: Icon(
              Icons.apps_rounded, // add custom icons also
            ),
          ),
          elevation: .1,
          backgroundColor: AppColor.appBarColor,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 20,
            ),
            child: Container(
                alignment: Alignment.topCenter,
                child: Container(
                    height: 50,
                    padding: EdgeInsets.all(3.5),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Color(0xFFfef5e6),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Color(0xFFe0d9cd), width: 2)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LearderbordView()),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Leaderboard",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                ))),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child:
                                Container(color: Color(0xFFe0d9cd), width: 2)),
                        Expanded(
                            child: InkWell(
                                onTap: () {
                                  _asyncSimpleDialog(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("MEDIUM",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17)),
                                      Text("Font-Size",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                    ],
                                  ),
                                ))),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child:
                                Container(color: Color(0xFFe0d9cd), width: 2)),
                        Expanded(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AnalysisScreen()),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Analytics",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                )))
                      ],
                    ))),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            child: Container(
                height: 40,
                width: 250,
                padding: EdgeInsets.all(2),
                // width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: AppColor.containerBoxColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HindiScreen()),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text("Hindi",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17)),
                            ))),
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EnglishScreen()),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // borderRadius: BorderRadius.only(
                                //     bottomLeft: Radius.circular(12),
                                //     topLeft: Radius.circular(12))
                              ),
                              child: Text("English",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  )),
                            ))),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                            color: AppColor.containerBoxColor, width: 2)),
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BothScreen()),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(8),
                                      topRight: Radius.circular(8))),
                              child: Text("Both",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  )),
                            ))),
                  ],
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.buttonColor,
                  ),
                  onPressed: () {},
                  child: Text('All(15)',
                      style: TextStyle(
                        // color: Colors.blue,
                        fontSize: 12,
                      )),
                ),
                SizedBox(
                  width: 3,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(
                        width: 2.0, color: AppColor.containerBoxColor),
                  ),
                  onPressed: () {},
                  child: Text('Correct(18)',
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 12,
                      )),
                ),
                SizedBox(
                  width: 3,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(
                        width: 2.0, color: AppColor.containerBoxColor),
                  ),
                  onPressed: () {},
                  child: Text('Wrong(10)',
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 12,
                      )),
                ),
                SizedBox(
                  width: 3,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(
                        width: 2.0, color: AppColor.containerBoxColor),
                  ),
                  onPressed: () {},
                  child: Text('Skipped(2)',
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 12,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: InkWell(
                  onTap: () {
                    // onButtonPressed();
                  },
                  child: Column(children: [
                    Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color: AppColor.containerBoxColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8.0),
                              topLeft: Radius.circular(8.0)),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '(Q.1) हिंदी किस भाषा परिवार की भाषा है',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            //  width: 400,
                            decoration: BoxDecoration(
                              color: Colors.green.shade200,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Text('(A)',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('भारोपीय',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Row(
                              children: [
                                Text('(B)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('द्रविड़',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Row(
                              children: [
                                Text('(C)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('चीनी-तिब्बती',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Row(
                              children: [
                                Text('(D)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('भारोपीय',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Divider(
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "व्याख्या:  सरल शब्दों में- 'व्याख्या' किसी भाव या विचार के विस्तार और विवेचन को कहते हैं। व्याख्या में पद-निर्देश, अलंकार, कठिन शब्दों का अर्थ तथा समानांतर पंक्तियों से तुलना आवश्यक है।",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          maxLines: 15,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: InkWell(
                  onTap: () {
                    // onButtonPressed();
                  },
                  child: Column(children: [
                    Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color: AppColor.containerBoxColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8.0),
                              topLeft: Radius.circular(8.0)),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '(Q.1) हिंदी किस भाषा परिवार की भाषा है',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            //  width: 400,
                            decoration: BoxDecoration(
                              color: Colors.green.shade200,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Text('(A)',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('भारोपीय',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Row(
                              children: [
                                Text('(B)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('द्रविड़',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Row(
                              children: [
                                Text('(C)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('चीनी-तिब्बती',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Row(
                              children: [
                                Text('(D)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('भारोपीय',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Divider(
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "व्याख्या:  सरल शब्दों में- 'व्याख्या' किसी भाव या विचार के विस्तार और विवेचन को कहते हैं। व्याख्या में पद-निर्देश, अलंकार, कठिन शब्दों का अर्थ तथा समानांतर पंक्तियों से तुलना आवश्यक है।",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          maxLines: 15,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            color: AppColor.primaryColor,
          )
        ])));
  }
}

enum FontSize { Small, Medium, large }

Future<FontSize?> _asyncSimpleDialog(BuildContext context) async {
  FontSize? _size = FontSize.Small;

  return await showDialog<FontSize>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          //   shape: EdgeInsets.all(value),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Center(child: const Text('Select Font Size ')),
          children: <Widget>[
            new Divider(
              color: Colors.grey.shade300,
            ),
            ListTile(
              title: const Text('Small'),
              leading: Radio<FontSize>(
                value: FontSize.Small,
                groupValue: _size,
                onChanged: (FontSize? value) {
                  // setState(() {
                  //   _character = value;
                  // });
                },
              ),
            ),
            ListTile(
              title: const Text('Medium'),
              leading: Radio<FontSize>(
                value: FontSize.Medium,
                groupValue: _size,
                onChanged: (FontSize? value) {
                  // setState(() {
                  //   _character = value;
                  // });
                },
              ),
            ),
            ListTile(
              title: const Text('Large'),
              leading: Radio<FontSize>(
                value: FontSize.large,
                groupValue: _size,
                onChanged: (FontSize? value) {
                  // setState(() {
                  //   _character = value;
                  // });
                },
              ),
            ),
          ],
        );
      });
}
