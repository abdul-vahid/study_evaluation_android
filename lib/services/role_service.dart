import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/services/api_service.dart';
import '../utils/app_constants.dart';

class RoleService {
  static final APIService _apiService = APIService();
  Future<dynamic> fetch() async {
    String url = AppConstants.baseUrl + AppConstants.roleAPIPath;
    print("Path = ${AppConstants.roleAPIPath}");
    print("Base URL = ${AppConstants.baseUrl}");
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(SharedPrefsConstants.prefsAccessTokenKey);
    print("Access Token = $token");

    final responseJsonData = await _apiService.getResponse(url, token!);
    //String accessToken = responseJsonData['access_token'];
    if (AppConstants.kDebugMode) {
      print("responseJsonData: $responseJsonData");
    }
    //print("Access Token: $responseJsonData");
    return responseJsonData;
  }
}
