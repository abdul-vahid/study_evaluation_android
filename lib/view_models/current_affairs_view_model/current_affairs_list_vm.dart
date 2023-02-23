import 'package:flutter/material.dart';
import 'package:study_evaluation/models/current_affairs_model.dart';
import 'package:study_evaluation/services/current_affairs_service.dart';
import 'package:study_evaluation/view_models/current_affairs_view_model/current_affairs_vm.dart';

import '../../core/apis/app_exception.dart';

class CurrentAffairsListViewModel extends ChangeNotifier {
  var viewModels = [];
  var status = "Loading";

  Future<void> fetch({String jsonRecordKey = "records"}) async {
    try {
      final jsonObject = await CurrentAffairsService().fetch();

      final records = jsonObject[jsonRecordKey];
      var modelMap =
          records.map((item) => CurrentAffairsModel.fromMap(item)).toList();
      viewModels =
          modelMap.map((item) => CurrentAffairsViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(CurrentAffairsViewModel(
          model: CurrentAffairsModel(appException: error)));
    } on Exception catch (e) {
      status = "Error";
      viewModels
          .add(CurrentAffairsViewModel(model: CurrentAffairsModel(error: e)));

      //print("Exception:" + e.toString());
    }
    notifyListeners();
  }
}
