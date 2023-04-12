// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/question_answer_model/exam_model.dart';
import 'package:study_evaluation/models/question_answer_model/question_model.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/utils/function_lib.dart';
import 'package:study_evaluation/view/views/analysis_view.dart';
import 'package:study_evaluation/view/views/learderboard_view.dart';
import 'package:study_evaluation/view/widgets/custom_alertdialog.dart';
import 'package:study_evaluation/view/widgets/app_drawer_widget.dart';
import 'package:study_evaluation/view_models/leaderboard_list_vm.dart';
import 'package:study_evaluation/view_models/result_list_vm.dart';

class ResultView extends StatefulWidget {
  final String resultId;
  final String userId;
  String? parentPage;

  ResultView(
      {super.key,
      required this.resultId,
      required this.userId,
      this.parentPage});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  List<GlobalKey>? _keys;
  bool isButtonPressed = false;

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
  String? _selectedFilter = "all";
  String title = "Result";
  String? examId;
  int timerMaxSeconds = 60;
  int? totalQuestions = 30;
  Map<String, int> filtersMap = {};
  bool isRefresh = false;

  ExamModel? model;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      var userModel = AppUtils.getSessionUser(prefs);
      userModel ?? AppUtils.logout(context);
    });
    Provider.of<ResultListViewModel>(context, listen: false)
        .fetch(widget.resultId);
    Timer(
      const Duration(seconds: 3),
      () {
        setState(
          () {},
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    baseListViewModel = Provider.of<ResultListViewModel>(context);

    return WillPopScope(
      onWillPop: () {
        if (widget.parentPage == null) {
          Navigator.pop(context); //Removing Self
        }
        Navigator.of(context).pop(
            "reload"); //Going back to Package Detail Page, Skipping ExamView
        return Future.value(true);
      },
      child: Scaffold(
          drawer: const AppDrawerWidget(),
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
            IconButton(
                icon: Icon(
                  Icons.leaderboard,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiProvider(
                              providers: [
                                ChangeNotifierProvider(
                                    create: (_) => LeaderBoardListViewModel())
                              ],
                              child: LearderbordView(examId: examId),
                            )),
                  );
                }),
            //  _getFilterButton(),
            _getPopMenuButton(context),
          ]),
          body: RefreshIndicator(
              onRefresh: _pullRefresh,
              child: AppUtils.getAppBody(baseListViewModel!, _getBody))),
    );
  }

  PopupMenuButton<int> _getPopMenuButton(BuildContext context) {
    return PopupMenuButton(
        // add icon, by default "3 dot" icon
        // icon: Icon(Icons.book)
        itemBuilder: (context) {
      return [
        _getPopupMenuItem(
            label: "Analysis", value: 2, iconData: Icons.analytics),
        // _getPopupMenuItem(
        //     label: "Filter", value: 0, iconData: Icons.apps_rounded),
        _getPopupMenuItem(
            label: "Language", value: 0, iconData: Icons.language),
        _getPopupMenuItem(
            label: "Font Size", value: 1, iconData: Icons.font_download),
      ];
    }, onSelected: (value) {
      if (value == 0) {
        _onPressedLanguages(context);
      } else if (value == 1) {
        _onPressedFontSize(context);
      } else if (value == 2) {
        _onPressedAnalysis();
      }
      // } else if (value == 3) {

      // }
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
          SizedBox(
            width: 5,
          ),
          Text(label)
        ],
      ),
    );
  }

  Widget _getBody() {
    if (baseListViewModel!.viewModels.isNotEmpty &&
        baseListViewModel!.viewModels[0].model != null) {
      model = baseListViewModel!.viewModels[0].model;
      if (model?.questionModels == null || (model?.questionModels!.isEmpty)!) {
        return const Center(
          child: Text("No Results Found!"),
        );
      }
      if (isRefresh) {
        Navigator.pop(context);
        isRefresh = false;
      }
      setState(() {
        //isRefresh = false;
        title = (model?.exam!.title)!;
        examId = model?.exam!.id!;

        totalQuestions =
            model?.questionModels != null ? model?.questionModels!.length : 0;
      });

      _keys = List.generate(totalQuestions!, (index) => GlobalKey());
    }
    return SingleChildScrollView(
        child: Column(children: _getQuestionOptionWidgets()));
  }

  List<Widget> getButtonWidgets() {
    List<Widget> list = [];
    filtersMap.forEach((key, value) {
      list.add(
          getButtons('${AppUtils.capitalize(key)}(${value})', onPressed: () {
        setState(() {
          _selectedFilter = key;
        });
      }));
    });
    return list;
  }

  List<Widget> _getQuestionOptionWidgets() {
    List<Widget> widgets = [];
    var i = 0;

    _loadFilters();

    widgets.add(Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: ListView(
                scrollDirection: Axis.horizontal, children: getButtonWidgets()),
          ),
        ],
      ),
    ));

    for (QuestionModel model
        in (baseListViewModel?.viewModels[0].model.questionModels)!) {
      model.index = i++;

      if (_selectedFilter == "all" ||
          (_selectedFilter == "favourite" && model.isFavourite) ||
          (_selectedFilter == "skipped" && model.isSkipped) ||
          (_selectedFilter == "wrong" && model.isWrong) ||
          (_selectedFilter == "correct" && model.isCorrect)) {
        widgets.add(_getQuestionOptionWidget(model));
      }
    }
    // widgets.add(_getBottomButtons());
    return widgets;
  }

  Color _getFilterColor(String label, {type = ""}) {
    if ((label.toLowerCase().contains("favourite") &&
            _selectedFilter == "favourite") ||
        (label.toLowerCase().contains("correct") &&
            _selectedFilter == "correct") ||
        (label.toLowerCase().contains("wrong") && _selectedFilter == "wrong") ||
        (label.toLowerCase().contains("skipped") &&
            _selectedFilter == "skipped") ||
        (label.toLowerCase().contains("all") && _selectedFilter == "all")) {
      if (type == "background") {
        return Colors.blue;
      } else {
        return Colors.white;
      }
    }
    if (type == "background") {
      return Colors.white;
    } else {
      return AppColor.textColor;
    }
  }

  /* Color getSelectedButtonTextColor(String label) {
    if (label.toLowerCase().contains("favourite") &&
        _selectedFilter == "favourite") {
      return Colors.white;
    } else if (label.toLowerCase().contains("correct") &&
        _selectedFilter == "correct") {
      return Colors.white;
    } else if (label.toLowerCase().contains("wrong") &&
        _selectedFilter == "wrong") {
      return Colors.white;
    } else if (label.toLowerCase().contains("skipped") &&
        _selectedFilter == "skipped") {
      return Colors.white;
    } else if (label.toLowerCase().contains("all") &&
        _selectedFilter == "all") {
      return Colors.white;
    }

    return AppColor.textColor;
  } */

  Padding getButtons(btnLabel,
      {required void Function()? onPressed, buttonStyle, textStyle}) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: _getFilterColor(btnLabel, type: "background"),
                side: BorderSide(
                  width: 1.0,
                  color: AppColor.containerBoxColor,
                )),
            onPressed: onPressed,
            child: Text(
              btnLabel,
              style: TextStyle(color: _getFilterColor(btnLabel, type: "text")),
            )));
  }

  void onPressed() {}

  void _loadFilters() {
    if (filtersMap.isNotEmpty) return;
    for (QuestionModel model
        in (baseListViewModel?.viewModels[0].model.questionModels)!) {
      if (model.isFavourite) {
        _loadFilterMap("favourite");
      }

      if (model.isCorrect) {
        _loadFilterMap("correct");
      }

      if (model.isSkipped) {
        _loadFilterMap("skipped");
      }

      if (model.isWrong) {
        _loadFilterMap("wrong");
      }

      _loadFilterMap("all");
    }

    filtersMap = Map.fromEntries(filtersMap.entries.toList()
      ..sort((e1, e2) => e1.key.compareTo(e2.key)));
  }

  void _loadFilterMap(key) {
    print("debug _loadfilter");
    int favCount = 0;
    if (filtersMap.containsKey(key)) {
      favCount = filtersMap[key]!;
    }
    favCount++;
    filtersMap[key] = favCount;
  }

  IconButton _getFilterButton() {
    return IconButton(
        onPressed: _onPressedFilter,
        icon: const Icon(
          Icons.apps_rounded,
          size: 30,
          color: Colors.white, // add custom icons also
        ));
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
  }

  Padding _getQuestionOptionWidget(model) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color.fromARGB(255, 181, 179, 179),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(children: _getQuestionOptions(model)),
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
      //_getQuestionBottom(model)
    ];
  }

  Container _getQuestionBottom(QuestionModel model) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: AppColor.containerBoxColor,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // getIconButton(
          //   'Favourite',
          //   Icons.star,
          //   textColor: model.isFavourite ? Colors.yellow : Colors.white,
          //   iconColor: model.isFavourite ? Colors.yellow : Colors.white,
          //   onPressed: () {},
          // ),
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
      title: _getContent(label, labelEnglish,
          fontSize: double.tryParse(_selectedFont!)!),
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
          questionNumber: model.index + 1,
          fontSize: double.tryParse(_selectedFont!)!,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _getDescription(QuestionModel model) {
    return Card(
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.orange)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 35,
            color: Colors.orange,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Explanation",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: _getContent(
                    "${model.descriptionHindi}", "${model.descriptionEnglish}",
                    color: Colors.green,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _getContent(labelHindi, labelEnglish,
      {questionNumber,
      Color? color,
      double fontSize = 15.0,
      FontWeight fontWeight = FontWeight.normal}) {
    List<Widget> widgets = [];
    if (labelHindi != null &&
        (_selectedLanguage.toLowerCase() == "both" ||
            _selectedLanguage.toLowerCase() == "hindi")) {
      labelHindi = questionNumber != null
          ? "Q. $questionNumber) $labelHindi"
          : labelHindi;
      widgets.add(AppUtils.getHtmlData(labelHindi,
          fontFamily: 'Kruti',
          fontSize: (fontSize + 4),
          color: color,
          fontWeight: fontWeight));
    }
    if (labelEnglish != null &&
        labelEnglish.toString().trim().isNotEmpty &&
        (_selectedLanguage.toLowerCase() == "both" ||
            _selectedLanguage.toLowerCase() == "english")) {
      /* labelEnglish = questionNumber != null
          ? "Q. $questionNumber) $labelEnglish"
          : labelEnglish; */
      widgets.add(Divider(
        height: 10,
      ));
      widgets.add(AppUtils.getHtmlData(labelEnglish,
          fontSize: fontSize, color: color, fontWeight: fontWeight));
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

  _getSelectedColor(QuestionModel model, String value) {
    if (model.answer == value) {
      return Colors.green[200];
    } else if (model.submittedAnswer == value) {
      return Colors.red[100];
    }
  }

  Future<void> _pullRefresh() async {
    baseListViewModel?.viewModels.clear();
    baseListViewModel = null;
    //print("pull refresh");
    isRefresh = true;
    AppUtils.onLoading(context, "Refreshing");
    String url = AppUtils.getUrl(
        "${AppConstants.resultAPIPath}?result_id=${widget.resultId}&user_id=${widget.userId}");
    Provider.of<ResultListViewModel>(context, listen: false)
        .get(baseModel: ExamModel(), url: url);
    baseListViewModel =
        Provider.of<ResultListViewModel>(context, listen: false);
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

  RadioListTile<String> _getLanguageRadioListTile(
      {required String label, required String value}) {
    return RadioListTile<String>(
      title: Text(label),
      value: value,
      groupValue: _selectedLanguage,
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value!;
          Navigator.pop(context);
        });
      },
    );
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

  _onPressedFontSize(
    BuildContext context,
  ) {
    AppUtils.getSimpleDialog(context,
        title: 'Select Font Size', children: _getFontOptionsWidgets);
  }

  _onPressedAnalysis() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AnalysisView(
                  examModel: model!,
                )));
  }
}
