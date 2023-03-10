/* import 'dart:convert';
import 'package:study_evaluation/models/result_model/result_model.dart';
import 'package:study_evaluation/services/api_service.dart';
import 'package:study_evaluation/utils/app_utils.dart';

import '../utils/app_constants.dart';

class ExamService {
  static final APIService _apiService = APIService();
  Future<dynamic> fetchQuestionAnswer(
      {required String examId, String? studentId = ""}) async {
    String url =
        "${AppConstants.questionAnswerAPIPath}?exam_id=$examId&student_id=$studentId";

    url = AppUtils.getUrl(url);
    var token = await AppUtils.getToken();
    final responseJsonData = await _apiService.getResponse(url, token!);
    AppUtils.printDebug("responseJsonData: $responseJsonData");
    return responseJsonData;
  }

  Future<dynamic> submitExam(ResultModel resultModel) async {
    String url = AppUtils.getUrl(AppConstants.submitExamAPIPath);
    var token = await AppUtils.getToken();
    var body = resultModel.toJson();
    //printLongString("body = $body");
    final responseJsonData = await _apiService.postResponse(url, body, token!);
    if (AppConstants.kDebugMode) {
      print("responseJsonData: $responseJsonData");
    }
    return responseJsonData;
  }

  /// Print Long String
  void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(text)
        .forEach((RegExpMatch match) => print(match.group(0)));
  }
}
 */