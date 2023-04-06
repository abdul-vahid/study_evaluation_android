// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/controller/home_controller.dart';
import 'package:study_evaluation/models/configuration_model.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/utils/notification_utils.dart';
import 'package:study_evaluation/view/views/current_affairs_view.dart';
import 'package:study_evaluation/view/views/motivation_view.dart';
import 'package:study_evaluation/view/widgets/app_drawer_widget.dart';
import 'package:study_evaluation/view_models/category_list_vm.dart';
import 'package:study_evaluation/view_models/cofiguration_list_vm.dart';
import 'package:study_evaluation/view_models/current_affairs_list_vm.dart';
import 'package:study_evaluation/view_models/feedback_list_vm.dart';
import 'package:study_evaluation/view_models/quote_list_vm.dart';
import 'package:study_evaluation/view_models/slider_image_list_vm.dart';
import 'package:study_evaluation/view_models/user_view_model/user_list_vm.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../utils/app_color.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserListViewModel userListViewModel = UserListViewModel();
  int counter = 0;
  String helpLineNumber = "";
  CategoryListViewModel? categoriesVM;
  SliderImageListViewModel? slidersVM;
  FeedbackListViewModel? feedbacksVM;
  ConfigurationListViewModel? configListViewModel;
  bool isRefresh = false;
  var ctime;
  @override
  void initState() {
    NotificationUtil().initialize(context);
    Provider.of<CategoryListViewModel>(context, listen: false).fetch();
    Provider.of<SliderImageListViewModel>(context, listen: false).fetch();
    Provider.of<FeedbackListViewModel>(context, listen: false).fetch();
    Provider.of<ConfigurationListViewModel>(context, listen: false).fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    categoriesVM = Provider.of<CategoryListViewModel>(context);
    slidersVM = Provider.of<SliderImageListViewModel>(context);
    feedbacksVM = Provider.of<FeedbackListViewModel>(context);
    configListViewModel = Provider.of<ConfigurationListViewModel>(context);

    if ((configListViewModel != null &&
        (configListViewModel?.viewModels.isNotEmpty)!)) {
      ConfigurationModel configModel =
          configListViewModel?.viewModels[0].model as ConfigurationModel;

      if (!configModel.isError) {
        if (isRefresh) {
          Navigator.pop(context);
          isRefresh = false;
        }
        helpLineNumber = (configModel.helpLineNumber)!;
      }
    }
    HomeController homeController = HomeController(context, feedbacksVM!);
    return Scaffold(
      drawer: const AppDrawerWidget(),
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: AppColor.appBarColor,
        centerTitle: true,
      ),
      body: RefreshIndicator(
          onRefresh: _pullRefresh, child: _getBody(context, homeController)),
    );
  }

  Future<void> _pullRefresh() async {
    categoriesVM?.viewModels.clear();
    slidersVM?.viewModels.clear();
    feedbacksVM?.viewModels.clear();
    configListViewModel?.viewModels.clear();

    AppUtils.onLoading(context, "Refreshing");
    Provider.of<CategoryListViewModel>(context, listen: false).fetch();
    Provider.of<SliderImageListViewModel>(context, listen: false).fetch();
    Provider.of<FeedbackListViewModel>(context, listen: false).fetch();
    Provider.of<ConfigurationListViewModel>(context, listen: false).fetch();

    categoriesVM = Provider.of<CategoryListViewModel>(context, listen: false);
    slidersVM = Provider.of<SliderImageListViewModel>(context, listen: false);
    feedbacksVM = Provider.of<FeedbackListViewModel>(context, listen: false);
    configListViewModel =
        Provider.of<ConfigurationListViewModel>(context, listen: false);

    isRefresh = true;
  }

  Widget _getBody(BuildContext context, HomeController homeController) {
    AppUtils.isLoggedOut(context);
    return SingleChildScrollView(
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
    ));
  }

  Padding _footer() {
    return _getHelpLineNumberWidget();
  }

  Padding _getHelpLineNumberWidget() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
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
                    margin: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 6.0),
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
          ),
          InkWell(
            onTap: () async {
              final url =
                  'https://wa.me/$helpLineNumber?text=Hello SE Team, We need your help!';

              await launchUrlString(
                url,
                mode: LaunchMode.externalApplication,
              );
            },
            child: Container(
              // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 6.0),
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                      //boxShadow: [BoxShadow(blurRadius: 12.0)],
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(55.0, 10.0, 10.0, 0.0),
                      child: Text(
                        'Whatsapp',
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
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/images/whatsapp.png',
                        height: 25,
                        width: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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

  void onButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (_) => QuoteListViewModel())
                ],
                child: const MotivationView(),
              )),
    );
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
                child: const CurrentAffairsView(),
              )),
    );
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
