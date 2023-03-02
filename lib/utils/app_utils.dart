import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/home_tiles_model.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_constants.dart';

class AppUtils {
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
    values.forEach((value) => widgets.add(Text(
          value,
          style: AppColor.themeNormal,
        )));
    return widgets;
  }

  static Future<void> getAlert(BuildContext context, List<String> values,
      {title = "", buttonLabel = 'OK'}) async {
    return showDialog<void>(
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
          actions: <Widget>[
            TextButton(
              child: Text(buttonLabel, style: AppColor.themeNormal),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefsConstants.prefsAccessTokenKey);
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

  static List<String> getErrorMessages(Exception exception) {
    List<String> errorMessages = [];
    if (exception is AppException) {
      Map<String, dynamic> data = jsonDecode(exception.getMessage());
      data.forEach((key, value) {
        errorMessages.add(value);
      });
    } else {
      errorMessages.add(exception.toString());
    }

    return errorMessages;
  }

  static AppBar getAppbar(String title, {bottom}) {
    return AppBar(
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        title: Text(title),
        elevation: .1,
        backgroundColor: AppColor.appBarColor,
        bottom: bottom);
  }

  static List<HomeTilesModel> getHomeTilesModels() {
    List<HomeTilesModel> homeTilesModels = [];
    homeTilesModels.add(HomeTilesModel(
        title: "Test Series", imagePath: "assets/images/test-series.png"));
    homeTilesModels.add(HomeTilesModel(
        title: "Recorded Video Course", imagePath: "assets/images/course.png"));
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
      BaseListViewModel baseListViewModel, Widget Function() callBack) {
    if (baseListViewModel.status == "Loading") {
      return AppUtils.getLoader();
    } else if (baseListViewModel.status == "Error") {
      return AppUtils.getErrorWidget(baseListViewModel.viewModels[0].model);
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
    print("Image URL = ${AppConstants.imagePath}/$logoUrl");
    return '${AppConstants.baseUrl}${AppConstants.imagePath}/$logoUrl';
  }

  static void viewPush(BuildContext context, Widget view) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => view),
    );
  }

  static String getUrl(String path) {
    print("PATH = $path");
    return AppConstants.baseUrl + path;
  }

  static void onError(BuildContext context, error, {title = "Error Alert"}) {
    Navigator.pop(context);
    List<String> errorMessages = AppUtils.getErrorMessages(error);
    getAlert(context, errorMessages, title: title);
  }

  static Html getHtmlData(data, {fontFamily = '', fontSize = 15.0}) {
    return Html(
        data: data,
        style: {
          "span": Style(fontFamily: fontFamily),
          "body, span, p, font, div":
              Style(fontSize: FontSize(double.tryParse(fontSize)))
        },
        customRender: {
          "o:p": (RenderContext context, Widget child) {
            return const TextSpan(text: "\\");
          },
        },
        tagsList: Html.tags..addAll(["o:p"]));
  }
}
