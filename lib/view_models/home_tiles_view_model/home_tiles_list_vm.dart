import 'package:flutter/material.dart';
import 'package:study_evaluation/models/quote_model.dart';
import 'package:study_evaluation/services/quote_service.dart';
import 'package:study_evaluation/view_models/quote_view_model/quote_vm.dart';

class HomeTilesListViewModel {
  var viewModels = [];

  Future<void> fetch(
      {String jsonRecordKey = "records", String filterDate = ""}) async {
    final jsonObject = await QuoteService().fetch(filterDate: filterDate);

    final records = jsonObject[jsonRecordKey];
    var modelMap = records.map((item) => QuoteModel.fromMap(item)).toList();
    viewModels = modelMap.map((item) => QuoteViewModel(model: item)).toList();
  }
}
