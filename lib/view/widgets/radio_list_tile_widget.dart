import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:study_evaluation/models/question_answer_model/question_model.dart';
import 'package:study_evaluation/utils/app_utils.dart';

// ignore: must_be_immutable
class RadioListTileWidget extends StatefulWidget {
  final Widget contentWidget;
  List<String> selectedValues;
  QuestionModel model;
  String value;
  String selectedLanguage;
  String selectedFont;
  void Function(String value, QuestionModel model) callBack;
  RadioListTileWidget(
      {super.key,
      required this.contentWidget,
      required this.selectedValues,
      required this.model,
      required this.value,
      required this.callBack,
      required this.selectedFont,
      required this.selectedLanguage});

  @override
  State<RadioListTileWidget> createState() => _RadioListTileWidgetState();
}

class _RadioListTileWidgetState extends State<RadioListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getOption(widget.model.optionAHindi, widget.model.optionAEnglish, "a",
            widget.model),
        _getOption(widget.model.optionBHindi, widget.model.optionBEnglish, "b",
            widget.model),
        _getOption(widget.model.optionCHindi, widget.model.optionCEnglish, "c",
            widget.model),
        _getOption(widget.model.optionDHindi, widget.model.optionDEnglish, "d",
            widget.model),
      ],
    );
  }

  RadioListTile<String> _getOption(
      label, labelEnglish, value, QuestionModel model) {
    return RadioListTile(
      title: _getContent(label, labelEnglish),
      value: value,
      groupValue: widget.selectedValues[model.index],
      activeColor: Colors.blue,
      selectedTileColor: const Color.fromARGB(255, 197, 221, 241),
      selected: value == widget.selectedValues[model.index],
      onChanged: (value) {
        widget.callBack(value!, model);
        setState(() {
          //print("Value = $value");
          widget.selectedValues[model.index] = value;
          model.submittedAnswer = value;
        });
      },
    );
  }

  Widget _getContent(labelHindi, labelEnglish, {questionNumber}) {
    List<Widget> widgets = [];
    if (labelHindi != null &&
        (widget.selectedLanguage.toLowerCase() == "both" ||
            widget.selectedLanguage.toLowerCase() == "hindi")) {
      labelHindi = questionNumber != null
          ? "Q. $questionNumber) $labelHindi"
          : labelHindi;
      widgets.add(Align(
        alignment: Alignment.centerLeft,
        child: AppUtils.getHtmlData1(
          labelHindi,
          // fontFamily: 'Kruti Dev 010',
          // fontSize: double.tryParse(widget.selectedFont)!
        ),
      ));
    }
    if (labelEnglish != null &&
        labelEnglish.toString().trim().isNotEmpty &&
        (widget.selectedLanguage.toLowerCase() == "both" ||
            widget.selectedLanguage.toLowerCase() == "english")) {
      /*  labelEnglish = questionNumber != null
          ? "Q. $questionNumber) $labelEnglish"
          : labelEnglish; */
      widgets.add(Align(
          alignment: Alignment.centerLeft,
          child: AppUtils.getHtmlData1("$labelEnglish")));
    }

    if (widgets.isNotEmpty) {
      widgets.add(const Divider(
        height: 10,
      ));
    }

    return Column(
      children: widgets,
    );
    //return widgets;
  }
}
