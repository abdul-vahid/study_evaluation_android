import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/question_answer_model/exam_model.dart';
import 'package:study_evaluation/models/question_answer_model/question_model.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/leardeboard_view.dart';
import 'package:study_evaluation/view/widgets/custom_alertdialog.dart';
import 'package:study_evaluation/view/widgets/app_drawer_widget.dart';
import 'package:study_evaluation/view_models/result_list_vm.dart';

class ResultView extends StatefulWidget {
  final String resultId;
  final String studentId;

  ResultView({super.key, required this.resultId, required this.studentId});

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

  String _selectedLanguage = "Hindi";
  String? _selectedFont = "15";
  String? _selectedFilter = "all";
  String title = "Result";
  int timerMaxSeconds = 60;
  int? totalQuestions = 30;
  Map<String, int> filtersMap = {};
  bool isRefresh = false;
  @override
  void initState() {
    Provider.of<ResultListViewModel>(context, listen: false)
        .fetch(widget.resultId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    baseListViewModel = Provider.of<ResultListViewModel>(context);

    return Scaffold(
        drawer: AppDrawerWidget(),
        appBar: AppUtils.getAppbar(title, actions: [
          IconButton(
              // ignore: prefer_const_constructors
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
                                  create: (_) => BaseListViewModel())
                            ],
                            child: const LearderbordView(),
                          )),
                );
              }),
          _getFilterButton()
        ]),
        body: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: AppUtils.getAppBody(baseListViewModel!, _getBody)));
  }

  Widget _getBody() {
    if (baseListViewModel!.viewModels.isNotEmpty &&
        baseListViewModel!.viewModels[0].model != null) {
      ExamModel model = baseListViewModel!.viewModels[0].model;
      print("hello");

      if (model.questionModels == null || model.questionModels!.isEmpty) {
        return const Center(
          child: Text("No Results Found!"),
        );
      }
      if (isRefresh) {
        AppUtils.printDebug("base list view model");
        Navigator.pop(context);
        isRefresh = false;
      }
      setState(() {
        //isRefresh = false;
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

  List<Widget> getButtonWidgets() {
    List<Widget> list = [];
    filtersMap.forEach((key, value) {
      print('@@${value}');
      list.add(
          getButtons('${AppUtils.capitalize(key)}(${value})', onPressed: () {
        setState(() {
          _selectedFilter = key;
          print('_selectedFilter === =$_selectedFilter --- $key');
        });
      }));
    });
    return list;
  }

  List<DropdownMenuItem<String>>? getFilters() {
    print("Filters");
    List<DropdownMenuItem<String>>? dropDownItems = [];
    filtersMap.forEach((key, value) {
      print("@@@kay $key = $value");

      dropDownItems.add(DropdownMenuItem<String>(
        value: key,
        child: Text(
          "${AppUtils.capitalize(key)}($value)",
          style: const TextStyle(fontSize: 15),
        ),
      ));
    });
    return dropDownItems;
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
    bool isBlankSelValues = selectedValues.isEmpty;
    var i = 0;

    _loadFilters();

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
            children: [
              _getLanguageDropdown(),
              _getFontDropdown(),
            ],
          ),

          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: ListView(
                scrollDirection: Axis.horizontal, children: getButtonWidgets()),
          ),

          ///  _getDropdown()
          /*  _getDropdown(
              hint: "Select",
              value: _selectedFilter,
              type: "filter",
              onChanged: (value) => {
                    setState(() {
                      _selectedFilter = value!;
                    })
                  },
              items: getFilters()) */
        ],
      ),
    ));

    for (QuestionModel model
        in (baseListViewModel?.viewModels[0].model.questionModels)!) {
      model.index = i++;
      print("isWrong ${model.isWrong}");
      if (_selectedFilter == "all" ||
          (_selectedFilter == "favourite" && model.isFavourite) ||
          (_selectedFilter == "skipped" && model.isSkipped) ||
          (_selectedFilter == "wrong" && model.isWrong) ||
          (_selectedFilter == "correct" && model.isCorrect)) {
        print("_selectedFilter = $_selectedFilter");
        widgets.add(_getQuestionOptionWidget(model));
      }
    }
    // widgets.add(_getBottomButtons());
    return widgets;
  }

  Color getBackgroundColor(String label) {
    if (label.toLowerCase().contains("favourite") &&
        _selectedFilter == "favourite") {
      return Colors.blue;
    } else if (label.toLowerCase().contains("correct") &&
        _selectedFilter == "correct") {
      return Colors.blue;
    } else if (label.toLowerCase().contains("wrong") &&
        _selectedFilter == "wrong") {
      return Colors.blue;
    } else if (label.toLowerCase().contains("skipped") &&
        _selectedFilter == "skipped") {
      return Colors.blue;
    } else if (label.toLowerCase().contains("all") &&
        _selectedFilter == "all") {
      return Colors.blue;
    }

    return Colors.white;
  }

  Color getSelectedButtonTextColor(String label) {
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
  }

  Padding getButtons(btnLabel,
      {required void Function()? onPressed, buttonStyle, textStyle}) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: getBackgroundColor(btnLabel),
                side: BorderSide(
                  width: 1.0,
                  color: AppColor.containerBoxColor,
                )),
            onPressed: onPressed,
            child: Text(
              btnLabel,
              style: TextStyle(color: getSelectedButtonTextColor(btnLabel)),
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
    AppUtils.printDebug(filtersMap);
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

  // Padding _getBottomButtons() {
  //   return Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: Container(height: 10, width: 100, child: const Text("Button")),
  //   );
  // }

  Widget _getDropdown() {
    return Container(
        width: 120,
        height: 55,
        padding: EdgeInsets.zero,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

                // prefixIcon: Icon(Icons.person, color: AppColor.iconColor),
              ),
              hint: const Text("Filters"),
              // Not necessary for Option 1
              value: _selectedFilter,
              //validator: (value) => value == null ? 'Required' : null,
              //isDense: true,
              isExpanded: false,
              menuMaxHeight: 350,
              onChanged: (value) => setState(() {
                    print("Value $value");
                    _selectedFilter = value;
                  }),
              items: getFilters()),
        ));
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
          child: Column(children: _getQuestionOptions(model)),
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
          textAlign: TextAlign.left,
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

  _getSelectedColor(QuestionModel model, String value) {
    if (model.answer == value) {
      return Colors.green;
    } else if (model.submittedAnswer == value) {
      return Colors.red;
    }
  }

  Future<void> _pullRefresh() async {
    baseListViewModel?.viewModels.clear();
    baseListViewModel = null;
    print("pull refresh");
    isRefresh = true;
    AppUtils.onLoading(context, "Refreshing");
    String url = AppUtils.getUrl(
        "${AppConstants.resultAPIPath}?result_id=${widget.resultId}&user_id=${widget.studentId}");
    Provider.of<BaseListViewModel>(context, listen: false)
        .get(baseModel: ExamModel(), url: url);
    baseListViewModel = Provider.of<BaseListViewModel>(context, listen: false);
    print("length = ${baseListViewModel?.viewModels.length}");
  }
}
