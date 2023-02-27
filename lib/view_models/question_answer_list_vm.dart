import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/models/question_answer_model/question_answer_model.dart';

import 'package:study_evaluation/services/question_answer_service.dart';

class QuestionAnswerListViewModel extends BaseListViewModel {
  Future<void> fetch({required String examId, String? studentId}) async {
    try {
      final jsonObject = await QuestionAnswerService().fetch(examId: examId);
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

  getViewModels(modelMap) {
    return modelMap.map((item) => BaseViewModel(model: item)).toList();
  }
}
