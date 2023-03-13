/* import 'package:study_evaluation/services/api_service.dart';

import '../utils/app_constants.dart';

class LoginService {
  static final APIService _apiService = APIService();
  Future<dynamic> login(String username, String password) async {
    Map<String, String> requestData = {'email': username, 'password': password};
    String url = AppConstants.baseUrl + AppConstants.loginAPIPath;
    print(url);
    final responseJsonData =
        await _apiService.getMultipartResponse(url, requestData);
    //String accessToken = responseJsonData['access_token'];
    if (AppConstants.kDebugMode) {
      print("Access Token: $responseJsonData");
    }
    //print("Access Token: $responseJsonData");
    return responseJsonData;
  }
}
 */