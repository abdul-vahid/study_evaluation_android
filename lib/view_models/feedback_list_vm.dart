import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/feedback_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class FeedbackListViewModel extends BaseListViewModel {
  Future<void> fetch() async {
    String url = AppUtils.getUrl("${AppConstants.feedbackAPIPath}?limit=10");
    get(baseModel: FeedbackModel(), url: url);
  }

  Future<dynamic> submitFeedback(FeedbackModel feedbackModel) async {
    String url = AppUtils.getUrl(AppConstants.submitFeedbackAPIPath);
    return await post(url: url, body: feedbackModel.toJson());
  }
}
