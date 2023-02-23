import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/view/views/login_screen.dart';
import 'package:study_evaluation/view/views/registration_screen.dart';
import 'package:study_evaluation/view/widgets/widget_utils.dart';
import 'package:study_evaluation/view_models/result_view_model/role_list_vm.dart';
import '../../utils/app_color.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  var roleListVM;
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
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      color: AppColor.primaryColor,
      child: Column(
        children: [
          Container(
            height: 100,
            // color: Color(AppConstants.primaryColorApp),
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
        padding: EdgeInsets.all(1),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                // height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Color(0xFFfef5e6),
                    borderRadius: BorderRadius.circular(30)),
                child: _getTabBarColumns(),
              ),

              WidgetUtils.getExpanded(WidgetUtils.getTabview(tabController, [
                const LoginScreen(),
                MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => RoleListViewModel()),
                  ],
                  child: RegistrationScreen(),
                ),
                //RegistrationScreen(roleListVM)
              ])) //Adding Tabs
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
          padding: EdgeInsets.all(0),
          child: WidgetUtils.getTabBar(tabController),
        ),
      ],
    );
  }
}
