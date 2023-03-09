import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/services/api_service.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import '../utils/app_constants.dart';

class PackageService {
  static final APIService _apiService = APIService();
  Future<dynamic> fetch({categoryId}) async {
    String url = AppUtils.getUrl(AppConstants.packageAPIPath);
    url += "/$categoryId";
    var token = await AppUtils.getToken();
    final responseJsonData = await _apiService.getResponse(url, token!);
    if (AppConstants.kDebugMode) {
      print("responseJsonData: $responseJsonData");
    }
    return responseJsonData;
  }

  Future<dynamic> fetchPackageLineItems(packageId, studentId) async {
    String url = AppUtils.getUrl(AppConstants.packageLineItemsAPIPath);
    url += "?package_id=$packageId&user_id=$studentId";
    var token = await AppUtils.getToken();

    final responseJsonData = await _apiService.getResponse(url, token!);

    if (AppConstants.kDebugMode) {
      print("responseJsonData: $responseJsonData");
    }
    return responseJsonData;
  }
}
