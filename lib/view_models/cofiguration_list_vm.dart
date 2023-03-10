import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/models/category_model.dart';
import 'package:study_evaluation/models/configuration_model.dart';
import 'package:study_evaluation/services/category_service.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class ConfigurationListViewModel extends BaseListViewModel {
  Future<void> fetch() async {
    String url = AppUtils.getUrl(AppConstants.configurationAPIPath);
    get(baseModel: ConfigurationModel(), url: url);
    //notifyListeners();
  }
}
