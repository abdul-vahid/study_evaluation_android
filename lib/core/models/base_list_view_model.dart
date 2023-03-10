import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/core/services/base_service.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class BaseListViewModel extends ChangeNotifier {
  var viewModels = [];
  var status = "Loading";
  bool get isError {
    return status == "Error";
  }

  Future<void> get(
      {required BaseModel baseModel,
      required String url,
      String jsonKey = "records"}) async {
    try {
      final jsonObject = await BaseService().get(url: url);
      final records = jsonObject[jsonKey];

      var modelMap = records.map((item) => baseModel.fromMap(item)).toList();
      viewModels = modelMap.map((item) => BaseViewModel(model: item)).toList();
      status = "Completed";
    } on UnauthorisedException {
      String refreshTokenUrl =
          AppUtils.getUrl(AppConstants.refreshTokenAPIPath);
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String refreshToken = "";
        String accessToken = "";
        if (prefs.containsKey(SharedPrefsConstants.refreshTokenKey)) {
          refreshToken = prefs.getString(SharedPrefsConstants.refreshTokenKey)!;
        }
        //if (prefs.containsKey(SharedPrefsConstants.sessionTimeKey)) {
        String sessionTime;
        int minutes = 0;
        if (prefs.containsKey(SharedPrefsConstants.sessionTimeKey)) {
          sessionTime = prefs.getString(SharedPrefsConstants.sessionTimeKey)!;
          var sessionDT = DateFormat('yyyy-MM-dd HH:mm:ss').parse(sessionTime);
          minutes = DateTime.now().difference(sessionDT).inMinutes;
        }

        if (minutes > 119) {
          Map<String, String> body = {"refresh_token": refreshToken};
          final jsonObject =
              await post(url: refreshTokenUrl, body: jsonEncode(body));

          accessToken = jsonObject["access_token"];
          refreshToken = jsonObject["refresh_token"];
          AppUtils.printDebug("refreshtoken $accessToken -- $refreshToken");

          await prefs.setString(
              SharedPrefsConstants.accessTokenKey, accessToken);
          await prefs.setString(
              SharedPrefsConstants.refreshTokenKey, refreshToken);
          await prefs.setString(
              SharedPrefsConstants.sessionTimeKey, DateTime.now().toString());
        }

        final jsonObjectRequest = await BaseService().get(url: url);
        final records = jsonObjectRequest[jsonKey];
        //AppUtils.printDebug("Response Data === $records");
        var modelMap = records.map((item) => baseModel.fromMap(item)).toList();
        viewModels =
            modelMap.map((item) => BaseViewModel(model: item)).toList();
        status = "Completed";
      } on UnauthorisedException {
        AppUtils.printDebug("URL = ${url.substring(4)}");
        //showAlert and Logout
        AppUtils.getAlert(AppUtils.currentContext!, [
          "You have been logged out!",
        ], onPressed: () {
          AppUtils.logout(AppUtils.currentContext);
        });
      } on AppException catch (error) {
        AppUtils.printDebug("error = $error");
        status = "Error";
        viewModels.add(
            BaseViewModel(model: BaseModel(appException: error, error: null)));
      } on Exception catch (error) {
        status = "Error";
        AppUtils.printDebug("error = $error");
        viewModels.add(
            BaseViewModel(model: BaseModel(appException: null, error: error)));
      } catch (e, stackTrace) {
        status = "Error";
        AppUtils.printDebug(stackTrace);

        viewModels.add(BaseViewModel(
            model:
                BaseModel(appException: null, error: Exception(e.toString()))));
      }
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(
          BaseViewModel(model: BaseModel(appException: error, error: null)));
    } on Exception catch (e, stackTrace) {
      status = "Error";
      AppUtils.printDebug(stackTrace);
      viewModels
          .add(BaseViewModel(model: BaseModel(appException: null, error: e)));
    } catch (e, stackTrace) {
      status = "Error";
      AppUtils.printDebug(stackTrace);

      viewModels.add(BaseViewModel(
          model:
              BaseModel(appException: null, error: Exception(e.toString()))));
    }

    notifyListeners();
  }

  Future<dynamic> post(
      {required String url,
      required String body,
      String jsonKey = "records"}) async {
    return await BaseService().post(url: url, body: body);
  }

  Future<void> postData(
      {required BaseModel baseModel,
      required String url,
      required String body,
      String jsonKey = "records"}) async {
    try {
      final jsonObject = await BaseService().post(url: url, body: body);
      final records = jsonObject[jsonKey];
      AppUtils.printDebug('records$records');
      var modelMap = records.map((item) => baseModel.fromMap(item)).toList();
      viewModels = modelMap.map((item) => BaseViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(
          BaseViewModel(model: BaseModel(appException: error, error: null)));
    } on Exception catch (e) {
      status = "Error";
      viewModels
          .add(BaseViewModel(model: BaseModel(appException: null, error: e)));
    } catch (e) {
      status = "Error";
      AppUtils.printDebug(e);
      //print(stacktrace);
      //viewModels.add(BaseViewModel(model: ExamModel(error: e as Exception)));
    }

    notifyListeners();
  }
}
/*
 on UnauthorisedException {
      /* String refreshTokenUrl =
          AppUtils.getUrl(AppConstants.refreshTokenAPIPath);
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String refreshToken =
            prefs.getString(SharedPrefsConstants.refreshTokenKey)!;
        Map<String, String> body = {"refresh_token": refreshToken};
        final jsonObject =
            await post(url: refreshTokenUrl, body: jsonEncode(body));
        String accessToken = jsonObject["access_token"];
        refreshToken = jsonObject["refresh_token"];
        await prefs.setString(SharedPrefsConstants.accessTokenKey, accessToken);
        await prefs.setString(
            SharedPrefsConstants.refreshTokenKey, refreshToken);

        APIService apiService = APIService();
        final jsonObjectRequest = await apiService.getResponse(url, "");
        final records = jsonObjectRequest[jsonKey];

        var modelMap = records.map((item) => baseModel.fromMap(item)).toList();
        viewModels =
            modelMap.map((item) => BaseViewModel(model: item)).toList();
        status = "Completed";
      } on UnauthorisedException {
        //showAlert and Logout
        /* AppUtils.getAlert(
            AppUtils.currentContext!,
            [
              "You have been logged out!",
            ],
            onPressed: () {}); */
      } on AppException catch (error) {
        //Fill Map
        status = "Error";
        viewModels.add(
            BaseViewModel(model: BaseModel(appException: error, error: null)));
      } on Exception catch (error) {
        status = "Error";
        viewModels.add(
            BaseViewModel(model: BaseModel(appException: null, error: error)));
      } catch (e, stackTrace) {
        status = "Error";
        AppUtils.printDebug(stackTrace);

        viewModels.add(BaseViewModel(
            model:
                BaseModel(appException: null, error: Exception(e.toString()))));
      } */
      status = "Error";
      viewModels.add(
          BaseViewModel(model: BaseModel(appException: AppException(""), error: null)));
    } 
*/