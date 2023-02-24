import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';
import 'package:study_evaluation/models/slider_image_model.dart';
import 'package:study_evaluation/services/slider_service.dart';

class SliderImageListViewModel extends BaseListViewModel {
  Future<void> fetch({String categoryId = ""}) async {
    try {
      final jsonObject = await SliderImageService().fetch();
      final records = jsonObject["records"];
      var modelMap =
          records.map((item) => SliderImageModel.fromMap(item)).toList();
      viewModels = modelMap.map((item) => BaseViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      viewModels
          .add(BaseViewModel(model: SliderImageModel(appException: error)));
    } on Exception catch (e) {
      status = "Error";
      viewModels.add(BaseViewModel(model: SliderImageModel(error: e)));
    }

    notifyListeners();
  }
}