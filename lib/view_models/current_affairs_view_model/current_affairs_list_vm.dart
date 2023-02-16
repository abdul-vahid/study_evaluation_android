import 'package:flutter/material.dart';
import 'package:study_evaluation/models/current_affairs_model.dart';
import 'package:study_evaluation/services/current_affairs_service.dart';
import 'package:study_evaluation/view_models/current_affairs_view_model/current_affairs_vm.dart';

class CurrentAffairsListViewModel extends ChangeNotifier {
  var viewModels = [];

  Future<void> fetch({String jsonRecordKey = "records"}) async {
    final jsonObject = await CurrentAffairsService().fetch();

    final records = jsonObject[jsonRecordKey];
    var modelMap =
        records.map((item) => CurrentAffairsModel.fromMap(item)).toList();
    viewModels =
        modelMap.map((item) => CurrentAffairsViewModel(model: item)).toList();

    notifyListeners();
  }
}
