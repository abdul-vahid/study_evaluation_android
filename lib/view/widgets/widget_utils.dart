import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/enum.dart';
import '../../utils/app_color.dart';
import '../../utils/function_lib.dart';

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
      {controller,
      void Function(String?)? onSaved,
      String? Function(String?)? onValidator,
      bool obscureText = false,
      String? initialValue,
      TextInputType? keyboardType}) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      onSaved: onSaved,
      validator: onValidator,
      initialValue: initialValue,
      decoration: InputDecoration(
          prefixIcon: Icon(iconData, color: AppColor.iconColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          labelText: labelText,
          hintText: hintText),
    );
  }

  static Widget getTextFormFieldPassword(
      String labelText, String hintText, IconData iconData,
      {controller,
      void Function(String?)? onSaved,
      String? Function(String?)? onValidator,
      bool obscureText = false,
      String? initialValue,
      TextInputType? keyboardType,
      Widget? suffix}) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      onSaved: onSaved,
      validator: onValidator,
      initialValue: initialValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        prefixIcon: Icon(iconData, color: AppColor.iconColor),
        isDense: false,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 10.0,
          minHeight: 10.0,
        ),
        suffixIcon: suffix,
        labelText: labelText,
        hintText: hintText,
      ),
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
      {imageHeight = 120.0,
      fontSize = 14.0,
      imageType = ImageType.assets,
      data}) {
    return Card(
      color: AppColor.boxColor,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      margin: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          voidCallback(data);
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
            _getImage(imagePath, imageType, imageHeight: imageHeight),
          ]),
        ),
      ),
    );
  }

  static Widget _getImage(url, imageType, {imageHeight}) {
    // debug('url @@@@@ $url');
    if (imageType == ImageType.assets) {
      return Image.asset(
        url,
        height: imageHeight,
      );
    } else {
      return FadeInImage.assetNetwork(
        placeholder: "assets/images/loading.gif",
        image: url,
        height: imageHeight,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/no_image.png',
            height: 70,
            width: 70,
          );
        },
      );
    }
  }
}
