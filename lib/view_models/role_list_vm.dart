/* import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/models/role_model.dart';
import 'package:study_evaluation/services/role_service.dart';

class RoleListViewModel extends BaseListViewModel {
  Future<void> fetch({String jsonRecordKey = "records"}) async {
    try {
      final jsonObject = await RoleService().fetch();
      final records = jsonObject[jsonRecordKey];
      var modelMap = records.map((item) => RoleModel.fromMap(item)).toList();
      viewModels = modelMap.map((item) => BaseViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(BaseViewModel(model: RoleModel(appException: error)));
    } on Exception catch (e) {
      status = "Error";
      viewModels.add(BaseViewModel(model: RoleModel(error: e)));
      //print("Exception:" + e.toString());
    }

    notifyListeners();
  }
}
 */
