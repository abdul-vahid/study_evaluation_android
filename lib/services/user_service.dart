import 'dart:convert';

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
    print(body);
    final responseJsonData = await _apiService.postResponse(url, body, token);
    //String accessToken = responseJsonData['access_token'];
    if (AppConstants.kDebugMode) {
      print("responseJsonData: $responseJsonData");
    }
    //print("Access Token: $responseJsonData");
    return responseJsonData;
  }

  Future<dynamic> login(String username, String password) async {
    Map<String, String> requestData = {
      'username': username,
      'password': password
    };
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

  Future<dynamic> updateStudentProfile(UserModel userModel) async {
    String url = AppUtils.getUrl(
        "${AppConstants.studentProfileAPIPath}/${userModel.studentId}");

    var token = await AppUtils.getToken();
    var body = userModel.toJson();
    print(body);
    final responseJsonData = await _apiService.postResponse(url, body, token!);
    //String accessToken = responseJsonData['access_token'];
    if (AppConstants.kDebugMode) {
      print("responseJsonData: $responseJsonData");
    }
    //print("Access Token: $responseJsonData");
    return responseJsonData;
  }

  Future<dynamic> getOTP(String mobileNo, String reason) async {
    String url = AppUtils.getUrl("${AppConstants.otpVerificationAPIPath}");
    print('url@@ ${url}');
    Map<String, String> requestData = {
      'contact_number': mobileNo,
      'reason': reason
    };

    var token = await AppUtils.getToken();
    var body = jsonEncode(requestData);
    print('body@@ ${body}');
    final responseJsonData = await _apiService.postResponse(url, body, '');
    //String accessToken = responseJsonData['access_token'];
    if (AppConstants.kDebugMode) {
      print("responseJsonData: $responseJsonData");
    }
    print("Otp@@: $responseJsonData");
    return responseJsonData;
  }

  Future<dynamic> changePassword(String mobileNo, String password) async {
    String url = AppUtils.getUrl("${AppConstants.changePasswordAPIPath}");
    print('url@@ ${url}');
    Map<String, String> requestData = {
      'username': mobileNo,
      'password': password
    };

    var token = await AppUtils.getToken();
    var body = jsonEncode(requestData);
    print('body@@ ${body}');
    final responseJsonData = await _apiService.postResponse(url, body, token!);
    //String accessToken = responseJsonData['access_token'];
    if (AppConstants.kDebugMode) {
      print("responseJsonData: $responseJsonData");
    }
    print("changepassword@@: $responseJsonData");
    return responseJsonData;
  }
}
