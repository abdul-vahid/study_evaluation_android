import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/core/services/base_service.dart';

class BaseListViewModel extends ChangeNotifier {
  var viewModels = [];
  var status = "Loading";

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
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(
          BaseViewModel(model: BaseModel(appException: error, error: null)));
    } on Exception catch (e, stacktrace) {
      status = "Error";
      viewModels
          .add(BaseViewModel(model: BaseModel(appException: null, error: e)));
    } catch (e, stacktrace) {
      status = "Error";
      print(e);
      print(stacktrace);
      //viewModels.add(BaseViewModel(model: ExamModel(error: e as Exception)));
    }
    print("View Models REsult");
    print(jsonEncode(viewModels[0].model));
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

      var modelMap = records.map((item) => baseModel.fromMap(item)).toList();
      viewModels = modelMap.map((item) => BaseViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(
          BaseViewModel(model: BaseModel(appException: error, error: null)));
    } on Exception catch (e, stacktrace) {
      status = "Error";
      viewModels
          .add(BaseViewModel(model: BaseModel(appException: null, error: e)));
    } catch (e, stacktrace) {
      status = "Error";
      print(e);
      print(stacktrace);
      //viewModels.add(BaseViewModel(model: ExamModel(error: e as Exception)));
    }

    notifyListeners();
  }
}
