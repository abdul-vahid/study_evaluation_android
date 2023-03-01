import 'package:study_evaluation/models/feedback_model.dart';
import 'package:study_evaluation/services/api_service.dart';
import '../utils/app_constants.dart';
import '../utils/app_utils.dart';

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

  Future<dynamic> submitFeedback(FeedbackModel feedbackModel) async {
    String url = AppConstants.baseUrl + AppConstants.feedbackAPIPath;
    var token = await AppUtil().getToken();
    var body = feedbackModel.toJson();
    print(body);
    final responseJsonData = await _apiService.postResponse(url, body, token!);
    //String accessToken = responseJsonData['access_token'];
    if (AppConstants.kDebugMode) {
      print("responseJsonData: $responseJsonData");
    }
    //print("Access Token: $responseJsonData");
    return responseJsonData;
  }
}
