import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/models/question_answer_model/exam_model.dart';
import 'package:study_evaluation/models/result_model/result.dart';
import 'package:study_evaluation/models/result_model/result_line_item.dart';
import 'package:study_evaluation/models/result_model/result_model.dart';

import 'package:study_evaluation/services/exam_service.dart';

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
    } on Exception catch (e) {
      status = "Error";
      viewModels.add(BaseViewModel(model: ExamModel(error: e)));
    }

    notifyListeners();
  }

  Future<dynamic> submitExam(ExamModel examModel) async {
    List<ResultLineItem> resultLineItems = [];
    String status = "Completed";
    for (var qm in examModel.questionModels!) {
      if (!qm.hasSubmittedAnswer) {
        status = "In Progress";
      }
      resultLineItems.add(ResultLineItem(
          id: qm.resultId,
          answer: qm.submittedAnswer,
          favourite: qm.favourite ?? "false",
          questionId: qm.id));
    }
    Result result = Result(
        examId: examModel.exam?.id,
        studentId: "12",
        status: status,
        examTime: "00:45:00");
    ResultModel resultModel =
        ResultModel(result: result, resultLineItems: resultLineItems);
    return await ExamService().submitExam(resultModel);
  }
}
