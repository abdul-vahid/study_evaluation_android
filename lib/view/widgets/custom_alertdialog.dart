import 'dart:math';

import 'package:flutter/material.dart';
import 'package:study_evaluation/models/question_answer_model/question_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';

class CustomAlertDialog extends StatefulWidget {
  final List<QuestionModel> questionModels;

  const CustomAlertDialog({super.key, required this.questionModels});

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  Map<String, List<QuestionModel>> getData() {
    Map<String, List<QuestionModel>> questionModelMap =
        <String, List<QuestionModel>>{};
    for (var qm in widget.questionModels) {
      List<QuestionModel> questionModels = [];
      if (questionModelMap.containsKey(qm.subjectName)) {
        questionModels = questionModelMap[qm.subjectName]!;
      }
      questionModels.add(qm);
      questionModelMap[qm.subjectName!] = questionModels;
    }
    return questionModelMap;
  }

  List<Widget> _getQuestionWidgets() {
    Map<String, List<QuestionModel>> questionModelMap = getData();
    List<Widget> widgets = [];
    for (var subject in questionModelMap.keys) {
      widgets.add(_getSubjectQuestionNo(subject, questionModelMap[subject]!));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    //Map<String, List<QuestionModel>> questionModelMap = getData();
    return Dialog(
      elevation: 0,
      backgroundColor: const Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            _getDialogTitle(context),
            _getFilterTitle(),
            const SizedBox(height: 25),
            Column(
              children: _getQuestionWidgets(),
            )
          ],
        ),
      ),
    );
  }

  Container _getSubjectQuestionNo(
      String subject, List<QuestionModel> questionModels) {
    print("len = ${questionModels.length}");
    //var min = 10;
    //var max = 50;
    //Random random = Random();
    //var _randomNumber1 = min + random.nextInt(max - min);
    double height = ((questionModels.length / 7) + 1) * 50;
    if (AppConstants.kDebugMode) {
      print("height = $height");
    }
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: _getSubjectTitle(subject),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 1,
          ),
          //SizedBox(height: 10),

          Container(
            //  color: Colors.amberAccent,
            height: height,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
            child: _getGridView(questionModels),
          ),
        ],
      ),
    );
  }

  Align _getDialogTitle(BuildContext context) {
    return Align(
      // These values are based on trial & error method
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            //color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.close,
            color: Color(0xFF666666),
          ),
        ),
      ),
    );
  }

  Text _getFilterTitle() {
    return const Text(
      "Filter",
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Align _getSubjectTitle(subjectTitle) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        child: Text(subjectTitle,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
                letterSpacing: 1)),
      ),
    );
  }

  GridView _getGridView(List<QuestionModel> questionModels) {
    return GridView(
        physics: const ClampingScrollPhysics(),
        //padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5, crossAxisCount: 7, crossAxisSpacing: 5),
        children: getQuestionNos(questionModels));
  }

  List<Widget> getQuestionNos(List<QuestionModel> questionModels) {
    List<Widget> widgets = [];
    for (var qm in questionModels) {
      widgets.add(button((qm.index + 1)));
    }
    return widgets;
  }

  Container getButton(questionNo) {
    return Container(
      width: 110.0,
      height: 110.0,
      padding: const EdgeInsets.all(10.0),
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFdce5ff)),
      child: InkWell(
        onTap: () {
          Navigator.pop(context, questionNo - 1);
        },
        child: Center(
          child: Text('$questionNo',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0)),
        ),
      ),
    );
  }

  Widget button(int questionNo) {
    print("question = $questionNo");
    return TextButton(
      style: TextButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.grey),
      child: Text(questionNo.toString()),
      onPressed: () {
        Navigator.pop(context, questionNo - 1);
      },
    );
  }
}
