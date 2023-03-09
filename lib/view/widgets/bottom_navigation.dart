import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/app_color.dart';

Widget getBottomNavigation(selectedIndex, {Function(int)? onItemTap}) =>
    BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        _barItem('Home', Icons.home),
        _barItem('My Test', Icons.text_snippet_outlined),
        _barItem('My Order', Icons.ramen_dining),
        _barItem('Profile', Icons.person),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: AppColor.selectedItemColor,
      onTap: onItemTap,
    );

BottomNavigationBarItem _barItem(String label, IconData iconData,
    {Color? backgroundColor}) {
  return BottomNavigationBarItem(
    icon: Icon(
      iconData,
    ),
    label: label,
    backgroundColor: backgroundColor ?? AppColor.appBarColor,
  );
}
