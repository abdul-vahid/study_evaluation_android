import 'package:flutter/material.dart';
import 'package:study_evaluation/models/package_model.dart';
import 'package:study_evaluation/services/package_service.dart';
import 'package:study_evaluation/viewmodel/package_view_model/package_vm.dart';

class PackageListViewModel extends ChangeNotifier {
  var viewModels = [];

  Future<void> fetch({categoryId}) async {
    final jsonObject = await PackageService().fetch(categoryId: categoryId);

    final records = jsonObject["records"];
    var modelMap = records.map((item) => PackageModel.fromMap(item)).toList();
    viewModels = modelMap.map((item) => PackageViewModel(model: item)).toList();

    notifyListeners();
  }
}
