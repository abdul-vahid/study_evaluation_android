import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/package_model/package.dart';
import 'package:study_evaluation/models/package_model/package_model.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class PackageListViewModel extends BaseListViewModel {
  Future<void> fetch({categoryId, String jsonRecordKey = "records"}) async {
    String url = AppUtils.getUrl("${AppConstants.packageAPIPath}/$categoryId");
    get(baseModel: Package(), url: url);
  }

  /* Future<void> fetch({categoryId, String jsonRecordKey = "records"}) async {
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
  } */
  Future<void> fetchPackageLineItems(packageId) async {
    var prefs = await SharedPreferences.getInstance();
    UserModel userModel = AppUtils.getSessionUser(prefs);
    String url = AppUtils.getUrl(
        "${AppConstants.packageLineItemsAPIPath}?package_id=$packageId&user_id=${userModel.id}");

    get(baseModel: PackageModel(), url: url);
  }

  /* Future<void> fetchPackageLineItems(packageId) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      UserModel userModel = AppUtils.getSessionUser(prefs);

      final jsonObject =
          await PackageService().fetchPackageLineItems(packageId, userModel.id);
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
    } catch (e) {
      status = "Error";
      viewModels.add(BaseViewModel(model: PackageModel(error: e as Exception)));
    } 

    notifyListeners();
  }*/
}
