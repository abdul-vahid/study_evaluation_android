// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:study_evaluation/models/question_answer_model/exam_model.dart';
import 'package:study_evaluation/utils/app_utils.dart';

import '../../utils/app_color.dart';

class AnalysisView extends StatefulWidget {
  ExamModel examModel;
  AnalysisView({super.key, required this.examModel});

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    return Scaffold(
        appBar: AppUtils.getAppbar("Analysis"),
        /* AppBar(
            leading: BackButton(color: Colors.white),
            backgroundColor: AppColor.appBarColor,
            centerTitle: true,
            title: const Text(
              'Analysis',
            )), */
        body: _getBody(context));
  }

  SingleChildScrollView _getBody(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFFF2C55),
                    borderRadius: BorderRadius.circular(6)
                    //more than 50% of width makes circle
                    ),
                // padding:EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/total-marks.png'),
                        width: 60.0,
                        height: 60.0,
                      ),
                    ),
                    _getTotalMarks()
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF009DDC),
                    borderRadius: BorderRadius.circular(6)
                    //more than 50% of width makes circle
                    ),
                //padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _getRankImageContainer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: _getRank,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF4FE3C1),
                    borderRadius: BorderRadius.circular(6)
                    //more than 50% of width makes circle
                    ),
                // padding:EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _getTotalMarksContainer,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFFF8B00),
                    borderRadius: BorderRadius.circular(6)
                    //more than 50% of width makes circle
                    ),
                // padding:EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 100,
                child: _getNegativeMarksContainer(),
              ),
            ),
          ],
        ),
      ),
      _getTimeContainer(),
      _getAttemptContainer(),
      _getMarksDetailsContainer(context),
    ]));
  }

  Padding _getMarksDetailsContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
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
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: AppColor.containerBoxColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0)),
                ),
                child: _getMarksDetailsLabel()),
            SizedBox(
              height: 20,
            ),
            getMarksDetails(),
          ]),
        ),
      ),
    );
  }

  Padding getMarksDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            (widget.examModel.exam?.result?.correctQuestionCount)!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            (widget.examModel.exam?.result?.incorrectQuestionCount)!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            (widget.examModel.exam?.result?.totalMarks)!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Row _getMarksDetailsLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Text(
          'Correct',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          'Incorrect',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          'Marks',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Padding _getAttemptContainer() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFFF8B00),
                  borderRadius: BorderRadius.circular(6)
                  //more than 50% of width makes circle
                  ),
              // padding:EdgeInsets.all(10),
              alignment: Alignment.center,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)
                        //more than 50% of width makes circle
                        ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        // fit: BoxFit.fill,
                        image: AssetImage('assets/images/attempt.png'),
                        width: 70.0,
                        height: 70.0,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        (widget.examModel.exam?.result?.attempt)!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Attempt',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF4FE3C1),
                  borderRadius: BorderRadius.circular(6)
                  //more than 50% of width makes circle
                  ),
              // padding:EdgeInsets.all(10),
              alignment: Alignment.center,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)
                        //more than 50% of width makes circle
                        ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/rank.png'),
                        width: 60.0,
                        height: 60.0,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        (widget.examModel.exam?.result?.accuracy)!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Accuracy',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _getTimeContainer() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF009DDC),
                  borderRadius: BorderRadius.circular(6)
                  //more than 50% of width makes circle
                  ),
              // padding:EdgeInsets.all(10),
              alignment: Alignment.center,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _getTimes,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFFF2C55),
                  borderRadius: BorderRadius.circular(6)
                  //more than 50% of width makes circle
                  ),
              // padding:EdgeInsets.all(10),
              alignment: Alignment.center,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)
                        //more than 50% of width makes circle
                        ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        // fit: BoxFit.fill,
                        image: AssetImage('assets/images/time.png'),
                        width: 70.0,
                        height: 70.0,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        (widget.examModel.exam?.result?.averageTimeQuestion)!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Avg Time',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> get _getTimes {
    return [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(100)
            //more than 50% of width makes circle
            ),
        child: _getTimeIcon(),
      ),
      _getTimeSpent()
    ];
  }

  Column _getTimeSpent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Text(
          (widget.examModel.exam?.result?.totalTimeTaken)!,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          'Time(Minutes)',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  ClipRRect _getTimeIcon() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image(
        // fit: BoxFit.fill,
        image: AssetImage('assets/images/time.png'),
        width: 70.0,
        height: 70.0,
      ),
    );
  }

  Row _getNegativeMarksContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(100)
              //more than 50% of width makes circle
              ),
          child: _getNegativeIcon(),
        ),
        _getNegativeMarks()
      ],
    );
  }

  Column _getNegativeMarks() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Text(
          (widget.examModel.exam?.result?.negativeMarking)!,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          'Neg Marks',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  ClipRRect _getNegativeIcon() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image(
        // fit: BoxFit.fill,
        image: AssetImage('assets/images/attempt.png'),
        width: 70.0,
        height: 70.0,
      ),
    );
  }

  List<Widget> get _getTotalMarksContainer {
    return [_getPositiveMarksIcon(), _getPositiveMarks()];
  }

  ClipRRect _getPositiveMarksIcon() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image(
        fit: BoxFit.fill,
        image: AssetImage('assets/images/total-marks.png'),
        width: 60.0,
        height: 60.0,
      ),
    );
  }

  Column _getPositiveMarks() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Text(
          (widget.examModel.exam?.result?.positiveMarking)!,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          'Positive Marks',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  List<Widget> get _getRank {
    return [
      Text(
        (widget.examModel.exam?.result?.ranks)!,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 4,
      ),
      Text(
        'Rank',
        style: TextStyle(color: Colors.white),
      ),
    ];
  }

  Container _getRankImageContainer() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(100)
          //more than 50% of width makes circle
          ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/rank.png'),
          width: 60.0,
          height: 60.0,
        ),
      ),
    );
  }

  Column _getTotalMarks() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Text(
          (widget.examModel.exam?.result?.totalEarnedMarks)!,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          'Total Marks',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
