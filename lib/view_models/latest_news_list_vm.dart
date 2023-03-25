import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/models/current_affairs_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

import '../models/latest_news_model.dart';

class LatestNewsListViewModel extends BaseListViewModel {
  Map<String, List<BaseViewModel>> latestNewsData =
      <String, List<BaseViewModel>>{};

  Future<void> fetch({String jsonRecordKey = "records"}) async {
    String url = AppUtils.getUrl(AppConstants.latestNewsAPIPath);
    await get(baseModel: LatestNewsModel(), url: url);

    for (var vm in viewModels) {
      LatestNewsModel model = vm.model as LatestNewsModel;
      List<BaseViewModel>? caList = latestNewsData[model.status];
      caList ??= [];
      caList.add(vm);
      latestNewsData[model.status!] = caList;
    }

    notifyListeners();
  }
}
