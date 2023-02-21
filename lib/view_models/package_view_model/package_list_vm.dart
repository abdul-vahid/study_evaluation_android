import 'package:flutter/material.dart';
import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/models/package_model/package.dart';
import 'package:study_evaluation/models/package_model/package_model.dart';
import 'package:study_evaluation/services/package_service.dart';
import 'package:study_evaluation/view_models/package_view_model/package_vm.dart';

class PackageListViewModel extends ChangeNotifier {
  var viewModels = [];

  Future<void> fetch({categoryId, String jsonRecordKey = "records"}) async {
    final jsonObject = await PackageService().fetch(categoryId: categoryId);

    final records = jsonObject[jsonRecordKey];
    var modelMap = records.map((item) => Package.fromMap(item)).toList();
    viewModels = modelMap.map((item) => PackageViewModel(model: item)).toList();

    notifyListeners();
  }

  Future<void> fetchPackageLineItems(packageId) async {
    try {
      final jsonObject =
          await PackageService().fetchPackageLineItems(packageId, 12);
      final records = jsonObject["records"];
      var modelMap = records.map((item) => PackageModel.fromMap(item)).toList();
      viewModels =
          modelMap.map((item) => PackageViewModel(model: item)).toList();
    } on AppException catch (error) {
      viewModels
          .add(PackageViewModel(model: PackageModel(appException: error)));
    } on Exception catch (e) {
      viewModels.add(PackageViewModel(model: PackageModel(error: e)));
      //print("Exception:" + e.toString());
    }

    notifyListeners();
  }
}
