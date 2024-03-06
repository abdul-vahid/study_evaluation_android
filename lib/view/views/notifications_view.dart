// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/models/notification_model.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/utils/function_lib.dart';
import 'package:study_evaluation/view/widgets/app_drawer_widget.dart';
import 'package:study_evaluation/view_models/notifications_list_vm.dart';
import '../../core/models/base_list_view_model.dart';
import '../../models/user_model.dart';
import '../../utils/app_color.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:readmore/readmore.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  BaseListViewModel? baseListViewModel;
  UserModel? userModel;
  List<GlobalKey>? _keys;
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      var userModel = AppUtils.getSessionUser(prefs);
      userModel ?? AppUtils.logout(context);
    });
    Provider.of<NotificationsListViewModel>(context, listen: false).fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    baseListViewModel = Provider.of<NotificationsListViewModel>(context);
    //var a = baseListViewModel!.viewModels.length;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppUtils.getAppbar("Notifications"),
      body: AppUtils.getAppBody(baseListViewModel!, _getBody), //_getBody(),
      drawer: const AppDrawerWidget(),
    );
  }

  ListView _getBody() {
    return ListView(
        padding: const EdgeInsets.all(8), children: _getNotificationWidgets);
  }

  List<Widget> get _getNotificationWidgets {
    List<Widget> widgets = [];
    _keys = List.generate(
        baseListViewModel!.viewModels.length, (index) => GlobalKey());
    int index = 0;
    setState(() {
      AppUtils.notificationCount = baseListViewModel!.viewModels.length;
    });

    for (var viewModel in baseListViewModel!.viewModels) {
      if (viewModel.model.title != null && viewModel.model.message != null) {
        widgets.add(getSlidable(viewModel.model, index++));
      }
    }

    return widgets;
  }

  Slidable getSlidable(NotificationModel model, index) {
    return Slidable(
        key: _keys?[index],
        startActionPane: ActionPane(
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          //dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.

            SlidableAction(
              onPressed: (context) {
                if (model.status != "read") {
                  onSlideAction((model.id)!, "read");
                }
              },
              backgroundColor: AppColor.buttonColor,
              foregroundColor: Colors.white,
              icon: Icons.chat_outlined,
              label: 'Read',
            ),
          ],
        ),
        // Specify a key if the Slidable is dismissible.

        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                showAlertDialog(model);
                //   onSlideAction((model.id)!, "delete");
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: _getCard(model));
  }

  showAlertDialog(model) {
    Widget noButton = TextButton(
      child: Text("No"),
      onPressed: () {
        // debug("No");
        Navigator.pop(context);
      },
    );
    // set up the buttons
    Widget yesButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.pop(context);
        onSlideAction((model.id), "delete");
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Are you sure you want to delete this item?"),
      actions: [
        noButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Padding _getCard(NotificationModel model) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8, right: 8, top: 1, bottom: 5),
  //     child: Card(
  //         color: Colors.white,
  //         child: ListTile(
  //             title: Text(
  //               model.title!,
  //               style: TextStyle(fontWeight: FontWeight.bold),
  //             ),
  //             subtitle: ReadMoreText(
  //               model.message!,
  //               style: TextStyle(
  //                   color: Colors.grey[700],
  //                   fontWeight: model.status == "unread"
  //                       ? FontWeight.bold
  //                       : FontWeight.normal),
  //               trimLines: 2,
  //               colorClickableText: Colors.pink,
  //               trimMode: TrimMode.Line,
  //               trimCollapsedText: 'Read more...',
  //               trimExpandedText: '<<<Show less',
  //               moreStyle: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.bold,
  //                   color: AppColor.appBarColor),
  //               lessStyle: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.bold,
  //                   color: AppColor.appBarColor),
  //               callback: (val) {
  //                 if (model.status != "read") {
  //                   onSlideAction(model.id!, "read");
  //                 }
  //               },
  //             ))),
  //   );
  // }

  Card _getCard(NotificationModel model) {
    return Card(
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                //  mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Text(
                    model.title!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ReadMoreText(
                    model.message!,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: model.status == "unread"
                            ? FontWeight.bold
                            : FontWeight.normal),
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read more...',
                    trimExpandedText: '<<<Show less',
                    moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.appBarColor),
                    lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.appBarColor),
                    callback: (val) {
                      if (model.status != "read") {
                        onSlideAction(model.id!, "read");
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 13,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        model.formattedCreatedDate!,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }
  // Card getCard(NotificationModel model) {
  //   return Card(
  //       child: ListTile(
  //     title: Text(
  //       (model.title)!,
  //       style: TextStyle(fontWeight: FontWeight.bold),
  //     ),
  //     subtitle: Text(
  //       (model.message)!,
  //       style: TextStyle(fontWeight: FontWeight.bold),
  //     ),
  //     // // ignore: unnecessary_null_comparison
  //     // leading: CircleAvatar(
  //     //     // ignore: unnecessary_null_comparison
  //     //     backgroundImage: profileUrl == null
  //     //         ? const NetworkImage(
  //     //             'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg')
  //     //         : NetworkImage(profileUrl!)),
  //     trailing: const Icon(
  //       Icons.notification_add,
  //     ),
  //   ));
  // }

  void onSlideAction(String id, String action) {
    AppUtils.onLoading(context, "Please Wait...");
    // int currentCount = (baseListViewModel?.viewModels.length)!;
    NotificationsListViewModel().updateStatus(id, action).then((value) {
      Provider.of<NotificationsListViewModel>(context, listen: false).fetch();
      baseListViewModel =
          Provider.of<NotificationsListViewModel>(context, listen: false);

      if (baseListViewModel?.status == "Completed" ||
          (baseListViewModel?.isError)!) {
        Navigator.pop(context);
      }
    });
  }
}
