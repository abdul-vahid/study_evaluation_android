import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/models/question_answer_model/question.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view_models/exam_list_vm.dart';

enum LanguageOption { hindi, english, both }

class ExamView extends StatefulWidget {
  const ExamView({super.key});

  @override
  State<ExamView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  LanguageOption languageOption = LanguageOption.hindi;
  String? question;
  List<String> selectedValues = [];
  String selectedRadioIndex = ""; //no radio button will be selected
  ExamListViewModel? baseListViewModel;
  List<String> languageOptions = ["Hindi", "English", "Both"];
  Map<String, String> fontOptions = {
    "15": "Small",
    "18": "Medium",
    "22": "Large"
  };

  String? _selectedLanguage = "Hindi";
  String? _selectedFont = "15";
  String title = "Test";

  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 60;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    Provider.of<ExamListViewModel>(context, listen: false)
        .fetchQuestionAnswer(examId: "87");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    baseListViewModel = Provider.of<ExamListViewModel>(context);
    if (baseListViewModel!.viewModels.isNotEmpty &&
        baseListViewModel!.viewModels[0].model != null) {
      setState(() {
        title = baseListViewModel?.viewModels[0].model.exam.title;
      });
    }
    return Scaffold(
        appBar: AppUtil.getAppbar(title),
        body: AppUtil.getAppBody(baseListViewModel!, _getBody));
  }

  SingleChildScrollView _getBody() {
    return SingleChildScrollView(
        child: Column(children: _getQuestionOptionWidgets()));
  }

  List<DropdownMenuItem<String>>? getItems() {
    return languageOptions.map<DropdownMenuItem<String>>((value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: const TextStyle(fontSize: 15),
        ),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>>? getFontSizes() {
    List<DropdownMenuItem<String>>? dropDownItems = [];
    fontOptions.forEach((key, value) {
      dropDownItems.add(DropdownMenuItem<String>(
        value: key,
        child: Text(
          value,
          style: const TextStyle(fontSize: 15),
        ),
      ));
    });
    return dropDownItems;
  }

  List<Widget> _getQuestionOptionWidgets() {
    List<Widget> widgets = [];
    widgets.add(Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.containerBoxColor,
              borderRadius: BorderRadius.circular(20),
              //more than 50% of width makes circle
            ),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Icon(
                    Icons.apps_rounded,
                    size: 30,
                    color: Colors.white, // add custom icons also
                  ),
                ),
                // ignore: prefer_const_constructors
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  // ignore: prefer_const_constructors
                  child: Text(
                    '100 question ',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // ignore: prefer_const_constructors
                      Icon(
                        Icons.timer,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        timerText,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [_getLanguageDropdown(), _getFontDropdown()],
          ),
        ],
      ),
    ));

    bool isBlankSelValues = selectedValues.isEmpty;
    var i = 0;

    for (Question model
        in (baseListViewModel?.viewModels[0].model.questions)!) {
      if (isBlankSelValues) {
        selectedValues.add("0");
      }
      model.index = i++;
      widgets.add(_getQuestionOptionWidget(model));
    }

    widgets.add(Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.buttonColor // foreground
                ),
            onPressed: () {},
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.buttonColor // foreground
                ),
            onPressed: () {},
            child: Text('Submit'),
          ),
        ],
      ),
    ));

    return widgets;
  }

  Widget _getFontDropdown() {
    return Container(
        width: 120,
        height: 60,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                // prefixIcon: Icon(Icons.person, color: AppColor.iconColor),
              ),
              hint: const Text('Font'),
              // Not necessary for Option 1
              value: int.parse(_selectedFont.toString()).toString(),
              //validator: (value) => value == null ? 'Required' : null,
              //isDense: true,
              isExpanded: false,
              menuMaxHeight: 350,
              onChanged: (newValue) {
                setState(() {
                  _selectedFont = newValue!;
                });
              },
              items: getFontSizes()),
        ));
  }

  Widget _getLanguageDropdown() {
    return Container(
        width: 120,
        height: 60,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                // prefixIcon: Icon(Icons.person, color: AppColor.iconColor),
              ),
              hint: const Text('Language'),
              // Not necessary for Option 1
              value: _selectedLanguage,
              validator: (value) => value == null ? 'Required' : null,
              isDense: true,
              isExpanded: false,
              menuMaxHeight: 300,
              onChanged: (newValue) {
                setState(() {
                  _selectedLanguage = newValue;
                  if (_selectedLanguage == "Hindi") {
                    languageOption = LanguageOption.hindi;
                  } else if (_selectedLanguage == "English") {
                    languageOption = LanguageOption.english;
                  } else {
                    languageOption = LanguageOption.both;
                  }
                });
              },
              items: getItems()),
        ));
  }

  Padding _getQuestionOptionWidget(model) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Expanded(
        //width: MediaQuery.of(context).size.width,
        //height: 300,
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
            child: Column(children: _getQuestionOptions(model)),
          ),
        ),
      ),
    );
  }

  List<Widget> _getQuestionOptions(Question model) {
    return [
      _getQuestion(model),
      const SizedBox(
        height: 10,
      ),
      _getOption(model.optionAHindi, model.optionAEnglish, "a", model),
      _getOption(model.optionBHindi, model.optionBEnglish, "b", model),
      _getOption(model.optionCHindi, model.optionCEnglish, "c", model),
      _getOption(model.optionDHindi, model.optionDEnglish, "d", model),
      const SizedBox(
        height: 10,
      ),
      Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColor.containerBoxColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getIconButton(
              'Clear Section',
              Icons.radio_button_unchecked_outlined,
              onPressed: () {
                selectedValues.clear();
              },
            ),
            getIconButton(
              'Favourite',
              Icons.star_border_purple500_sharp,
              onPressed: () {
                //selectedValues.clear();
              },
            ),
          ],
        ),
      )
    ];
  }

  TextButton getIconButton(String label, IconData iconData,
      {required void Function()? onPressed}) {
    return TextButton.icon(
      onPressed: onPressed,
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      icon: Icon(
        iconData,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  RadioListTile<String> _getOption(label, labelEnglish, value, Question model) {
    return RadioListTile(
      title: _getContent(label, labelEnglish),
      value: value,
      groupValue: selectedValues[model.index],
      activeColor: Colors.blue,
      selectedTileColor: const Color.fromARGB(255, 197, 221, 241),
      selected: value == selectedValues[model.index],
      onChanged: (value) {
        setState(() {
          print("Value = $value");
          selectedValues[model.index] = value!;
          model.submittedAnswer = value;
        });
      },
    );
  }

  Widget _getQuestion(Question model) {
    return Align(
      alignment: Alignment.centerLeft,
      child: _getContent("Q.${model.index + 1}) ${model.questionHindi}",
          "Q.${model.index + 1}) ${model.questionEnglish}"),
    );
  }

  Widget _getContent(labelHindi, labelEnglish) {
    List<Widget> widgets = [];
    if (labelHindi != null &&
        (languageOption == LanguageOption.both ||
            languageOption == LanguageOption.hindi)) {
      widgets.add(getHtmlData(labelHindi, fontFamily: 'Kruti'));
    }
    if (labelEnglish != null &&
        labelEnglish.toString().trim().isNotEmpty &&
        (languageOption == LanguageOption.both ||
            languageOption == LanguageOption.english)) {
      widgets.add(getHtmlData(labelEnglish));
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

  Html getHtmlData(data, {fontFamily = ''}) {
    return Html(
        data: data,
        style: {
          "span": Style(fontFamily: fontFamily),
          "body, span, p, font, div":
              Style(fontSize: FontSize(double.tryParse(_selectedFont!)))
        },
        customRender: {
          "o:p": (RenderContext context, Widget child) {
            return const TextSpan(text: "\\");
          },
        },
        tagsList: Html.tags..addAll(["o:p"]));
  }
}
