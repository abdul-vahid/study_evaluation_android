// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/base_list_view_model.dart';
import '../../models/leader_board_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_utils.dart';

class LearderbordView extends StatefulWidget {
  const LearderbordView({super.key});

  @override
  State<LearderbordView> createState() => _LearderbordViewState();
}

class _LearderbordViewState extends State<LearderbordView> {
  BaseListViewModel? baseListViewModel;
  static int? rank = 0;
  @override
  void initState() {
    super.initState();
    String url =
        AppUtils.getUrl("${AppConstants.leaderboardAPIPath}?exam_id=96");
    print('url@@@$url');
    Provider.of<BaseListViewModel>(context, listen: false)
        .get(baseModel: LeaderBoardModel(), url: url);
  }

  @override
  Widget build(BuildContext context) {
    baseListViewModel = Provider.of<BaseListViewModel>(context);

    print('@@@$baseListViewModel');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButton(color: Colors.white),
          title: const Text("Leardebord"),
          elevation: .1,
          backgroundColor: AppColor.appBarColor,
        ),
        body: ListView(
            padding: const EdgeInsets.all(8), children: _getFollowUsWidgets));
  }

  List<Widget> get _getFollowUsWidgets {
    List<Widget> widgets = [];

    for (var viewModel in baseListViewModel!.viewModels) {
      widgets.add(getCard(viewModel.model));

      print('viewModel$viewModel');
      // viewModel.model
      print('viewModel.model@@ ${viewModel.model}');
    }

    return widgets;
  }

  Card getCard(leaderboardModel) {
    var url = AppUtils.getImageUrl(leaderboardModel.profileUrl);
    rank = rank! + 1;
    print('url@@@$url');
    return Card(
        child: ListTile(
      title: Text(
        leaderboardModel.firstName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "${leaderboardModel.totalMarks} Marks",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: CircleAvatar(backgroundImage: NetworkImage(url)),
      trailing: Text(
        '#${rank.toString()}',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ));
  }
}
