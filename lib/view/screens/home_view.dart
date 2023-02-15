import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:study_evaluation/controller/home_controller.dart';
import 'package:study_evaluation/view/screens/currentaffairs_screen.dart';
import 'package:study_evaluation/view/screens/motivation.dart';
import 'package:study_evaluation/view/screens/testseries.dart';

import '../../utils/app_color.dart';
import '../widgets/sidebar.dart';
import '../widgets/widget_utils.dart';

class HomeView extends StatefulWidget {
  final categoriesVM;
  final slidersVM;
  final feedbacksVM;

  const HomeView(
      {super.key, this.categoriesVM, this.slidersVM, this.feedbacksVM});

  @override
  State<HomeView> createState() =>
      _HomeViewState(categoriesVM, slidersVM, feedbacksVM);
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  final categoriesVM;
  final slidersVM;
  final feedbacksVM;
  _HomeViewState(this.categoriesVM, this.slidersVM, this.feedbacksVM);
  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController(context, feedbacksVM);
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          homeController.getImageSlideshowContainer(slidersVM),
          const SizedBox(
            height: 10,
          ),
          getButtonContainer(),
          homeController.getTestSeries(categoriesVM),
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
          Container(
            height: 40,
            color: AppColor.containerBoxColor,
          )
        ],
      )),
    );
  }

  Container _footer() {
    return Container(
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
    );
  }

  Container getStudentFeedbacks(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 5.0, right: 10.0, top: 2.0),
        height: 200,
        child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            initialPage: 0,
            //  indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            children: [
              Container(
                //color: Colors.amber,
                width: 350,
                height: 220,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(blurRadius: 1.0, color: Colors.grey.shade100)
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),

                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    //borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        //padding: EdgeInsets.only(top: 0),
                        margin: const EdgeInsets.only(bottom: 100, left: 10),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            scale: 5,
                            image:
                                AssetImage("assets/images/profile-image.png"),
                            fit: BoxFit.fill,
                          ),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 4),
                            child: const ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text("Gaurav Sharma",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        letterSpacing: 1)),
                              ),
                              subtitle: Text(
                                "Paragraphs are the building blocks of papers. Many students define paragraphs in terms of length: a paragraph is a group of at least five sentences, a paragraph is half a page long, etc. In reality, though.",
                                style: TextStyle(fontSize: 17),
                                maxLines: 4,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 150),
                            child: Row(
                              children: [
                                Align(
                                  child: TextButton.icon(
                                    // <-- TextButton
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.share,
                                      size: 20.0,
                                    ),
                                    label: Text('SHARE'),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                    ],
                  ),
                ),
              ),
              Container(
                //color: Colors.amber,
                width: 350,
                height: 220,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(blurRadius: 1.0, color: Colors.grey.shade100)
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),

                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    //borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        //padding: EdgeInsets.only(top: 0),
                        margin: EdgeInsets.only(bottom: 100, left: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            scale: 5,
                            image:
                                AssetImage("assets/images/profile-image.png"),
                            fit: BoxFit.fill,
                          ),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 4),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text("Gaurav Sharma",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        letterSpacing: 1)),
                              ),
                              subtitle: Text(
                                "Paragraphs are the building blocks of papers. Many students define paragraphs in terms of length: a paragraph is a group of at least five sentences, a paragraph is half a page long, etc. In reality, though.",
                                style: TextStyle(fontSize: 17),
                                maxLines: 4,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 150),
                            child: Row(
                              children: [
                                Align(
                                  child: TextButton.icon(
                                    // <-- TextButton
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.share,
                                      size: 20.0,
                                    ),
                                    label: Text('SHARE'),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ]));
  }

  Container getButtonContainer() {
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
      MaterialPageRoute(builder: (context) => const MotivationScreen()),
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
      MaterialPageRoute(builder: (context) => const CurrentAffairScreen()),
    );
    print("Login Button pressed!!!");
  }
}
