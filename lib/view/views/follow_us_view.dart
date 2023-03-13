import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_color.dart';
import '../../view_models/follow_us_list_vm.dart';

class FollowUsView extends StatefulWidget {
  const FollowUsView({super.key});

  @override
  State<FollowUsView> createState() => _FollowUsViewState();
}

class _FollowUsViewState extends State<FollowUsView> {
  var followListVM;

  @override
  void initState() {
    Provider.of<FollowUSListViewModel>(context, listen: false).fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    followListVM = Provider.of<FollowUSListViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(color: Colors.white),
          title: Text("Follow Us"),
          elevation: .1,
          backgroundColor: AppColor.appBarColor,
        ),
        body: ListView(
            padding: const EdgeInsets.all(8), children: _getFollowUsWidgets));
  }

  List<Widget> get _getFollowUsWidgets {
    List<Widget> widgets = [];

    for (var viewModel in followListVM.viewModels) {
      widgets.add(getCard(viewModel.model));
    }

    return widgets;
  }

  InkWell getCard(followModel) {
    return InkWell(
      onTap: () {
        launch(followModel?.url);
      },
      child: Card(
          child: ListTile(
        title: Text(
          followModel.title,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: AppColor.textColor),
        ),
        leading: Image.asset(
          followModel.image,
          height: 60,
          width: 60,
        ),
      )),
    );
  }
}
