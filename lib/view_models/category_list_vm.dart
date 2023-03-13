import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/category_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class CategoryListViewModel extends BaseListViewModel {
  Future<void> fetch({String categoryId = ""}) async {
    String url = AppUtils.getUrl(AppConstants.categoryAPIPath);
    if (categoryId.isNotEmpty) {
      url += "/$categoryId";
    }
    get(baseModel: CategoryModel(), url: url);
  }

  /* Future<void> fetch({String categoryId = ""}) async {
    try {
      final jsonObject = await CategoryService().fetch(categoryId: categoryId);
      final records = jsonObject["records"];
      var categoryModelMap =
          records.map((item) => CategoryModel.fromMap(item)).toList();
      viewModels =
          categoryModelMap.map((item) => BaseViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      viewModels.add(BaseViewModel(model: CategoryModel(appException: error)));
    } on Exception catch (e) {
      status = "Error";
      viewModels.add(BaseViewModel(model: CategoryModel(error: e)));
    }

    notifyListeners();
  } */
}
