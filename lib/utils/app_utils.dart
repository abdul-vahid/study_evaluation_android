import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_constants.dart';

class AppUtil {
  void onLoading(BuildContext? context, String? label) {
    showDialog(
        context: context!,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Colors.green,
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

  List<Widget> _getTextWidgets(List<String> values) {
    List<Widget> widgets = [];
    values.forEach((value) => widgets.add(Text(
          value,
          style: AppColor.themeNormal,
        )));
    return widgets;
  }

  Future<void> getAlert(BuildContext context, List<String> values,
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

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefsConstants.prefsAccessTokenKey);
  }
}
