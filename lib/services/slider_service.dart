import 'package:study_evaluation/services/api_service.dart';
import 'package:study_evaluation/utils/app_utils.dart';

import '../utils/app_constants.dart';

class SliderImageService {
  static final APIService _apiService = APIService();
  Future<dynamic> fetch() async {
    //Map<String, String> requestData = {'email': username, 'password': password};
    String url = AppConstants.baseUrl + AppConstants.appearanceAPIPath;

    print("URL: ${url.toString()}");
    var token = await AppUtil().getToken();
    final responseJsonData = await _apiService.getResponse(url, token!);
    //String accessToken = responseJsonData['access_token'];
    if (AppConstants.kDebugMode) {
      print("responseJsonData: $responseJsonData");
    }
    //print("Access Token: $responseJsonData");
    return responseJsonData;
  }
}
