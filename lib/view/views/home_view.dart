// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/controller/home_controller.dart';
import 'package:study_evaluation/models/configuration_model.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/utils/notification_utils.dart';
import 'package:study_evaluation/view/views/currentaffairs_screen.dart';
import 'package:study_evaluation/view/views/motivation.dart';
import 'package:study_evaluation/view/views/testseries.dart';
import 'package:study_evaluation/view/widgets/app_drawer_widget.dart';
import 'package:study_evaluation/view_models/category_list_vm.dart';
import 'package:study_evaluation/view_models/current_affairs_list_vm.dart';
import 'package:study_evaluation/view_models/feedback_list_vm.dart';
import 'package:study_evaluation/view_models/quote_list_vm.dart';
import 'package:study_evaluation/view_models/slider_image_list_vm.dart';
import 'package:study_evaluation/view_models/user_view_model/user_list_vm.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/app_color.dart';

class HomeView extends StatefulWidget {
  final categoriesVM;
  final slidersVM;
  final feedbacksVM;
  final configListViewModel;

  const HomeView(
      {super.key,
      this.categoriesVM,
      this.slidersVM,
      this.feedbacksVM,
      this.configListViewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserListViewModel userListViewModel = UserListViewModel();
  int _selectedIndex = 0;
  int counter = 0;
  String helpLineNumber = "";
  CategoryListViewModel? categoriesVM;
  SliderImageListViewModel? slidersVM;
  FeedbackListViewModel? feedbacksVM;
  FeedbackListViewModel? configListViewModel;
  var ctime;
  @override
  void initState() {
    NotificationUtil.initialize(context);
    categoriesVM = widget.categoriesVM;
    slidersVM = widget.slidersVM;
    feedbacksVM = widget.feedbacksVM;
    /* configListViewModel = widget.configListViewModel;
    if ((configListViewModel != null &&
        (configListViewModel?.viewModels.isNotEmpty)!)) {
      ConfigurationModel configModel = configListViewModel?.viewModels[0];
      AppUtils.printDebug(jsonEncode(configModel));
      if (!configModel.isError) {
        helpLineNumber = (configModel.helpLineNumber)!;
      }
    } */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController(context, feedbacksVM!);
    return Scaffold(
      drawer: const AppDrawerWidget(),
      appBar: AppBar(
        title: Center(child: Text("Home")),
        actions: <Widget>[
          // Using Stack to show Notification Badge
          Stack(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    setState(() {
                      counter = 3;
                    });
                  }),
              counter != 0
                  ? Positioned(
                      right: 11,
                      top: 11,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          '$counter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ],
      ),
      body: _getBody(context, homeController),
    );
  }

  WillPopScope _getBody(BuildContext context, HomeController homeController) {
    AppUtils.isLoggedOut(context);
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (ctime == null ||
            now.difference(ctime) > const Duration(seconds: 2)) {
          //add duration of press gap
          ctime = now;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'Press Back Button Again to Exit'))); //scaffold message, you can show Toast message too.
          return Future.value(false);
        }

        return Future.value(true);
      },
      child: SingleChildScrollView(
          child: Column(
        children: [
          homeController.getImageSlideshowContainer(slidersVM!),
          const SizedBox(
            height: 10,
          ),
          _getButtonContainer(),
          homeController.getHomeTiles(),
          // SizedBox(
          //   height: 10,
          // ),
          _studentFeedbackHeading(),
          // SizedBox(
          //   height: 5,
          // ),
          homeController.getFeedbackSlideshowContainer(),
          const SizedBox(
            height: 10,
          ),
          _footer(),
          const SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }

  InkWell _footer() {
    return _getHelpLineNumberWidget();
  }

  InkWell _getHelpLineNumberWidget() {
    return InkWell(
      onTap: () {
        if (helpLineNumber.isNotEmpty) {
          AppUtils.makePhoneCall(helpLineNumber);
        }
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 6.0),
              height: 36.0,
              decoration: BoxDecoration(
                color: AppColor.buttonColor,
                borderRadius: BorderRadius.circular(10.0),
                //boxShadow: [BoxShadow(blurRadius: 12.0)],
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(55.0, 10.0, 10.0, 0.0),
                child: Text(
                  'Helpline No. $helpLineNumber',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 2.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                //boxShadow: [BoxShadow(blurRadius: 12.0)],
                border: Border.all(color: AppColor.buttonColor, width: 2),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.wifi_calling_3,
                  color: AppColor.buttonColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _getButtonContainer() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          getButton('Motivation', onButtonPressed),
          getButton('Current Affairs', onCurrentAffairs),
        ],
      ),
    );
  }

  Column _studentFeedbackHeading() {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        const ListTile(
          // leading: Icon(Icons.album),
          title: Text(
            'Student Feedback',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 9, 48, 67),
            ),
          ),
        ),
      ],
    );
  }

  Container getButton(String label, VoidCallback callback) {
    return Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
            color: Color.fromARGB(202, 156, 212, 245),
            borderRadius: BorderRadius.circular(25)),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
          ),
          child: Text(label),
          onPressed: () {
            callback();
          },
        ));
  }

  void onTestSeries() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TestSeriesScreen()),
    );
    print("Login Button pressed!!!");
  }

  void onButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (_) => QuoteListViewModel())
                ],
                child: const MotivationScreen(),
              )),
    );
    print("Login Button pressed!!!");
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onCurrentAffairs() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                      create: (_) => CurrentAffairsListViewModel())
                ],
                child: const CurrentAffairScreen(),
              )),
    );
    print("Login Button pressed!!!");
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
