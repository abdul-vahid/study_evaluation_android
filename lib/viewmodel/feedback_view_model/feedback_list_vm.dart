import 'package:flutter/material.dart';
import 'package:study_evaluation/models/feedback_model.dart';
import 'package:study_evaluation/services/feedback_service.dart';
import 'package:study_evaluation/viewmodel/feedback_view_model/feedback_vm.dart';

class FeedbackListViewModel extends ChangeNotifier {
  var viewModels = [];

  Future<void> fetch() async {
    final jsonObject = await FeedbackService().fetch();

    final records = jsonObject["records"];
    var modelMap = records.map((item) => FeedbackModel.fromMap(item)).toList();
    viewModels =
        modelMap.map((item) => FeedbackViewModel(model: item)).toList();

    notifyListeners();
  }
}
