import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/controller/home_controller.dart';
import 'package:study_evaluation/utils/app_utils.dart';
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

  const HomeView(
      {super.key, this.categoriesVM, this.slidersVM, this.feedbacksVM});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserListViewModel userListViewModel = UserListViewModel();
  int _selectedIndex = 0;
  CategoryListViewModel? categoriesVM;
  SliderImageListViewModel? slidersVM;
  FeedbackListViewModel? feedbacksVM;
  var ctime;
  @override
  void initState() {
    //  Provider.of<UserListViewModel>(context, listen: false).login('raj@gmail.com', 'test@1234');
    super.initState();
    categoriesVM = widget.categoriesVM;
    slidersVM = widget.slidersVM;
    feedbacksVM = widget.feedbacksVM;
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController(context, feedbacksVM!);
    return Scaffold(
      drawer: const AppDrawerWidget(),
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        centerTitle: true,
        title: const Text('Home'),
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
    return InkWell(
      onTap: () {
        launch("tel:0987654321");
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
              child: const Padding(
                padding: EdgeInsets.fromLTRB(55.0, 10.0, 10.0, 0.0),
                child: Text(
                  'Helpline No. 0987654321',
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
