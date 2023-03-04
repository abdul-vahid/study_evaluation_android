import 'dart:convert';

import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/models/follow_us_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';

class FollowUSListViewModel extends BaseListViewModel {
  Future<void> fetch() async {
    try {
      final jsonObject = jsonDecode(AppConstants.followUSData);
      final records = jsonObject["records"];
      print(records);
      var modelMap =
          records.map((item) => FollowUsModel.fromMap(item)).toList();
      viewModels = modelMap.map((item) => BaseViewModel(model: item)).toList();
      print("data loaded: $viewModels");

      Future<void>.delayed(Duration.zero, () {
        print("Future.delayed Event");
        notifyListeners();
      });
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(BaseViewModel(model: FollowUsModel(appException: error)));
    } on Exception catch (e) {
      status = "Error";
      viewModels.add(BaseViewModel(model: FollowUsModel(error: e)));
    }
  }
}
