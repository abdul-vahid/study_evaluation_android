import 'package:flutter/material.dart';
import 'package:study_evaluation/models/slider_image_model.dart';
import 'package:study_evaluation/services/slider_service.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/viewmodel/slider_image_view_model/slider_image_vm.dart';

class SliderImageListViewModel extends ChangeNotifier {
  var viewModels = [];

  Future<void> fetch({String categoryId = ""}) async {
    //print("category fetch called");
    final jsonObject = await SliderImageService().fetch();

    if (AppConstants.kDebugMode) {
      //print(jsonObject["records"]);
    }
    final records = jsonObject["records"];
    var modelMap =
        records.map((item) => SliderImageModel.fromMap(item)).toList();
    viewModels =
        modelMap.map((item) => SliderImageViewModel(model: item)).toList();

    notifyListeners();
  }
}
