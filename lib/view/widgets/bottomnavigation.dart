import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/view/views/aboutus_view.dart';
import 'package:study_evaluation/view/views/follow_us_view.dart';
import 'package:study_evaluation/view/views/home_view.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    AboutUsScreen(),
    FollowUsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.task_sharp,
            ),
            label: 'My Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.touch_app,
            ),
            label: 'Follow Us',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.feedback,
          //   ),
          //   label: 'Feedback',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
