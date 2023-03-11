import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_utils.dart';

Widget getBottomNavigation(selectedIndex, {Function(int)? onItemTap}) =>
    BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        _barItem('Home', Icons.home),
        _barItem('Test Series', Icons.text_snippet_outlined),
        _barItem('My Order', Icons.ramen_dining),
        _barItem('Notifications', Icons.notifications),
        _barItem('Profile', Icons.person),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: AppColor.selectedItemColor,
      onTap: onItemTap,
    );

BottomNavigationBarItem _barItem(String label, IconData iconData,
    {Color? backgroundColor}) {
  return BottomNavigationBarItem(
    icon: label == "Notifications"
        ? _getNotifcationIcon(AppUtils.notificationCount)
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
      counter != 0
          ? Positioned(
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
          : Container()
    ],
  );
}
