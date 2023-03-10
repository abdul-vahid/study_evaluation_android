import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/order_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class OrderListViewModel extends BaseListViewModel {
  Future<void> fetch() async {
    var userModel =
        AppUtils.getSessionUser(await SharedPreferences.getInstance());

    String url = AppUtils.getUrl(
        "${AppConstants.orderAPIPath}?student_id=${userModel.studentId}");
    get(baseModel: OrderModel(), url: url);
  }
}
