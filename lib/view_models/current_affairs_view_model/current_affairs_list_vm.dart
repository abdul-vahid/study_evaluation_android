import 'package:flutter/material.dart';
import 'package:study_evaluation/models/current_affairs_model.dart';
import 'package:study_evaluation/services/current_affairs_service.dart';
import 'package:study_evaluation/view_models/current_affairs_view_model/current_affairs_vm.dart';

import '../../core/apis/app_exception.dart';

class CurrentAffairsListViewModel extends ChangeNotifier {
  Map<String, List<CurrentAffairsViewModel>> viewModels =
      <String, List<CurrentAffairsViewModel>>{};
  var status = "Loading";

  Future<void> fetch({String jsonRecordKey = "records"}) async {
    try {
      final jsonObject = await CurrentAffairsService().fetch();

      final records = jsonObject[jsonRecordKey];

      print('@@@records${records}');

      var modelMap =
          records.map((item) => CurrentAffairsModel.fromMap(item)).toList();
      print('@@@modelMap${modelMap}');
      var vmList =
          modelMap.map((item) => CurrentAffairsViewModel(model: item)).toList();
      print('vmList${vmList}');
      for (var vm in vmList) {
        List<CurrentAffairsViewModel>? caList = viewModels[vm.model.type];
        caList ??= [];
        caList.add(vm);
        viewModels[vm.model.type] = caList;
      }
      print("@@viewModels ${viewModels}");
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      List<CurrentAffairsViewModel> caList = [];
      caList.add(CurrentAffairsViewModel(
          model: CurrentAffairsModel(appException: error)));
      viewModels["error"] = caList;
    } on Exception catch (e) {
      status = "Error";
      List<CurrentAffairsViewModel> caList = [];
      caList.add(CurrentAffairsViewModel(model: CurrentAffairsModel(error: e)));
      viewModels["error"] = caList;

      //print("Exception:" + e.toString());
    }
    notifyListeners();
  }
}
