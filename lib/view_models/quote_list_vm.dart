import 'dart:convert';

import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/models/quote_model.dart';
import 'package:study_evaluation/services/quote_service.dart';

import '../core/apis/app_exception.dart';

class QuoteListViewModel extends BaseListViewModel {
  Future<void> fetch(
      {String jsonRecordKey = "records", String filterDate = ""}) async {
    try {
      final jsonObject = await QuoteService().fetch(filterDate: filterDate);

      final records = jsonObject[jsonRecordKey];
      var modelMap = records.map((item) => QuoteModel.fromMap(item)).toList();
      viewModels = modelMap.map((item) => BaseViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(BaseViewModel(model: QuoteModel(appException: error)));
    } on Exception catch (e) {
      status = "Error";
      viewModels.add(BaseViewModel(model: QuoteModel(error: e)));

      //print("Exception:" + e.toString());
    }

    notifyListeners();
  }
}
