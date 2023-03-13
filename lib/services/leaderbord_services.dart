import 'package:study_evaluation/services/api_service.dart';
import 'package:study_evaluation/utils/app_constants.dart';

import '../utils/app_utils.dart';

class LeaderBoardService {
  static final APIService _apiService = APIService();
  Future<dynamic> fetch({String examId = "152"}) async {
    //Map<String, String> requestData = {'email': username, 'password': password};
    String url = AppConstants.baseUrl + AppConstants.leaderboardAPIPath;
    if (examId.isNotEmpty) {
      url += "/$examId";
    }
    //print("URL: ${url.toString()}");
    var token = await AppUtils.getToken();
    final responseJsonData = await _apiService.getResponse(url, token!);

    //print("Access Token: $responseJsonData");
    return responseJsonData;
  }
}
