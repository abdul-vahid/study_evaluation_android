import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/notification_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class NotificationsListViewModel extends BaseListViewModel {
  Future<void> fetch() async {
    var userModel =
        AppUtils.getSessionUser(await SharedPreferences.getInstance());

    String url = AppUtils.getUrl(
        "${AppConstants.notificationAPIPath}?user_id=${userModel.id}");
    get(baseModel: NotificationModel(), url: url);
  }
}
