// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/base_list_view_model.dart';
import '../../models/notification_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_utils.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  BaseListViewModel? baseListViewModel;
  bool _customTileExpanded = false;

  @override
  void initState() {
    super.initState();
    String url =
        AppUtils.getUrl("${AppConstants.notificationAPIPath}?user_id=169");
    print('url@@@$url');
    Provider.of<BaseListViewModel>(context, listen: false)
        .postData(baseModel: NotificationModel(), url: url, body: '');
  }

  @override
  Widget build(BuildContext context) {
    baseListViewModel = Provider.of<BaseListViewModel>(context);
    var a = baseListViewModel!.viewModels.length;
    print('@@@a$a');
    print('@@@$baseListViewModel');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButton(color: Colors.white),
          title: const Text("Notification"),
          elevation: .1,
          backgroundColor: AppColor.appBarColor,
        ),
        body: ListView(
            padding: const EdgeInsets.all(8),
            children: _getNotificationWidgets));
  }

  List<Widget> get _getNotificationWidgets {
    List<Widget> widgets = [];

    for (var viewModel in baseListViewModel!.viewModels) {
      widgets.add(getExpansionTile(viewModel.model));

      print('viewModel$viewModel');
      // viewModel.model
      print('viewModel.model@@ ${viewModel.model}');
    }

    return widgets;
  }

  ExpansionTile getExpansionTile(NotificationModel) {
    return ExpansionTile(
      title: Text(
        NotificationModel.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: const Text('Custom expansion arrow icon'),
      trailing: Icon(
        _customTileExpanded
            ? Icons.arrow_drop_down_circle
            : Icons.arrow_drop_down,
      ),
      children: <Widget>[
        ListTile(
          title: Text(
            NotificationModel.message,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() => _customTileExpanded = expanded);
      },
    );
  }

  Card getCard(NotificationModel) {
    return Card(
        child: ListTile(
      title: Text(
        NotificationModel.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        NotificationModel.message,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      // // ignore: unnecessary_null_comparison
      // leading: CircleAvatar(
      //     // ignore: unnecessary_null_comparison
      //     backgroundImage: profileUrl == null
      //         ? const NetworkImage(
      //             'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg')
      //         : NetworkImage(profileUrl!)),
      trailing: const Icon(
        Icons.notification_add,
      ),
    ));
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Center(child: const Text("Notification"))),
//       body: ListView.builder(
//           itemCount: 5,
//           itemBuilder: (BuildContext context, int index) {
//             return Padding(
//               padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
//               child: Card(
//                 child: ListTile(
//                     // leading: const Icon(Icons.list),
//                     trailing: const Icon(
//                       Icons.more_vert,
//                     ),
//                     title: Text("List item $index")),
//               ),
//             );
//           }),
//     );
//   }
// }
