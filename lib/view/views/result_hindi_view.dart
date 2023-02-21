import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class ResultHindiView extends StatefulWidget {
  const ResultHindiView({super.key});

  @override
  State<ResultHindiView> createState() => _ResultHindiViewState();
}

class _ResultHindiViewState extends State<ResultHindiView> {
  String? question;
  List<int> selectedValues = [];
  String selectedRadioIndex = ""; //no radio button will be selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: _getQuestionOptionWidgets(context))));
  }

  List<Widget> _getQuestionOptionWidgets(BuildContext context) {
    List<QuestionModel> questionModels = _getQuestionModels();
    List<Widget> widgets = [];
    bool isBlankSelValues = selectedValues.isEmpty;
    int i = 0;
    for (var qm in questionModels) {
      if (isBlankSelValues) {
        selectedValues.add(0);
      }
      qm.index = i++;
      widgets.add(_getQuestionOptionWidget(context, qm));
    }
    return widgets;
  }

  Padding _getQuestionOptionWidget(BuildContext context, QuestionModel qm) {
    return Padding(
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
            child: Column(children: _getQuestionOptions(qm)),
          ),
        ),
      ),
    );
  }

  List<Widget> _getQuestionOptions(QuestionModel qm) {
    return [
      _getQuestion(qm.question!),
      const SizedBox(
        height: 10,
      ),
      _getOption(qm.optionA, qm.optionA, qm),
      _getOption(qm.optionB, qm.optionB, qm),
      _getOption(qm.optionC, qm.optionC, qm),
      _getOption(qm.optionD, qm.optionD, qm),
    ];
  }

  RadioListTile<String> _getOption(label, value, QuestionModel qm) {
    return RadioListTile(
      title: Text(
        label,
        style: _getTextStyleHindi(),
      ),
      value: value,
      groupValue: qm.id,
      onChanged: (value) {
        setState(() {
          print("Value = $value");
          qm.selectedOption = value.toString();
        });
      },
    );
  }

  TextStyle _getTextStyleHindi() => const TextStyle(fontFamily: 'Kruti');

  Container _getQuestion(String question) {
    return Container(
        height: 40,
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: AppColor.containerBoxColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            question,
            style: const TextStyle(
                color: Colors.white, fontFamily: 'Kruti', fontSize: 20),
          ),
        ));
  }

  List<QuestionModel> _getQuestionModels() {
    List<QuestionModel> questionModels = [];
    questionModels.add(QuestionModel(
        id: "1",
        question: "xzke 1",
        optionA: "xzke 2",
        optionB: "xzke 3",
        optionC: "xzke 4",
        optionD: "xzke 5",
        selectedOption: "xzke 4"));
    questionModels.add(QuestionModel(
        id: "2",
        question: "xzke 6",
        optionA: "xzke 7",
        optionB: "xzke 8",
        optionC: "xzke 9",
        optionD: "xzke 10",
        selectedOption: "xzke 7"));
    return questionModels;
  }
}

class QuestionModel {
  String? id;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? question;
  String? selectedOption;
  int? index;
  QuestionModel(
      {this.id,
      this.optionA,
      this.optionB,
      this.optionC,
      this.optionD,
      this.question,
      this.selectedOption,
      this.index});
}
/*
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
      */