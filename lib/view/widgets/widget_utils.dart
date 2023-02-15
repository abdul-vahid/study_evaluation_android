import 'package:flutter/material.dart';
import '../../utils/app_color.dart';

class WidgetUtils {
  static List<Widget> getTabs(List<String> tabTitles) {
    List<Widget> tabs = [];
    for (var element in tabTitles) {
      tabs.add(getTab(element));
    }
    return tabs;
  }

  static Widget getTab(String tabTitle) {
    return Tab(text: tabTitle);
  }

  static Widget getTabBar(TabController? tabController) {
    return TabBar(
      //unselectedLabelColor: Colors.white,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.black,
      indicatorColor: AppColor.buttonColor,
      indicatorWeight: 2,
      indicator: BoxDecoration(
        color: Color(0xFF009DDC),
        borderRadius: BorderRadius.circular(30),
      ),
      controller: tabController,
      tabs: WidgetUtils.getTabs(["Login", "Registration"]),
    );
  }

  static Widget getLoginImageContainer(String imagePath,
      {double? width = 100, double? height = 100, double topMargin = 100}) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(top: topMargin),
      child: Center(
        child: getClipRectImage(imagePath, radius: 10.0),
      ),
    );
  }

  static Widget getClipRectImage(String imagePath,
      {radius, fitType = BoxFit.contain}) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(
          imagePath,
          fit: fitType,
        ));
  }

  static Widget getTabview(tabController, tabPages) {
    return TabBarView(controller: tabController, children: tabPages);
  }

  static Widget getExpanded(Widget child) {
    return Expanded(child: child);
  }

  // TextFormField

  static Widget getTextFormField(
      String labelText, String hintText, IconData iconData,
      {controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Icon(iconData, color: AppColor.iconColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          labelText: labelText,
          hintText: hintText),
    );
  }

  //Button

  static Widget getButton(String label,
      {callback = null,
      borderRadious = 25.0,
      horizontalPadding = 40.0,
      verticalPadding = 18.0,
      width = 345,
      height = 50}) {
    return Container(
        height: 50,
        width: 345,
        decoration: BoxDecoration(
            //  color: Color(0xFF009DDC),
            borderRadius: BorderRadius.circular(borderRadious)),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.buttonColor,
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 18.0),
            shape: const StadiumBorder(),
          ),
          onPressed: callback,
          child: Text(label),
        ));
  }

  static Widget getCard(
      String lable, String imagePath, void Function(dynamic) voidCallback,
      {imageHeight = 100.0, fontSize = 15.0}) {
    return Card(
      color: AppColor.boxColor,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      margin: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          voidCallback(15);
        },
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text(
              lable,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: AppColor.textColor,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Image.asset(
              imagePath,
              height: imageHeight,
            ),
            // Icon(
            //   iconData,
            //   size: 50.0,
            //   color: Colors.blue,
            // ),
          ]),
        ),
      ),
    );
  }
}
