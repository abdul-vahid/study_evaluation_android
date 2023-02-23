import 'package:flutter/material.dart';
import 'package:study_evaluation/models/quote_model.dart';
import 'package:study_evaluation/models/role_model.dart';
import 'package:study_evaluation/services/quote_service.dart';
import 'package:study_evaluation/services/role_service.dart';
import 'package:study_evaluation/view_models/quote_view_model/quote_vm.dart';
import 'package:study_evaluation/view_models/result_view_model/role_vm.dart';

class RoleListViewModel extends ChangeNotifier {
  var viewModels = [];

  Future<void> fetch(
      {String jsonRecordKey = "records", String filterDate = ""}) async {
    final jsonObject = await RoleService().fetch();

    final records = jsonObject[jsonRecordKey];
    var modelMap = records.map((item) => RoleModel.fromMap(item)).toList();
    viewModels = modelMap.map((item) => RoleViewModel(model: item)).toList();

    notifyListeners();
  }
}
