/* import 'dart:convert';

import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/services/api_service.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import '../utils/app_constants.dart';

class UserService {
  static final APIService _apiService = APIService();
  Future<dynamic> signup(UserModel userModel) async {
    String url = AppConstants.baseUrl + AppConstants.signupAPIPath;
    var token = "";
    var body = userModel.toJson();
    final responseJsonData = await _apiService.postResponse(url, body, token);
    return responseJsonData;
  }

  Future<dynamic> login(String username, String password) async {
    Map<String, String> requestData = {
      'username': username,
      'password': password
    };
    String url = AppConstants.baseUrl + AppConstants.loginAPIPath;
    final responseJsonData =
        await _apiService.getMultipartResponse(url, requestData);

    return responseJsonData;
  }

  Future<dynamic> updateStudentProfile(UserModel userModel) async {
    String url = AppUtils.getUrl(
        "${AppConstants.studentProfileAPIPath}/${userModel.studentId}");

    var token = await AppUtils.getToken();
    var body = userModel.toJson();
    AppUtils.printDebug(body);
    final responseJsonData = await _apiService.postResponse(url, body, token!);
    AppUtils.printDebug("responseJsonData: $responseJsonData");
    return responseJsonData;
  }

  Future<dynamic> getOTP(String mobileNo, String reason) async {
    String url = AppUtils.getUrl(AppConstants.otpVerificationAPIPath);

    Map<String, String> requestData = {
      'contact_number': mobileNo,
      'reason': reason
    };
    var body = jsonEncode(requestData);
    final responseJsonData = await _apiService.postResponse(url, body, '');
    return responseJsonData;
  }

  Future<dynamic> changePassword(String mobileNo, String password) async {
    String url = AppUtils.getUrl(AppConstants.changePasswordAPIPath);

    Map<String, String> requestData = {
      'username': mobileNo,
      'password': password
    };

    var token = await AppUtils.getToken();
    var body = jsonEncode(requestData);
    final responseJsonData = await _apiService.postResponse(url, body, token!);
    return responseJsonData;
  }
}
 */