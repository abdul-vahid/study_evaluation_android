import 'package:flutter/material.dart';

abstract class AppColor {
  //int.fromEnvironment("APP_PRIMARY_COLOR", defaultValue: 0xFF000CCC);
  static final Color primaryColor = Color(0xFF009DDC);
  static final Color buttonColor = Color(0xFF009DDC);
  static final Color textColor = Color(0xFF009DDC);
  static final Color appBarColor = Color(0xFF009DDC);
  static final Color navBarIconColor = Color(0xFF009DDC);
  static final Color boxColor = Color(0xFFF8FAFF);
  static final Color iconColor = Colors.grey.shade600;
  static final Color motivationCar1Color = Color(0xFFFF2C55);
  static final Color selectedItemColor = Color.fromARGB(255, 228, 234, 60);
  static final Color containerBoxColor = Color(0xFF009DDC);
  static TextStyle themeNormal = TextStyle(color: Colors.black);
  static TextStyle themeBold =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  //static Color APP_COLOR = Color(0xFFce0e2d);
  static Color darwerHeader = Color(0xFFffffee);
  static Color accentColor = Color(0xFFffffdd);
  static Color greenColor = Color(0xFFf1ffe8);
  static Color greyColor = Color(0xFFf7f4f4);
  static Color tabBGColor = Colors.white;
  static Color tabLabelColor = Colors.black;
  static Color tabIndicatorColor = accentColor;
  static Color commentBGColor = accentColor;
  static Color menuIconColor = appBarColor;

  final cardDecoration = BoxDecoration(
    color: accentColor,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(4),
  );

  //int.fromEnvironment("APP_ICON_COLOR", defaultValue: 0xFF009CCC);
}
