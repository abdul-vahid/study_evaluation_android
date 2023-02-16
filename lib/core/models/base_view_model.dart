import 'package:study_evaluation/core/models/base_model.dart';

class BaseViewModel {
  final BaseModel model;
  BaseViewModel({required this.model});
  BaseModel get getViewModel {
    return model;
  }
}
