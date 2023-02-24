import 'package:flutter/material.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/models/current_affairs_model.dart';
import 'package:study_evaluation/services/current_affairs_service.dart';

import '../core/apis/app_exception.dart';

class CurrentAffairsListViewModel extends ChangeNotifier {
  Map<String, List<BaseViewModel>> viewModels = <String, List<BaseViewModel>>{};
  var status = "Loading";
  Future<void> fetch({String jsonRecordKey = "records"}) async {
    try {
      final jsonObject = await CurrentAffairsService().fetch();
      final records = jsonObject[jsonRecordKey];
      var modelMap =
          records.map((item) => CurrentAffairsModel.fromMap(item)).toList();
      var vmList = modelMap.map((item) => BaseViewModel(model: item)).toList();

      for (var vm in vmList) {
        List<BaseViewModel>? caList = viewModels[vm.model.type];
        caList ??= [];
        caList.add(vm);
        viewModels[vm.model.type] = caList;
      }

      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      List<BaseViewModel> caList = [];
      caList
          .add(BaseViewModel(model: CurrentAffairsModel(appException: error)));
      viewModels["error"] = caList;
    } on Exception catch (e) {
      status = "Error";
      List<BaseViewModel> caList = [];
      caList.add(BaseViewModel(model: CurrentAffairsModel(error: e)));
      viewModels["error"] = caList;

      //print("Exception:" + e.toString());
    }
    notifyListeners();
  }
}
