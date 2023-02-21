import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/result_english_view.dart';
import 'package:study_evaluation/view/views/result_hindi_english_view.dart';
import 'package:study_evaluation/view/views/result_hindi_view.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppUtil.getAppbar("Result", bottom: _getTabs),
        body: const TabBarView(
          children: [
            ResultHindiView(),
            ResultEnglishView(),
            ResultHindiEnglishView(),
          ],
        ),
      ),
    ));
  }

  Widget get _getTabs => const TabBar(
        tabs: [
          Tab(text: "Hindi"),
          Tab(text: "English"),
          Tab(text: "Both"),
        ],
      );
}
