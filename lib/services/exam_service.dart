import 'dart:convert';

import 'package:study_evaluation/models/question_answer_model/question.dart';
import 'package:study_evaluation/services/api_service.dart';
import 'package:study_evaluation/utils/app_utils.dart';

import '../utils/app_constants.dart';

class ExamService {
  static final APIService _apiService = APIService();
  Future<dynamic> fetchQuestionAnswer(
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

  Future<dynamic> submitExam(List<Question> questions) async {
    String url = AppUtil.getUrl(AppConstants.submitExamAPIPath);
    var token = await AppUtil().getToken();
    var body = jsonEncode(questions);
    print("body = $body");
    final responseJsonData = await _apiService.postResponse(url, body, token!);
    if (AppConstants.kDebugMode) {
      print("responseJsonData: $responseJsonData");
    }
    return responseJsonData;
  }
}
