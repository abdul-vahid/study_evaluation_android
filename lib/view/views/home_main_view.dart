import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/category_list_view.dart';
import 'package:study_evaluation/view/views/myorder_view.dart';
import 'package:study_evaluation/view/views/notifications_view.dart';
import 'package:study_evaluation/view/views/profile_view.dart';
import 'package:study_evaluation/view_models/notifications_list_vm.dart';
import '../widgets/bottom_navigation.dart' as bottom_navi_widget;
import 'package:study_evaluation/view/views/home_view.dart';

class HomeMainView extends StatefulWidget {
  int? selectedIndex = 0;
  HomeMainView({super.key, this.selectedIndex});

  @override
  State<HomeMainView> createState() => _HomeMainViewState();
}

class _HomeMainViewState extends State<HomeMainView> {
  int _selectedIndex = 0;
  var ctime;
  var baseListViewModel;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget>? _widgetOptions;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex ?? 0;
    Provider.of<NotificationsListViewModel>(context, listen: false).fetch();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      AppUtils.printDebug("_selected = $_selectedIndex");
    });
  }

  int getNewNotficationCount(viewModels) {
    int count = 0;
    for (var vm in viewModels) {
      if (vm.model.status.toLowerCase() == "unread") {
        count++;
      }
    }
    print("Total $count");
    return count;
  }

  @override
  Widget build(BuildContext context) {
    baseListViewModel = Provider.of<NotificationsListViewModel>(context);
    int newNotifcationCount =
        getNewNotficationCount(baseListViewModel?.viewModels);
    AppUtils.notificationCount = baseListViewModel?.viewModels.length;
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
}
