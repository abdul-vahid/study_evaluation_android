import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class ResultHindiEnglishView extends StatefulWidget {
  const ResultHindiEnglishView({super.key});

  @override
  State<ResultHindiEnglishView> createState() => _ResultHindiEnglishViewState();
}

class _ResultHindiEnglishViewState extends State<ResultHindiEnglishView> {
  String? question; //no radio button will be selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(color: Colors.white),
          title: Text("Hindi/English"),
          elevation: .1,
          backgroundColor: AppColor.appBarColor,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
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
                          '(Q.1) Select the antonym of intrinsic',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  RadioListTile(
                    title: Text("acquired"),
                    value: "acquired",
                    groupValue: question,
                    onChanged: (value) {
                      setState(() {
                        question = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("elemental"),
                    value: "elemental",
                    groupValue: question,
                    onChanged: (value) {
                      setState(() {
                        question = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("innate"),
                    value: "innate",
                    groupValue: question,
                    onChanged: (value) {
                      setState(() {
                        question = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("connate"),
                    value: "connate",
                    groupValue: question,
                    onChanged: (value) {
                      setState(() {
                        question = value.toString();
                      });
                    },
                  )
                ]),
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
                    RadioListTile(
                      title: Text("भारोपीय"),
                      value: "भारोपीय",
                      groupValue: question,
                      onChanged: (value) {
                        setState(() {
                          question = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("द्रविड़"),
                      value: "द्रविड़",
                      groupValue: question,
                      onChanged: (value) {
                        setState(() {
                          question = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("आस्ट्रिक"),
                      value: "आस्ट्रिक",
                      groupValue: question,
                      onChanged: (value) {
                        setState(() {
                          question = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("चीनी-तिब्बती"),
                      value: "चीनी-तिब्बती",
                      groupValue: question,
                      onChanged: (value) {
                        setState(() {
                          question = value.toString();
                        });
                      },
                    )
                  ]),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
        ])));
  }
}
