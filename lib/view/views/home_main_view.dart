import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_model.dart';
import 'package:study_evaluation/models/notification_model.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/category_list_view.dart';
import 'package:study_evaluation/view/views/myorder_view.dart';
import 'package:study_evaluation/view/views/notifications_view.dart';
import 'package:study_evaluation/view/views/profile_view.dart';
import 'package:study_evaluation/view_models/notifications_list_vm.dart';
import '../widgets/bottom_navigation.dart' as bottom_navi_widget;
import 'package:study_evaluation/view/views/home_view.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomeMainView extends StatefulWidget {
  int? selectedIndex = 0;
  HomeMainView({super.key, this.selectedIndex});

  @override
  State<HomeMainView> createState() => _HomeMainViewState();
}

class _HomeMainViewState extends State<HomeMainView> {
  int _selectedIndex = 0;
  var ctime;
  BaseListViewModel? baseListViewModel;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget>? _widgetOptions;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  late StreamSubscription subscription;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      var userModel = AppUtils.getSessionUser(prefs);
      userModel ?? AppUtils.logout(context);
    });
    getConnectivity();

    _selectedIndex = widget.selectedIndex ?? 0;
    Provider.of<NotificationsListViewModel>(context, listen: false).fetch();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int getNewNotficationCount(viewModels) {
    int count = 0;
    for (var vm in viewModels) {
      NotificationModel model = vm.model as NotificationModel;
      if (model.status?.toLowerCase() == "unread") {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    baseListViewModel = Provider.of<NotificationsListViewModel>(context);
    if (!(baseListViewModel?.isError)!) {
      int newNotifcationCount =
          getNewNotficationCount(baseListViewModel?.viewModels);
      AppUtils.notificationCount = newNotifcationCount;
    }

    _initTabs();
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          body: Center(
            child: _widgetOptions?.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: bottom_navi_widget
              .getBottomNavigation(_selectedIndex, onItemTap: _onItemTapped),
        ));
  }

  void _initTabs() {
    _widgetOptions = <Widget>[
      const HomeView(),
      const CategoryListView(),
      const MyOrderView(),
      const NotificationView(),
      const ProfileView()
    ];
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (ctime == null || now.difference(ctime) > const Duration(seconds: 2)) {
      //add duration of press gap
      ctime = now;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Press Back Button Again to Exit'))); //scaffold message, you can show Toast message too.
      return Future.value(false);
    }

    return Future.value(true);
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
