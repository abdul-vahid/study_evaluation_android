import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/models/package_model/package.dart';
import 'package:study_evaluation/models/package_model/package_model.dart';
import 'package:study_evaluation/services/package_service.dart';

class PackageListViewModel extends BaseListViewModel {
  Future<void> fetch({categoryId, String jsonRecordKey = "records"}) async {
    try {
      final jsonObject = await PackageService().fetch(categoryId: categoryId);
      final records = jsonObject[jsonRecordKey];
      var modelMap = records.map((item) => Package.fromMap(item)).toList();
      viewModels = modelMap.map((item) => BaseViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(BaseViewModel(model: Package(appException: error)));
    } on Exception catch (e) {
      status = "Error";
      viewModels.add(BaseViewModel(model: Package(error: e)));
    }
    notifyListeners();
  }

  Future<void> fetchPackageLineItems(packageId) async {
    try {
      final jsonObject =
          await PackageService().fetchPackageLineItems(packageId, 12);
      final records = jsonObject["records"];

      var modelMap = records.map((item) => PackageModel.fromMap(item)).toList();
      viewModels = modelMap.map((item) => BaseViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(BaseViewModel(model: PackageModel(appException: error)));
    } on Exception catch (e) {
      status = "Error";
      viewModels.add(BaseViewModel(model: PackageModel(error: e)));
      //print("Exception:" + e.toString());
    }

    notifyListeners();
  }
}