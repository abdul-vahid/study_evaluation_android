import 'package:study_evaluation/services/api_service.dart';
import 'package:study_evaluation/utils/app_utils.dart';

import '../utils/app_constants.dart';

class QuestionAnswerService {
  static final APIService _apiService = APIService();
  Future<dynamic> fetch(
      {required String examId, String? studentId = "-1"}) async {
    String url =
        "${AppConstants.questionAnswerAPIPath}?exam_id=$examId&student_id=$studentId";

    url = AppUtil.getUrl(url);
    var token = await AppUtil().getToken();
    final responseJsonData = await _apiService.getResponse(url, token!);
    if (AppConstants.kDebugMode) {
      print("responseJsonData: $responseJsonData");
    }
    return responseJsonData;
  }
}
