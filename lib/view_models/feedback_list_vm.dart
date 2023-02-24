import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/models/feedback_model.dart';
import 'package:study_evaluation/services/feedback_service.dart';

class FeedbackListViewModel extends BaseListViewModel {
  Future<void> fetch() async {
    try {
      final jsonObject = await FeedbackService().fetch();

      final records = jsonObject["records"];
      var modelMap =
          records.map((item) => FeedbackModel.fromMap(item)).toList();
      viewModels = modelMap.map((item) => BaseViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(BaseViewModel(model: FeedbackModel(appException: error)));
    } on Exception catch (e) {
      status = "Error";
      viewModels.add(BaseViewModel(model: FeedbackModel(error: e)));
    }

    notifyListeners();
  }
}
