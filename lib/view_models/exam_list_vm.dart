import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/models/question_answer_model/exam_model.dart';
import 'package:study_evaluation/models/result_model/result.dart';
import 'package:study_evaluation/models/result_model/result_line_item.dart';
import 'package:study_evaluation/models/result_model/result_model.dart';

import 'package:study_evaluation/services/exam_service.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class ExamListViewModel extends BaseListViewModel {
  Future<void> fetchQuestionAnswer(
      {required String examId, String? studentId}) async {
    try {
      final jsonObject = await ExamService()
          .fetchQuestionAnswer(examId: examId, studentId: studentId);
      final records = jsonObject["records"];
      print(records);
      var modelMap = records.map((item) => ExamModel.fromMap(item)).toList();
      viewModels = modelMap.map((item) => BaseViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(BaseViewModel(model: ExamModel(appException: error)));
    } on Exception catch (e, stacktrace) {
      status = "Error";
      viewModels.add(BaseViewModel(model: ExamModel(error: e)));
    } catch (e, stacktrace) {
      status = "Error";
      print(e);
      print(stacktrace);
      //viewModels.add(BaseViewModel(model: ExamModel(error: e as Exception)));
    }

    notifyListeners();
  }

  Future<dynamic> submitExam(ExamModel examModel,
      {String status = "Completed"}) async {
    print("submit exam list");
    var prefs = await SharedPreferences.getInstance();
    var studentId = AppUtils.getSessionUser(prefs).studentId;
    List<ResultLineItem> resultLineItems = [];
    //String status = "Completed";
    String resultId = "";
    for (var qm in examModel.questionModels!) {
      resultId = (qm.resultId)!;
      resultLineItems.add(ResultLineItem(
          id: qm.resultLineItemId,
          answer: qm.submittedAnswer,
          favourite: qm.favourite == null ? "false" : qm.favourite.toString(),
          questionId: qm.id));
    }
    Result result = Result(
        id: resultId,
        examId: examModel.exam?.id,
        studentId: studentId,
        status: status,
        examTime: examModel.exam?.remainingExamTime);
    ResultModel resultModel =
        ResultModel(result: result, resultLineItems: resultLineItems);
    return await ExamService().submitExam(resultModel);
  }
}
