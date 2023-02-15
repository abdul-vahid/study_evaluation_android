import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class HindiScreen extends StatefulWidget {
  const HindiScreen({super.key});

  @override
  State<HindiScreen> createState() => _HindiScreenState();
}

class _HindiScreenState extends State<HindiScreen> {
  String? question; //no radio button will be selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(color: Colors.white),
          title: Text("Hindi"),
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
                            '(Q.2) भारत में सबसे अधिक बोले जाने वाली भाषा कौन सी है',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    RadioListTile(
                      title: Text("हिंदी"),
                      value: "हिंदी",
                      groupValue: question,
                      onChanged: (value) {
                        setState(() {
                          question = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("संस्कृत"),
                      value: "संस्कृत",
                      groupValue: question,
                      onChanged: (value) {
                        setState(() {
                          question = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("तमिल"),
                      value: "तमिल",
                      groupValue: question,
                      onChanged: (value) {
                        setState(() {
                          question = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("उर्दू"),
                      value: "उर्दू",
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
                          '(Q.3) हिंदी भाषा का जन्म हुआ है',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  RadioListTile(
                    title: Text("अपभ्रंश से"),
                    value: "अपभ्रंश से",
                    groupValue: question,
                    onChanged: (value) {
                      setState(() {
                        question = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("लौकिक संस्क्रत से"),
                    value: "लौकिक संस्क्रत से",
                    groupValue: question,
                    onChanged: (value) {
                      setState(() {
                        question = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("वैदिक संस्कृत से"),
                    value: "वैदिक संस्कृत से",
                    groupValue: question,
                    onChanged: (value) {
                      setState(() {
                        question = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("पालि-प्राकृत से"),
                    value: "पालि-प्राकृत से",
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
          SizedBox(
            height: 10,
          ),
        ])));
  }
}
