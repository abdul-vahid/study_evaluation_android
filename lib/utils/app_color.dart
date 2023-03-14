import 'package:flutter/material.dart';

abstract class AppColor {
  //int.fromEnvironment("APP_PRIMARY_COLOR", defaultValue: 0xFF000CCC);
  static const Color primaryColor = Color(0xFF009DDC);
  static const Color buttonColor = Color(0xFF009DDC);
  static const Color textColor = Color(0xFF009DDC);
  static const Color appBarColor = Color(0xFF009DDC);
  static const Color navBarIconColor = Color(0xFF009DDC);
  static const Color boxColor = Color(0xFFF8FAFF);
  static final Color iconColor = Colors.grey.shade600;
  static const Color motivationCar1Color = Color(0xFFFF2C55);
  static const Color selectedItemColor = Color.fromARGB(255, 247, 255, 6);
  static const Color containerBoxColor = Color(0xFF009DDC);
  static const TextStyle themeNormal = TextStyle(color: Colors.black);
  static const TextStyle themeBold =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  //static Color APP_COLOR = Color(0xFFce0e2d);
  static const Color darwerHeader = Color(0xFFffffee);
  static const Color accentColor = Color(0xFFffffdd);
  static const Color greenColor = Color(0xFFf1ffe8);
  static const Color greyColor = Color(0xFFf7f4f4);
  static const Color tabBGColor = Colors.white;
  static const Color tabLabelColor = Colors.black;
  static const Color tabIndicatorColor = accentColor;
  static const Color commentBGColor = accentColor;
  static const Color menuIconColor = appBarColor;

  final cardDecoration = BoxDecoration(
    color: accentColor,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(4),
  );

  //int.fromEnvironment("APP_ICON_COLOR", defaultValue: 0xFF009CCC);
}
