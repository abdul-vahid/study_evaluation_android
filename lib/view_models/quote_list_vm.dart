import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/quote_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class QuoteListViewModel extends BaseListViewModel {
  Future<void> fetch(
      {String jsonRecordKey = "records", String filterDate = ""}) async {
    String url = AppUtils.getUrl(AppConstants.quotesAPIPath);
    url += filterDate.isNotEmpty ? "?date=$filterDate" : "";
    get(baseModel: QuoteModel(), url: url);
  }

  /* Future<void> fetch(
      {String jsonRecordKey = "records", String filterDate = ""}) async {
    try {
      final jsonObject = await QuoteService().fetch(filterDate: filterDate);

      final records = jsonObject[jsonRecordKey];
      var modelMap = records.map((item) => QuoteModel.fromMap(item)).toList();
      viewModels = modelMap.map((item) => BaseViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(BaseViewModel(model: QuoteModel(appException: error)));
    } on Exception catch (e) {
      status = "Error";
      viewModels.add(BaseViewModel(model: QuoteModel(error: e)));

      //print("Exception:" + e.toString());
    }

    notifyListeners();
  } */
}
