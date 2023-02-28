import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/models/question_answer_model/question.dart';
import 'package:study_evaluation/models/question_answer_model/question_answer_model.dart';

import 'package:study_evaluation/services/exam_service.dart';

class ExamListViewModel extends BaseListViewModel {
  Future<void> fetchQuestionAnswer(
      {required String examId, String? studentId}) async {
    try {
      final jsonObject =
          await ExamService().fetchQuestionAnswer(examId: examId);
      final records = jsonObject["records"];
      print(records);
      var modelMap =
          records.map((item) => QuestionAnswerModel.fromMap(item)).toList();
      viewModels = modelMap.map((item) => BaseViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      viewModels
          .add(BaseViewModel(model: QuestionAnswerModel(appException: error)));
    } on Exception catch (e) {
      status = "Error";
      viewModels.add(BaseViewModel(model: QuestionAnswerModel(error: e)));
    }

    notifyListeners();
  }

  Future<dynamic> submitExam(List<Question> questions) async {
    return await ExamService().submitExam(questions);
  }
}
