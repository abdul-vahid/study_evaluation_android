import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class EnglishScreen extends StatefulWidget {
  const EnglishScreen({super.key});

  @override
  State<EnglishScreen> createState() => _EnglishScreenState();
}

class _EnglishScreenState extends State<EnglishScreen> {
  String? question; //no radio button will be selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(color: Colors.white),
          title: Text("English"),
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
                          '(Q.2) Select the synonym of deprive',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  RadioListTile(
                    title: Text("bestow"),
                    value: "bestow",
                    groupValue: question,
                    onChanged: (value) {
                      setState(() {
                        question = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("endow"),
                    value: "endow",
                    groupValue: question,
                    onChanged: (value) {
                      setState(() {
                        question = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("confer"),
                    value: "confer",
                    groupValue: question,
                    onChanged: (value) {
                      setState(() {
                        question = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("dispossess"),
                    value: "dispossess",
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
                          '(Q.3) Select the antonym of genteel',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  RadioListTile(
                    title: Text("uncivilized"),
                    value: "uncivilized",
                    groupValue: question,
                    onChanged: (value) {
                      setState(() {
                        question = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("prim"),
                    value: "prim",
                    groupValue: question,
                    onChanged: (value) {
                      setState(() {
                        question = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("confer"),
                    value: "confer",
                    groupValue: question,
                    onChanged: (value) {
                      setState(() {
                        question = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("urbane"),
                    value: "urbane",
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
