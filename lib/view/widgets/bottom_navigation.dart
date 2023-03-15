import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_utils.dart';

Widget getBottomNavigation(selectedIndex, {Function(int)? onItemTap}) =>
    BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        _barItem('Home', Icons.home),
        _barItem('Test Series', Icons.edit_note),
        _barItem('My Order', Icons.shopping_cart),
        _barItem('Notifications', Icons.notifications),
        _barItem('Profile', Icons.person),
      ],
      currentIndex: selectedIndex,
      //iconSize: 10,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColor.appBarColor,
      selectedItemColor: AppColor.selectedItemColor,
      onTap: onItemTap,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );

BottomNavigationBarItem _barItem(String label, IconData iconData,
    {Color? backgroundColor}) {
  return BottomNavigationBarItem(
    icon: label == "Notifications"
        ? AppUtils.notificationCount > 0
            ? _getNotifcationIcon(AppUtils.notificationCount)
            : const Icon(Icons.notifications)
        : Icon(
            iconData,
          ),
    label: label,
    backgroundColor: backgroundColor ?? AppColor.appBarColor,
  );
}

_getNotifcationIcon(counter) {
  return Stack(
    children: <Widget>[
      const Icon(Icons.notifications),
      Positioned(
        right: 11,
        top: 11,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(6),
          ),
          constraints: const BoxConstraints(
            minWidth: 14,
            minHeight: 14,
          ),
          child: Text(
            '$counter',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 8,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}
