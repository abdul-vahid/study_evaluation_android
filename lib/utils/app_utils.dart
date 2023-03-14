import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/home_tiles_model.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/view/views/home_main_view.dart';
import 'package:study_evaluation/view/views/login_home.dart';
import 'package:study_evaluation/view_models/category_list_vm.dart';
import 'package:study_evaluation/view_models/cofiguration_list_vm.dart';
import 'package:study_evaluation/view_models/feedback_list_vm.dart';
import 'package:study_evaluation/view_models/notifications_list_vm.dart';
import 'package:study_evaluation/view_models/order_list_vm.dart';
import 'package:study_evaluation/view_models/slider_image_list_vm.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static bool isLoggedout = false;
  static int notificationCount = 0;
  static BuildContext? currentContext;
  static void onLoading(BuildContext? context, String? label) {
    showDialog(
        context: context!,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  Text(
                    label!,
                  )
                ],
              ),
            ),
          );
        });
  }

  static List<Widget> _getTextWidgets(List<String> values) {
    List<Widget> widgets = [];
    for (var value in values) {
      widgets.add(Text(
        value,
        style: AppColor.themeNormal,
      ));
    }
    return widgets;
  }

  static getAlert(BuildContext context, List<String> values,
      {title = "", buttonLabel = 'OK', void Function()? onPressed}) {
    AppUtils.printDebug("getAlert");
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: AppColor.themeNormal,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: _getTextWidgets(values),
            ),
          ),
          actions: [
            TextButton(
              onPressed: onPressed ?? () => _onPressed(context),
              child: Text(buttonLabel, style: AppColor.themeNormal),
            ),
          ],
        );
      },
    );
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefsConstants.accessTokenKey);
  }

  static String getAccessToken(prefs) {
    return prefs.getString(SharedPrefsConstants.accessTokenKey);
  }

  static UserModel getSessionUser(SharedPreferences prefs) {
    return UserModel.fromMap(
        jsonDecode(prefs.getString(SharedPrefsConstants.userKey)!));
  }

  static ElevatedButton getElevatedButton(btnLabel,
      {required void Function()? onPressed, buttonStyle, textStyle}) {
    return ElevatedButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: Text(btnLabel, style: textStyle),
    );
  }

  static showAlertDialog(BuildContext context, String title, String text) {
    Widget okButton = TextButton(
      child: const Text('Ok', style: AppColor.themeNormal),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        style: AppColor.themeNormal,
      ),
      content: Text(
        text,
        style: AppColor.themeNormal,
      ),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void printDebug(message) {
    if (AppConstants.kDebugMode) {
      print(message);
    }
  }

  static List<String> getErrorMessages(exception) {
    //print("exception ");
    List<String> errorMessages = [];
    if (exception is AppException) {
      Map<String, dynamic> data = jsonDecode(exception.getMessage());
      data.forEach((key, value) {
        errorMessages.add(value);
        isLoggedout = value.toString().toLowerCase() == "expired token";
      });
    } else {
      errorMessages.add(exception.toString());
    }

    return errorMessages;
  }

  static AppBar getAppbar(String title,
      {bottom, List<Widget>? actions, Widget? leading}) {
    return AppBar(
        centerTitle: true,
        leading: leading, //= const BackButton(color: Colors.white)
        title: Text(title),
        elevation: .1,
        backgroundColor: AppColor.appBarColor,
        bottom: bottom,
        actions: actions);
  }

  static List<HomeTilesModel> getHomeTilesModels() {
    List<HomeTilesModel> homeTilesModels = [];
    homeTilesModels.add(HomeTilesModel(
        title: "Test Series", imagePath: "assets/images/test-series.png"));
    homeTilesModels.add(HomeTilesModel(
        title: "Recorded Courses", imagePath: "assets/images/course.png"));
    homeTilesModels.add(HomeTilesModel(
        title: "Combo Package", imagePath: "assets/images/combo-package.png"));
    homeTilesModels.add(HomeTilesModel(
        title: "Live Course", imagePath: "assets/images/live-courses.png"));
    homeTilesModels.add(HomeTilesModel(
        title: "Free Content", imagePath: "assets/images/free-content.png"));
    homeTilesModels.add(HomeTilesModel(
        title: "Latest Exam", imagePath: "assets/images/exam-news.png"));

    return homeTilesModels;
  }

  static Widget getErrorWidget(model) {
    List<String> errorMessages = [];
    String errorMessage = "";
    if (model!.appException != null) {
      errorMessages = AppUtils.getErrorMessages(model!.appException);
    } else {
      errorMessage = model!.error.toString();
    }

    return errorMessages.isNotEmpty
        ? Center(
            child: Column(
            children: [for (var message in errorMessages) Text(message)],
          ))
        : Center(child: Text(errorMessage));
  }

  static Widget getAppBody(
      BaseListViewModel baseListViewModel, Widget Function() callBack,
      {context}) {
    if (baseListViewModel.status == "Loading") {
      return AppUtils.getLoader();
    } else if (baseListViewModel.status == "Error") {
      Widget widget =
          AppUtils.getErrorWidget(baseListViewModel.viewModels[0].model);
      Timer(Duration.zero, () {
        isLoggedOut(context);
      });
      return widget;
    } else if (baseListViewModel.viewModels.isNotEmpty) {
      return callBack();
    } else {
      return AppUtils.getNoRecordWidget();
    }
  }

  static Center getLoader() => const Center(child: CircularProgressIndicator());
  static Center getNoRecordWidget({message = "No Records Found!"}) =>
      Center(child: Text(message));

  static String getImageUrl(logoUrl) {
    return '${AppConstants.baseUrl}${AppConstants.imagePath}/$logoUrl';
  }

  static void viewPush(BuildContext context, Widget view) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => view),
    );
  }

  static String getUrl(String path) {
    return AppConstants.baseUrl + path;
  }

  static void onError(BuildContext context, error, {title = "Error Alert"}) {
    Navigator.pop(context);

    List<String> errorMessages = AppUtils.getErrorMessages(error);
    getAlert(context, errorMessages, title: title);
  }

  static _onPressed(context) {
    Navigator.of(context).pop();
  }

  static Html getHtmlData(data, {fontFamily = '', double fontSize = 15.0}) {
    return Html(
        data: data,
        style: {
          "span": Style(fontFamily: fontFamily),
          "body, span, p, font, div": Style(fontSize: FontSize(fontSize))
        },
        customRender: {
          "o:p": (RenderContext context, Widget child) {
            return const TextSpan(text: "\\");
          },
        },
        tagsList: Html.tags..addAll(["o:p"]));
  }

  static String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }
    return string[0].toUpperCase() + string.substring(1);
  }

  static void logout(context) {
    onLoading(context, "Logging out...");
    SharedPreferences.getInstance().then((prefs) {
      prefs.clear();
      Navigator.pop(context);
      viewPush(context, const LoginHome());
    });
  }

  static void isLoggedOut(context) {
    if (isLoggedout) {
      logout(context);
    }
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static Future<Object?> launchTab(BuildContext context,
      {selectedIndex = 0}) async {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (_) => CategoryListViewModel()),
                    ChangeNotifierProvider(
                        create: (_) => SliderImageListViewModel()),
                    ChangeNotifierProvider(
                        create: (_) => FeedbackListViewModel()),
                    ChangeNotifierProvider(
                        create: (_) => ConfigurationListViewModel()),
                    ChangeNotifierProvider(create: (_) => OrderListViewModel()),
                    ChangeNotifierProvider(
                        create: (_) => CategoryListViewModel()),
                    ChangeNotifierProvider(
                        create: (_) => NotificationsListViewModel())
                  ],
                  child: HomeMainView(
                    selectedIndex: selectedIndex,
                  ),
                )),
        (Route<dynamic> route) => false);
  }

  static Future<dynamic> getSimpleDialog(BuildContext context,
      {required String title, List<Widget>? children}) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (
          BuildContext context,
        ) {
          return SimpleDialog(
            //   shape: EdgeInsets.all(value),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: Center(child: Text(title)),
            children: children,
          );
        });
  }
}
