import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/question_answer_model/exam_model.dart';
import 'package:study_evaluation/models/question_answer_model/question_model.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/widgets/custom_alertdialog.dart';

class ResultView extends StatefulWidget {
  final String resultId;
  final String studentId;

  ResultView({super.key, required this.resultId, required this.studentId});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  List<GlobalKey>? _keys;
  String? question;
  List<String> selectedValues = [];
  String selectedRadioIndex = ""; //no radio button will be selected
  BaseListViewModel? baseListViewModel;
  List<String> languageOptions = ["Hindi", "English", "Both"];
  Map<String, String> fontOptions = {
    "15": "Small",
    "18": "Medium",
    "22": "Large"
  };

  String _selectedLanguage = "Hindi";
  String? _selectedFont = "15";
  String title = "Test";
  String timeUP = "";
  int timerMaxSeconds = 60;
  Duration? myDuration;
  var duration;
  int currentSeconds = 0;
  Timer? countdownTimer;
  var hours = "0";
  var minutes = "0";
  var seconds = "0";
  int? totalQuestions = 30;

  @override
  void initState() {
    String url = AppUtils.getUrl(
        "${AppConstants.resultAPIPath}?result_id=${widget.resultId}&student_id=${widget.studentId}");
    Provider.of<BaseListViewModel>(context, listen: false)
        .get(baseModel: ExamModel(), url: url);
    timeUP = "";
    super.initState();
  }

  String get timerText {
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    baseListViewModel = Provider.of<BaseListViewModel>(context);

    return Scaffold(
        appBar: AppUtils.getAppbar(title, actions: [_getFilterButton()]),
        body: AppUtils.getAppBody(baseListViewModel!, _getBody));
  }

  ElevatedButton _getPopCancelButton(BuildContext context) {
    return AppUtils.getElevatedButton("Continue", onPressed: () {
      //stopTimer();
      Navigator.of(context).pop(false);
    },
        textStyle: const TextStyle(color: Colors.black),
        buttonStyle:
            ElevatedButton.styleFrom(backgroundColor: AppColor.greyColor));
  }

  ElevatedButton _getPopSubmitButton(BuildContext context) {
    return AppUtils.getElevatedButton("Submit", onPressed: () {
      Navigator.of(context).pop(false);
      _onSubmit();

      //Navigator.of(context).pop(true);
    });
  }

  ElevatedButton _getPopSaveButton(BuildContext context) {
    return AppUtils.getElevatedButton("Save", onPressed: () {
      Navigator.of(context).pop(true);
      _onSubmit(status: ResultStatus.inProgress);
    });
  }

  Widget _getBody() {
    if (baseListViewModel!.viewModels.isNotEmpty &&
        baseListViewModel!.viewModels[0].model != null &&
        !baseListViewModel!.viewModels[0].model.isError) {
      ExamModel model = baseListViewModel!.viewModels[0].model;
      if (model.questionModels == null || model.questionModels!.isEmpty) {
        return const Center(
          child: Text("No Results Found!"),
        );
      }

      setState(() {
        title = model.exam!.title!;
        print("title = $title");
        totalQuestions =
            model.questionModels != null ? model.questionModels!.length : 0;
      });

      _keys = List.generate(totalQuestions!, (index) => GlobalKey());
    }
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
          //_getTopBar(),
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

    for (QuestionModel model
        in (baseListViewModel?.viewModels[0].model.questionModels)!) {
      if (AppConstants.kDebugMode) {
        //print("Submitted ${model.submittedAnswer}");
      }
      selectedValues.add(model.submittedAnswer!);
      /* if (isBlankSelValues) {
        if (model.hasSubmittedAnswer) {
          
        } else {
          selectedValues.add("0");
        }
      } */

      model.index = i++;
      widgets.add(_getQuestionOptionWidget(model));
    }

    widgets.add(_getBottomButtons());

    return widgets;
  }

  Container _getTopBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.containerBoxColor,
        borderRadius: BorderRadius.circular(20),
        //more than 50% of width makes circle
      ),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // ignore: prefer_const_literals_to_create_immutables
        children: _topBarChildren,
      ),
    );
  }

  List<Widget> get _topBarChildren {
    return [
      // ignore: prefer_const_constructors
      Padding(
        padding: const EdgeInsets.only(left: 10),
        // ignore: prefer_const_constructors
        child: Text(
          '$totalQuestions Questions',
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
    ];
  }

  IconButton _getFilterButton() {
    return IconButton(
        onPressed: () {
          if (baseListViewModel?.viewModels[0].model.questionModels == null ||
              baseListViewModel?.viewModels[0].model.questionModels.isEmpty) {
            return;
          }
          showDialog(
            barrierColor: Colors.black26,
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                  questionModels:
                      baseListViewModel?.viewModels[0].model.questionModels);
            },
          ).then((value) {
            //print("Dialog Value = $value");

            if (value != null) {
              Scrollable.ensureVisible(
                (_keys?[value].currentContext)!,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut,
                alignment: 0.5,
              );
            }
          });
        },
        icon: const Icon(
          Icons.apps_rounded,
          size: 30,
          color: Colors.white, // add custom icons also
        ));
  }

  Padding _getBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(height: 10, width: 100, child: const Text("Button")),
    );
  }

  ElevatedButton _getSubmitButton() {
    return AppUtils.getElevatedButton('Submit',
        onPressed: _onSubmit,
        buttonStyle:
            ElevatedButton.styleFrom(backgroundColor: AppColor.buttonColor));
  }

  ElevatedButton _getSaveButton() {
    return AppUtils.getElevatedButton('Save', onPressed: () {
      _onSubmit(status: ResultStatus.inProgress);
    },
        buttonStyle:
            ElevatedButton.styleFrom(backgroundColor: AppColor.buttonColor));
  }

  ElevatedButton _getCancelButton() {
    return AppUtils.getElevatedButton('Cancel',
        onPressed: _onCancel,
        textStyle: const TextStyle(color: Colors.black),
        buttonStyle:
            ElevatedButton.styleFrom(backgroundColor: AppColor.greyColor));
  }

  void _onSubmit({String status = "Completed"}) {
    //print("submit");
    ExamModel examModel = baseListViewModel?.viewModels[0].model;
    examModel.exam?.remainingExamTime = timerText;
    var message = status == ResultStatus.completed
        ? "$timeUP Submitting Your Exam..."
        : "$timeUP Saving Your Exam...";
    var successMessage = status == ResultStatus.completed
        ? "$timeUP Exam Submitted!"
        : "$timeUP Exam Saved!";
    AppUtils.onLoading(context, "$timeUP Submitting Your Exam...");
    /* BaseListViewModel().submitExam(examModel, status: status).then((value) {
      Navigator.pop(context);
      AppUtils.getAlert(context, [successMessage], onPressed: _onPressedAlert);
      stopTimer();
    }).catchError((error) {
      if (AppConstants.kDebugMode) {
        print(error.toString());
      }
      AppUtils.onError(context, error);
    }); */
  }

  void _onPressedAlert() {
    Navigator.of(context).pop();
    /* AppUtils.viewPush(
        context,
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => BaseListViewModel())
          ],
          child: const ResultView(),
        )); */
  }

  void _onCancel() {}

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
                  _selectedLanguage = newValue!;
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

  List<Widget> _getQuestionOptions(QuestionModel model) {
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
      _getDescription(model),
      const SizedBox(
        height: 10,
      ),
      _getQuestionBottom(model)
    ];
  }

  Container _getQuestionBottom(QuestionModel model) {
    return Container(
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
            'Favourite',
            Icons.star_border_purple500_sharp,
            textColor: model.isFavourite
                ? const Color.fromARGB(255, 248, 248, 9)
                : Colors.white,
            iconColor: model.isFavourite
                ? const Color.fromARGB(255, 248, 248, 9)
                : Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  TextButton getIconButton(String label, IconData iconData,
      {required void Function()? onPressed,
      textColor = Colors.white,
      iconColor = Colors.white}) {
    return TextButton.icon(
      onPressed: onPressed,
      label: Text(
        label,
        style: TextStyle(
          color: textColor,
        ),
      ),
      icon: Icon(
        iconData,
        color: iconColor,
        size: 20,
      ),
    );
  }

  ListTile _getOption(label, labelEnglish, value, QuestionModel model) {
    return ListTile(
      title: _getContent(label, labelEnglish),
      tileColor: _getSelectedColor(model, value),
      shape: _getListTileShape(model, value),
    );
  }

  RoundedRectangleBorder? _getListTileShape(QuestionModel model, String value) {
    if (model.answer == value && model.submittedAnswer == model.answer) {
      return RoundedRectangleBorder(
        side: const BorderSide(
            width: 3, color: Color.fromARGB(255, 201, 114, 14)),
        borderRadius: BorderRadius.circular(10),
      );
    }
    return null;
  }

  Widget _getQuestion(QuestionModel model) {
    return Align(
      alignment: Alignment.centerLeft,
      key: _keys?[model.index],
      child: _getContent("${model.questionHindi}", "${model.questionEnglish}",
          questionNumber: model.index + 1),
    );
  }

  Widget _getDescription(QuestionModel model) {
    return Column(
      children: [
        const Text(
          "Description",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: _getContent(
              "${model.descriptionHindi}", "${model.descriptionEnglish}"),
        )
      ],
    );
  }

  Widget _getContent(labelHindi, labelEnglish, {questionNumber}) {
    List<Widget> widgets = [];
    if (labelHindi != null &&
        (_selectedLanguage.toLowerCase() == "both" ||
            _selectedLanguage.toLowerCase() == "hindi")) {
      labelHindi = questionNumber != null
          ? "Q. $questionNumber) $labelHindi"
          : labelHindi;
      widgets.add(AppUtils.getHtmlData(labelHindi,
          fontFamily: 'Kruti', fontSize: double.tryParse(_selectedFont!)!));
    }
    if (labelEnglish != null &&
        labelEnglish.toString().trim().isNotEmpty &&
        (_selectedLanguage.toLowerCase() == "both" ||
            _selectedLanguage.toLowerCase() == "english")) {
      labelEnglish = questionNumber != null
          ? "Q. $questionNumber) $labelEnglish"
          : labelEnglish;
      widgets.add(AppUtils.getHtmlData("$labelEnglish"));
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

  void startTimer() {
    countdownTimer ??=
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 6
  void setCountDown() {
    const reduceSecondsBy = 1;
    final seconds1 = myDuration!.inSeconds - reduceSecondsBy;
    if (seconds1 < 0) {
      timeUP = "Time UP!";
      stopTimer();
      _onSubmit();
    } else {
      myDuration = Duration(seconds: seconds1);
    }
    //print("$seconds1 == ${myDuration!.inSeconds}");

    setState(() {
      String strDigits(int n) => n.toString().padLeft(2, '0');
      hours = strDigits(myDuration!.inHours.remainder(24));
      minutes = strDigits(myDuration!.inMinutes.remainder(60));
      seconds = strDigits(myDuration!.inSeconds.remainder(60));
    });
  }

  _getSelectedColor(QuestionModel model, String value) {
    if (model.answer == value) {
      return Colors.green;
    } else if (model.submittedAnswer == value) {
      return Colors.red;
    }
  }
}
