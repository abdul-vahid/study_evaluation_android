import 'package:flutter/material.dart';
import 'package:study_evaluation/models/category_model.dart';
import 'package:study_evaluation/services/category_service.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/view_models/category_view_model/category_vm.dart';

class CategoryListViewModel extends ChangeNotifier {
  var categoryViewModels = [];

  Future<void> fetch({String categoryId = ""}) async {
    print("category fetch called");
    final jsonObject = await CategoryService().fetch(categoryId: categoryId);

    if (AppConstants.kDebugMode) {
      print(jsonObject["records"]);
    }
    final records = jsonObject["records"];
    var categoryModelMap =
        records.map((item) => CategoryModel.fromMap(item)).toList();
    //CategoryModelMap = CategoryModelMap.cast<CategoryModel>();
    //var CategoryModelMap = CategoryModel.fromJson(results["user"]);
    //print(CategoryModelMap);
    categoryViewModels = categoryModelMap
        .map((item) => CategoryViewModel(categoryModel: item))
        .toList();

    notifyListeners();
  }
}
