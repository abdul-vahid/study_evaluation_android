import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/models/current_affairs_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class CurrentAffairsListViewModel extends BaseListViewModel {
  Map<String, List<BaseViewModel>> currentAffairsData =
      <String, List<BaseViewModel>>{};

  Future<void> fetch({String jsonRecordKey = "records"}) async {
    String url = AppUtils.getUrl(AppConstants.currentAffairsAPIPath);
    await get(baseModel: CurrentAffairsModel(), url: url);

    for (var vm in viewModels) {
      CurrentAffairsModel model = vm.model as CurrentAffairsModel;
      List<BaseViewModel>? caList = currentAffairsData[model.type];
      caList ??= [];
      caList.add(vm);
      currentAffairsData[model.type!] = caList;
    }

    notifyListeners();
  }
}
