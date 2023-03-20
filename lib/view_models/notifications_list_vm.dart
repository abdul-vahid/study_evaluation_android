import 'dart:convert';
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

  Future<void> updateStatus(String id, String action) async {
    Map<String, String> requestData = {"id": id, "action": action};
    String url = AppUtils.getUrl(AppConstants.notificationAPIPath);
    //debug("udpateStatus = ${jsonEncode(requestData)}");
    return await post(body: jsonEncode(requestData), url: url);
  }
}
