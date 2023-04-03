import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/question_answer_model/exam_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class ResultListViewModel extends BaseListViewModel {
  Future<void> fetch(resultId, {BuildContext? context}) async {
    var userModel =
        AppUtils.getSessionUser(await SharedPreferences.getInstance());
    String url = AppUtils.getUrl(
        "${AppConstants.resultAPIPath}?result_id=$resultId&user_id=${userModel?.id}");
    get(baseModel: ExamModel(), url: url);
  }
}
