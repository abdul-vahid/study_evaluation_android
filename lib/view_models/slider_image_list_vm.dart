import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/slider_image_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class SliderImageListViewModel extends BaseListViewModel {
  Future<void> fetch() async {
    String url =
        AppUtils.getUrl("${AppConstants.appearanceAPIPath}?status=Active");
    get(baseModel: SliderImageModel(), url: url);
  }
}
