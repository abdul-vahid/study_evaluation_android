import 'package:flutter/material.dart';
import 'package:study_evaluation/view/views/result_screen.dart';

import '../../utils/app_color.dart';

class RajasthanConstableSpecialScreen extends StatefulWidget {
  const RajasthanConstableSpecialScreen({super.key});

  @override
  State<RajasthanConstableSpecialScreen> createState() =>
      _RajasthanConstableSpecialScreenState();
}

class _RajasthanConstableSpecialScreenState
    extends State<RajasthanConstableSpecialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(color: Colors.white),
          title: Text("Rajasthan Constable Special"),
          elevation: .1,
          backgroundColor: AppColor.appBarColor,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Column(children: [
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.buttonColor // foreground
                      ),
                  onPressed: () {},
                  child: Text('Buy Now'),
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 450,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColor.containerBoxColor,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        // padding: EdgeInsets.only(
                        //     left: 5, top: 10, right: 5, bottom: 10),
                        height: 100,
                        width: MediaQuery.of(context).size.width,

                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: new AssetImage(
                            "assets/images/rajasthan-police.png",
                          ),
                          fit: BoxFit.fill,
                        )),
                        //  color: Color.fromARGB(255, 209, 208, 210),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text("Rajasthan Constable Special",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  letterSpacing: 1)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            Text('Price:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFFc78f8f))),
                            SizedBox(
                              width: 5,
                            ),
                            Text('₹399:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                    new Divider(
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          maxLines: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            Text('Validity:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFFc78f8f))),
                            SizedBox(
                              width: 5,
                            ),
                            Text('1 Year',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 274,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Free',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: AppColor.textColor))),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 35,
                          width: 250,
                          decoration: BoxDecoration(
                            color: AppColor.containerBoxColor,
                            borderRadius: const BorderRadius.only(
                                // topRight: Radius.circular(8.0),
                                // topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0)),
                          ),
                          child: Center(
                              child: Text(
                            '2 February 10:00 AM',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text("Rajasthan Police Test 1",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey,
                                  letterSpacing: 1)),
                        ),
                      ),
                    ),
                    new Divider(
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  //width: 200,
                                  //  color: Colors.green,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Question",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 17)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "15",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  //width: 200,
                                  //  color: Colors.green,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Duration",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 17)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "150 minutes",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  height: 50,
                                  //width: 150,
                                  //color: Colors.amber,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Marks",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Colors.grey,
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "150",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    new Divider(
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFfef5e6), // foreground
                            ),
                            onPressed: () {},
                            child: Text(
                              'Re-Attempt',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColor.buttonColor // foreground
                                ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ResultScreen()),
                              );
                            },
                            child: Text('Result'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColor.containerBoxColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 274,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 35,
                      width: 250,
                      decoration: BoxDecoration(
                        color: AppColor.containerBoxColor,
                        borderRadius: const BorderRadius.only(
                            // topRight: Radius.circular(8.0),
                            // topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                      ),
                      child: Center(
                          child: Text(
                        '5 March 10:00 AM',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text("Rajasthan Police Test 2",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey,
                                  letterSpacing: 1)),
                        ),
                      ),
                    ),
                    new Divider(
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  //width: 200,
                                  //  color: Colors.green,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Question",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 17)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "15",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  //width: 200,
                                  //  color: Colors.green,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Duration",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 17)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "150 minutes",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  height: 50,
                                  //width: 150,
                                  //color: Colors.amber,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Marks",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Colors.grey,
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "150",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    new Divider(
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColor.buttonColor // foreground
                                ),
                            onPressed: () {},
                            child: Text('Schedule'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColor.containerBoxColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 274,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 35,
                      width: 250,
                      decoration: BoxDecoration(
                        color: AppColor.containerBoxColor,
                        borderRadius: const BorderRadius.only(
                            // topRight: Radius.circular(8.0),
                            // topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                      ),
                      child: Center(
                          child: Text(
                        '20 March 10:00 AM',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text("Rajasthan Police Test 3",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey,
                                  letterSpacing: 1)),
                        ),
                      ),
                    ),
                    new Divider(
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  //width: 200,
                                  //  color: Colors.green,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Question",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 17)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "15",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  //width: 200,
                                  //  color: Colors.green,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Duration",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 17)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "150 minutes",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  height: 50,
                                  //width: 150,
                                  //color: Colors.amber,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Marks",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Colors.grey,
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "150",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    new Divider(
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //       backgroundColor:
                          //           Colors.amberAccent.shade100 // foreground
                          //       ),
                          //   onPressed: () {},
                          //   child: Text('Re-Attached'),
                          // ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColor.buttonColor // foreground
                                ),
                            onPressed: () {},
                            child: Text('Start Now'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColor.containerBoxColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 274,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 35,
                      width: 250,
                      decoration: BoxDecoration(
                        color: AppColor.containerBoxColor,
                        borderRadius: const BorderRadius.only(
                            // topRight: Radius.circular(8.0),
                            // topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                      ),
                      child: Center(
                          child: Text(
                        '25 March 10:00 AM',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text("Rajasthan Police Test 4",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey,
                                  letterSpacing: 1)),
                        ),
                      ),
                    ),
                    new Divider(
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  //width: 200,
                                  //  color: Colors.green,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Question",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 17)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "15",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  //width: 200,
                                  //  color: Colors.green,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Duration",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 17)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "150 minutes",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  height: 50,
                                  //width: 150,
                                  //color: Colors.amber,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Marks",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Colors.grey,
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "150",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    new Divider(
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //       backgroundColor:
                          //           Colors.amberAccent.shade100 // foreground
                          //       ),
                          //   onPressed: () {},
                          //   child: Text('Re-Attached'),
                          // ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColor.buttonColor // foreground
                                ),
                            onPressed: () {},
                            child: Text('Resume'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColor.containerBoxColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              color: AppColor.containerBoxColor,
            )
          ]),
        )));
  }
}
