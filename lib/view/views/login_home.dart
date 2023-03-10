import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/login_view.dart';
import 'package:study_evaluation/view/views/signup_view.dart';
import 'package:study_evaluation/view/widgets/widget_utils.dart';
import '../../utils/app_color.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      color: AppColor.primaryColor,
      child: Column(
        children: [
          Container(
            height: 100,
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WidgetUtils.getLoginImageContainer("assets/images/logo.png"),
                  const SizedBox(
                    height: 10,
                  ),
                  _getTabContainer(context),
                ],
              ),
            ),
          ),
        ],
      ),
    )));
  }

  Container _getTabContainer(BuildContext context) {
    return Container(
      // height: 440,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                // height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: const Color(0xFFfef5e6),
                    borderRadius: BorderRadius.circular(30)),
                child: _getTabBarColumns(),
              ),

              WidgetUtils.getExpanded(WidgetUtils.getTabview(tabController,
                  [const LoginView(), const SignupView()])) //Adding Tabs
            ],
          ),
        ),
      ),
    );
  }

  Column _getTabBarColumns() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: WidgetUtils.getTabBar(tabController),
        ),
      ],
    );
  }
}
