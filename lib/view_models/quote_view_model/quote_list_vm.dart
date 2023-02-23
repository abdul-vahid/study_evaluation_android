import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:study_evaluation/models/quote_model.dart';
import 'package:study_evaluation/services/quote_service.dart';
import 'package:study_evaluation/view_models/quote_view_model/quote_vm.dart';

import '../../core/apis/app_exception.dart';

class QuoteListViewModel extends ChangeNotifier {
  var viewModels = [];
  var status = "Loading";
  Future<void> fetch(
      {String jsonRecordKey = "records", String filterDate = ""}) async {
    try {
      final jsonObject = await QuoteService().fetch(filterDate: filterDate);

      final records = jsonObject[jsonRecordKey];
      var modelMap = records.map((item) => QuoteModel.fromMap(item)).toList();
      viewModels = modelMap.map((item) => QuoteViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(QuoteViewModel(model: QuoteModel(appException: error)));
    } on Exception catch (e) {
      status = "Error";
      viewModels.add(QuoteViewModel(model: QuoteModel(error: e)));

      //print("Exception:" + e.toString());
    }

    notifyListeners();
  }
}
