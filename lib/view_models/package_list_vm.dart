import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/package_model/package.dart';
import 'package:study_evaluation/models/package_model/package_model.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class PackageListViewModel extends BaseListViewModel {
  Future<void> fetch(
      {String categoryId = "",
      String packageType = "",
      String publishType = "",
      String jsonRecordKey = "records",
      BuildContext? context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel? userModel = AppUtils.getSessionUser(prefs);
    String url = AppUtils.getUrl(
        "${AppConstants.packageAPIPath}?category_id=$categoryId&package_type=$packageType&user_id=${userModel?.id}&publish_type=$publishType");
    get(baseModel: Package(), url: url);
  }

  // Future<void> fetchFree(
  //     {String categoryId = "",
  //     String packageType = "",
  //     String publishType = "",
  //     String jsonRecordKey = "records",
  //     BuildContext? context}) async {
  //   String url = AppUtils.getUrl(AppConstants.freepackageAPIPath);
  //   get(baseModel: FreeContentPackageModel(), url: url);
  // }

  Future<void> fetchPackageLineItems(packageId, {BuildContext? context}) async {
    var prefs = await SharedPreferences.getInstance();
    UserModel? userModel = AppUtils.getSessionUser(prefs);
    String url = AppUtils.getUrl(
        "${AppConstants.packageLineItemsAPIPath}?package_id=$packageId&user_id=${userModel?.id}");

    get(baseModel: PackageModel(), url: url);
  }
}
