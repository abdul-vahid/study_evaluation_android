import 'package:study_evaluation/services/api_service.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/utils/function_lib.dart';

class BaseService {
  static final APIService _apiService = APIService();
  Future<dynamic> get({required String url}) async {
    var token = await AppUtils.getToken();

    final responseJsonData = await _apiService.getResponse(url, token!);
    return responseJsonData;
  }

  Future<dynamic> post({required String url, required String body}) async {
    var token = await AppUtils.getToken();
    token ??= "";
    printLongString("body = $body");
    final responseJsonData = await _apiService.postResponse(url, body, token);
    //debug("responseJsonData: $responseJsonData");
    return responseJsonData;
  }

  /// Print Long String
  void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(text)
        .forEach((RegExpMatch match) => debug(match.group(0)));
  }
}
