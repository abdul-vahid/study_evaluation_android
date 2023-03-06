import 'package:study_evaluation/services/api_service.dart';
import 'package:study_evaluation/utils/app_utils.dart';

import '../utils/app_constants.dart';
import '../utils/app_utils.dart';

class OrderService {
  static final APIService _apiService = APIService();
  Future<dynamic> fetch({String studentId = "152"}) async {
    //Map<String, String> requestData = {'email': username, 'password': password};
    String url = AppConstants.baseUrl + AppConstants.orderAPIPath;
    if (studentId.isNotEmpty) {
      url += "/$studentId=152";
    }
    //print("URL: ${url.toString()}");
    var token = await AppUtils.getToken();
    final responseJsonData = await _apiService.getResponse(url, token!);
    //String accessToken = responseJsonData['access_token'];
    if (AppConstants.kDebugMode) {
      print("responseJsonData: order $responseJsonData");
    }
    //print("Access Token: $responseJsonData");
    return responseJsonData;
  }
}
