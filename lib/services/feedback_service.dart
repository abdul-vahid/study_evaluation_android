import 'package:study_evaluation/services/api_service.dart';
import '../utils/app_constants.dart';

class FeedbackService {
  static final APIService _apiService = APIService();
  Future<dynamic> fetch() async {
    //Map<String, String> requestData = {'email': username, 'password': password};
    String url = AppConstants.baseUrl + AppConstants.feedbackAPIPath;

    print("URL: ${url.toString()}");
    var token = "";
    final responseJsonData = await _apiService.getResponse(url, token);
    //String accessToken = responseJsonData['access_token'];
    if (AppConstants.kDebugMode) {
      print("responseJsonData: $responseJsonData");
    }
    //print("Access Token: $responseJsonData");
    return responseJsonData;
  }
}
