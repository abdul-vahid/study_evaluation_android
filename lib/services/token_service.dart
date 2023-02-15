import 'package:study_evaluation/services/api_service.dart';

import '../utils/app_constants.dart';

class TokenService {
  final APIService _apiService = APIService();
  Future<dynamic> getToken() async {
    /*
    Map<String, String> requestData = {
      'grant_type': 'password',
      'client_id': Constants.clientId,
      'client_secret': Constants.clientSecret,
      'username': Constants.userName,
      'password': Constants.password
    };
    String url = Constants.baseUrl + Constants.tokenPath;
    final responseJsonData =
        await _apiService.getMultipartResponse(url, requestData);
    String accessToken = responseJsonData['access_token'];
    if (Constants.kDebugMode) {
      print("Access Token: $accessToken");
    }
    return accessToken;
    */
  }
}
