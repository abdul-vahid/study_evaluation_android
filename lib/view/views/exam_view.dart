import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/models/question_answer_model/exam_model.dart';
import 'package:study_evaluation/models/question_answer_model/question_model.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/utils/function_lib.dart';
import 'package:study_evaluation/view/views/result_view.dart';
import 'package:study_evaluation/view/widgets/custom_alertdialog.dart';
import 'package:study_evaluation/view/widgets/radio_list_tile_widget.dart';
import 'package:study_evaluation/view/widgets/timer_widget.dart';
import 'package:study_evaluation/view_models/exam_list_vm.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/view_models/result_list_vm.dart';

// ignore: must_be_immutable
class ExamView extends StatefulWidget {
  final String examId;
  final String userId;
  bool? reAttempt = false;
  bool? noQuestions = false;
  ExamView(
      {super.key, required this.examId, required this.userId, this.reAttempt});

  @override
  State<ExamView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  bool hasCanceledTimer = false;
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

  String _selectedLanguage = "hindi";
  String? _selectedFont = "15";
  String title = "Test";
  String timeUP = "";
  int timerMaxSeconds = 60;
  Duration? myDuration;

  int currentSeconds = 0;
  var hours = "0";
  var minutes = "0";
  var seconds = "0";
  int? totalQuestions = 0;
  bool hasQuestions = true;
  bool hasDataLoaded = false;
  late TimerWidget timerWidget;
  List<GlobalKey>? _radioListKey;
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      var userModel = AppUtils.getSessionUser(prefs);
      userModel ?? AppUtils.logout(context);
    });

    hasDataLoaded = false;
    //startTimer();
    Provider.of<ExamListViewModel>(context, listen: false).fetch(widget.examId);
    timeUP = "";
    super.initState();
  }

  String timerText = "";

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    baseListViewModel = Provider.of<ExamListViewModel>(context);

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
          appBar: AppUtils.getAppbar(title, actions: [
            IconButton(
              icon: const Icon(
                Icons.apps_rounded,
                size: 25,
                color: Colors.white,
              ),
              onPressed: () {
                _onPressedFilter();
              },
            ),
            _getPopMenuButton(context)
          ]),
          body: AppUtils.getAppBody(baseListViewModel!, _getBody)),
    );
  }

  PopupMenuButton<int> _getPopMenuButton(BuildContext context) {
    return PopupMenuButton(
        // add icon, by default "3 dot" icon
        // icon: Icon(Icons.book)
        itemBuilder: (context) {
      return [
        // _getPopupMenuItem(
        //     label: "Filter", value: 0, iconData: Icons.apps_rounded),
        _getPopupMenuItem(
            label: "Language", value: 1, iconData: Icons.language),
        _getPopupMenuItem(
            label: "Font Size", value: 2, iconData: Icons.font_download),
      ];
    }, onSelected: (value) {
      // if (value == 0) {
      //   _onPressedFilter();
      // }
      if (value == 1) {
        _onPressedLanguages(context);
      } else if (value == 2) {
        _onPressedFontSize(context);
      }
    });
  }

  _onPressedFontSize(
    BuildContext context,
  ) {
    AppUtils.getSimpleDialog(context,
        title: 'Select Font Size', children: _getFontOptionsWidgets);
  }

  List<Widget> get _getFontOptionsWidgets {
    List<Widget> widgets = [];
    widgets.add(Divider(
      color: Colors.grey.shade300,
    ));

    fontOptions.forEach((key, value) {
      widgets.add(_getFontRadioListTile(label: value, value: key));
    });

    return widgets;
  }

  RadioListTile<String> _getFontRadioListTile(
      {required String label, required String value}) {
    return RadioListTile<String>(
      title: Text(label),
      value: value,
      groupValue: _selectedFont,
      onChanged: (value) {
        setState(() {
          _selectedFont = value!;
          //AppUtils.printDebug("_selectedLanguage = $_selectedLanguage");
          Navigator.pop(context);
        });
      },
    );
  }

  _onPressedLanguages(
    BuildContext context,
  ) {
    AppUtils.getSimpleDialog(context,
        title: 'Select Language', children: _getLanguageOptionsWidgets);
  }

  List<Widget> get _getLanguageOptionsWidgets {
    List<Widget> widgets = [];
    widgets.add(Divider(
      color: Colors.grey.shade300,
    ));
    for (var language in languageOptions) {
      widgets.add(_getLanguageRadioListTile(
          label: language, value: language.toLowerCase()));
    }
    return widgets;
  }

  RadioListTile<String> _getLanguageRadioListTile(
      {required String label, required String value}) {
    return RadioListTile<String>(
      title: Text(label),
      value: value,
      groupValue: _selectedLanguage,
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value!;
          //  debug("_selectedLanguage = $_selectedLanguage");
          Navigator.pop(context);
        });
      },
    );
  }

  void _onPressedFilter() {
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
      if (value != null) {
        Scrollable.ensureVisible(
          (_keys?[value].currentContext)!,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          alignment: 0.5,
        );
      }
    });
  }

  PopupMenuItem<int> _getPopupMenuItem(
      {int? value, required String label, required IconData iconData}) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(label)
        ],
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Leave Exam'),
            content: const Text('What do you want to do?'),
            actions: _getPopActions(context),
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  List<Widget> _getPopActions(BuildContext context) {
    List<Widget> widgets = [];

    widgets.add(_getPopContinueButton(context));
    if (!widget.reAttempt!) {
      widgets.add(_getPopSaveButton(context));
    } else {
      widgets.add(_getPopCancelButton(context));
    }
    widgets.add(_getPopSubmitButton(context));
    return widgets;
  }

  ElevatedButton _getPopCancelButton(BuildContext context) {
    return AppUtils.getElevatedButton("Cancel", onPressed: () {
      //stopTimer();
      Navigator.of(context).pop(false);
      Navigator.pop(context);
    },
        textStyle: const TextStyle(color: Colors.black),
        buttonStyle:
            ElevatedButton.styleFrom(backgroundColor: AppColor.greyColor));
  }

  ElevatedButton _getPopContinueButton(BuildContext context) {
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
        Timer(
            Duration.zero,
            () => AppUtils.getAlert(
                  context,
                  ["No Questions to Start Exam!"],
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ));

        return const Center(
          child: Text("No Questions to Start Exam!"),
        );
      }
      // debug("data loaded == $hasDataLoaded");
      if (!hasDataLoaded) {
        hasDataLoaded = true;
        _initDuration(model);
        setState(() {
          title = model.exam!.title!;
          totalQuestions =
              model.questionModels != null ? model.questionModels!.length : 0;
        });

        _keys = List.generate(totalQuestions!, (index) => GlobalKey());
        _radioListKey = List.generate(totalQuestions!, (index) => GlobalKey());
      }
    }
    return Column(
      children: [
        Align(alignment: Alignment.centerRight, child: _getBottomButtons()),
        _getTopBar(),
        Flexible(
          child: SingleChildScrollView(
              //  physics: NeverScrollableScrollPhysics,
              child: Column(children: _getQuestionOptionWidgets())),
        ),
      ],
    );
  }

  void _initDuration(ExamModel model) {
    if (model.exam?.remainingExamTime != null &&
        (model.exam?.remainingExamTime?.isNotEmpty)! &&
        !widget.reAttempt!) {
      String remainingTime = (model.exam?.remainingExamTime)!;

      List<String> remainingTimes = remainingTime.split(":");
      int hours = int.tryParse(remainingTimes[0])!;
      int minutes = int.tryParse(remainingTimes[1])!;
      int seconds = int.tryParse(remainingTimes[2])!;
      //print("hours = $hours, min = $minutes, seconds = $seconds");
      setState(() {
        myDuration ??=
            Duration(hours: hours, minutes: minutes, seconds: seconds);
        timerWidget = TimerWidget(
          duration: myDuration!,
          callBack: updateTimer,
          onSubmit: _onSubmit,
        );
      });
    } else {
      //print("duration = ${model.exam!.duration!}");
      var duration = int.tryParse(model.exam!.duration!);
      setState(() {
        myDuration ??= Duration(minutes: duration!);
        timerWidget = TimerWidget(
          duration: myDuration!,
          callBack: updateTimer,
          onSubmit: _onSubmit,
        );
      });
    }
  }

  List<Widget> _getQuestionOptionWidgets() {
    List<Widget> widgets = [];
    // widgets.add(Padding(
    //   padding: const EdgeInsets.all(20.0),
    //   child: Column(
    //     children: [
    //       _getTopBar(),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //     ],
    //   ),
    // ));

    // bool isBlankSelValues = selectedValues.isEmpty;
    var i = 0;

    for (QuestionModel model
        in (baseListViewModel?.viewModels[0].model.questionModels)!) {
      selectedValues.add(model.submittedAnswer!);

      model.index = i++;
      widgets.add(_getQuestionOptionWidget(model));
    }

    widgets.add(_getBottomButtons());

    return widgets;
  }

  Padding _getTopBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
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

            timerWidget
            /* Text(
              timerText,
              style: TextStyle(color: Colors.white),
            ) */
          ],
        ),
      ),
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
      child:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: _getActions),
    );
  }

  List<Widget> get _getActions {
    List<Widget> widgets = [];
    if (!widget.reAttempt!) {
      widgets.add(_getSaveButton());
      widgets.add(const SizedBox(
        width: 10,
      ));
    } else {
      widgets.add(_getCancelButton());
      widgets.add(const SizedBox(
        width: 10,
      ));
    }
    widgets.add(_getSubmitButton());
    return widgets;
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

  void _onSubmit({String status = "Completed", String timerUP = ""}) {
    //debug("Status === $status");
    if (hasCanceledTimer) {
      return;
    }
    ExamModel examModel = baseListViewModel?.viewModels[0].model as ExamModel;
    examModel.exam?.remainingExamTime = timerText;
    var message = status == ResultStatus.completed
        ? "$timeUP Submitting Your Exam..."
        : "$timeUP Saving Your Exam...";
    var successMessage = status == ResultStatus.completed
        ? "$timeUP Exam Submitted!"
        : "$timeUP Exam Saved!";

    var totalSkippedCount = 0;
    var totalAnsweredCount = 0;
    for (QuestionModel qm in examModel.questionModels!) {
      if (qm.submittedAnswer == null || (qm.submittedAnswer?.isEmpty)!) {
        totalSkippedCount++;
      } else {
        totalAnsweredCount++;
      }
    }
    showSubmitExamDialog(
            totalQuestions: examModel.questionModels?.length,
            totalAnswered: totalAnsweredCount,
            totalSkipped: totalSkippedCount)
        .then((value) {
      // debug("value === $value");
      if (value == "submit") {
        AppUtils.onLoading(context, message);
        ExamListViewModel()
            .submitExam(examModel, status: status)
            .then((resultId) {
          //print("examid = $value");
          Navigator.pop(context);
          //stopTimer();
          hasCanceledTimer = true;
          AppUtils.getAlert(context, [successMessage],
              onPressed: () => _onPressedAlert(resultId, status));
        }).catchError((error, stacktrace) {
          // debug(stacktrace);
          Navigator.pop(context);
          AppUtils.onError(context, error);
        });
      }
    });
  }

  void _onPressedAlert(resultId, status) {
    Navigator.of(context).pop();
    //Navigator.of(context).pop();
    //Navigator.of(context).pop("reload");
    if (status == ResultStatus.inProgress) {
      Navigator.of(context).pop("reload");
      return;
    }
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (_) => ResultListViewModel(),
                    )
                  ],
                  child: ResultView(
                      resultId: resultId.toString(), userId: widget.userId))),
    );

    /* AppUtils.viewPush(
        context,
        MultiProvider(providers: [
          ChangeNotifierProvider(
            create: (_) => ResultListViewModel(),
          )
        ], child: ResultView(resultId: resultId, userId: widget.userId)));
    //Navigator.of(context).pop("reload"); */
  }

  void _onCancel() {
    Navigator.pop(context);
  }

  Padding _getQuestionOptionWidget(model) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
            key: _radioListKey?[model.index],
            children: _getQuestionOptions(model)),
      ),
    );
  }

  List<Widget> _getQuestionOptions(QuestionModel model) {
    return [
      _getQuestion(model),
      const SizedBox(
        height: 10,
      ),
      RadioListTileWidget(
        contentWidget: _getContent(model.optionAHindi, model.optionAEnglish),
        value: "a",
        model: model,
        selectedValues: selectedValues,
        callBack: setRadioValues,
        selectedFont: _selectedFont!,
        selectedLanguage: _selectedLanguage,
      ),

      /* _getOption(model.optionAHindi, model.optionAEnglish, "a", model),
      _getOption(model.optionBHindi, model.optionBEnglish, "b", model),
      _getOption(model.optionCHindi, model.optionCEnglish, "c", model),
      _getOption(model.optionDHindi, model.optionDEnglish, "d", model), */
      const SizedBox(
        height: 10,
      ),
      Container(
        height: 50,
        decoration: const BoxDecoration(
          color: AppColor.containerBoxColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getIconButton(
              'Clear Section',
              model.submittedAnswer != null &&
                      (model.submittedAnswer?.isNotEmpty)!
                  ? Icons.clear_rounded
                  : Icons.radio_button_unchecked_outlined,
              onPressed: () {
                //print("index = ${model.index}");
                setState(() {
                  selectedValues[model.index] = "";
                  model.submittedAnswer = "";
                });
              },
            ),
            getIconButton(
              'Favourite',
              Icons.star_border_purple500_sharp,
              textColor: model.isFavourite
                  ? const Color.fromARGB(255, 248, 248, 9)
                  : Colors.white,
              iconColor: model.isFavourite
                  ? const Color.fromARGB(255, 248, 248, 9)
                  : Colors.white,
              onPressed: () {
                setState(() {
                  model.favourite = (!model.isFavourite).toString();
                });
              },
            ),
          ],
        ),
      )
    ];
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

  RadioListTile<String> _getOption(
      label, labelEnglish, value, QuestionModel model) {
    return RadioListTile(
      title: _getContent(label, labelEnglish),
      value: value,
      groupValue: selectedValues[model.index],
      activeColor: Colors.blue,
      selectedTileColor: const Color.fromARGB(255, 197, 221, 241),
      selected: value == selectedValues[model.index],
      onChanged: (value) {
        setState(() {
          //print("Value = $value");
          selectedValues[model.index] = value!;
          model.submittedAnswer = value;
        });
      },
    );
  }

  void setRadioValues(value, model) {
    //debug("Value = $value");
    selectedValues[model.index] = value!;
    model.submittedAnswer = value;
    /* setState(() {
      debug("Value = $value");
      //selectedValues[model.index] = value!;
      //model.submittedAnswer = value;
    }); */
  }

  Widget _getQuestion(QuestionModel model) {
    return Align(
      alignment: Alignment.centerLeft,
      key: _keys?[model.index],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 11),
            child: Text(
              "Q ${model.index + 1}. ",
              style: TextStyle(
                fontSize: double.tryParse(_selectedFont!),
                //  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 10),
              child: _getContent(
                  "${model.questionHindi}", "${model.questionEnglish}",
                  questionNumber: model.index + 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getContent(labelHindi, labelEnglish, {questionNumber}) {
    List<Widget> widgets = [];
    if (labelHindi != null &&
        (_selectedLanguage.toLowerCase() == "both" ||
            _selectedLanguage.toLowerCase() == "hindi")) {
      /*  labelHindi = questionNumber != null
          ? "Q. $questionNumber) $labelHindi"
          : labelHindi;  */

      // debug("labelHindi ${labelHindi}");

      //labelHindi = '<div style="font-size: ${double.tryParse(_selectedFont!)!}px !important;">$labelHindi</div>';
      // RegExp exp = RegExp(r'(font-size\s*:\s*)(\d+(\.\d+)?)(pt|px)?');
      // // String? str = e.attributes['style'];
      // labelHindi = labelHindi!
      //     .replaceAll(exp, 'font-size:${double.tryParse(_selectedFont!)}px');

      // labelHindi =
      //     '<div style="font-size:${double.tryParse(_selectedFont!)}px">$labelHindi</div>';

      // debug("labelHindi@@ ${labelHindi}");
      labelHindi = AppUtils.changeFontSize(labelHindi, _selectedFont!);

      widgets.add(Align(
        alignment: Alignment.centerLeft,
        child: AppUtils.getHtmlData1(
          labelHindi,
        ),
      ));

      // widgets.add(AppUtils.getHtmlData(labelHindi,
      //     fontFamily: 'Kruti Dev 010',
      //     fontSize: double.tryParse(_selectedFont!)!));
    }
    if (labelEnglish != null &&
        labelEnglish.toString().trim().isNotEmpty &&
        (_selectedLanguage.toLowerCase() == "both" ||
            _selectedLanguage.toLowerCase() == "english")) {
      /*  labelEnglish = questionNumber != null
          ? "Q. $questionNumber) $labelEnglish"
          : labelEnglish; */

      // RegExp exp = RegExp(r'(font-size\s*:\s*)(\d+(\.\d+)?)(pt|px)?');
      // // String? str = e.attributes['style'];
      // labelEnglish = labelEnglish!
      //     .replaceAll(exp, 'font-size:${double.tryParse(_selectedFont!)}px');

      // labelEnglish =
      //     '<div style="font-size:${double.tryParse(_selectedFont!)}px">$labelEnglish</div>';

      labelEnglish = AppUtils.changeFontSize(labelEnglish, _selectedFont!);

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

  Future showSubmitExamDialog({
    totalQuestions,
    totalAnswered,
    totalSkipped,
  }) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //insetPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                    child: Center(
                        child: Text(
                  "Submit Your Test",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))),
                const SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                )
              ],
            ),
            content: Container(
              padding: EdgeInsets.zero,
              width: MediaQuery.of(context).size.width * 0.45,
              child: Table(
                border: TableBorder.all(
                    color: Colors.black, style: BorderStyle.solid, width: 1),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('No. of questions: ',
                              style: TextStyle(fontSize: 15.0)),
                          Text(totalQuestions.toString(),
                              style: const TextStyle(fontSize: 15.0)),
                        ],
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Answereded: ',
                              style: TextStyle(fontSize: 15.0)),
                          Text(totalAnswered.toString(),
                              style: const TextStyle(fontSize: 15.0)),
                        ],
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Not Attended: ',
                              style: TextStyle(fontSize: 15.0)),
                          Text(totalSkipped.toString(),
                              style: const TextStyle(fontSize: 15.0)),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
            ),

            actions: [
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                width: double.infinity,
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    Navigator.of(context).pop("submit");
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          );
        });
  }

  void updateTimer(String value) {
    //debug("value = $value");
    timerText = value;
  }
}
