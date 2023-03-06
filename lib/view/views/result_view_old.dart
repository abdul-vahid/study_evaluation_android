import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/result_english_view.dart';
import 'package:study_evaluation/view/views/result_hindi_english_view.dart';
import 'package:study_evaluation/view/views/result_hindi_view.dart';

class ResultViewOld extends StatefulWidget {
  const ResultViewOld({super.key});

  @override
  State<ResultViewOld> createState() => _ResultViewOldState();
}

class _ResultViewOldState extends State<ResultViewOld> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppUtils.getAppbar("Result", bottom: _getTabs),
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
