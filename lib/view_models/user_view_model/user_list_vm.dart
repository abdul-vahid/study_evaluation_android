import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/utils/function_lib.dart';
import 'package:study_evaluation/view_models/user_view_model/user_vm.dart';

class UserListViewModel extends BaseListViewModel {
  String? name;

  Future<dynamic> signup(UserModel userModel) async {
    String url = AppUtils.getUrl(AppConstants.signupAPIPath);
    // debug(userModel.toJson());
    return await post(url: url, body: userModel.toJson());
  }

  Future<dynamic> registerFCMToken(String token) async {
    String url = AppUtils.getUrl(AppConstants.registerFCMTokenAPIPath);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userModel = AppUtils.getSessionUser(prefs);
    Map<String, String> body = {
      "registration_id": token,
      "user_id": userModel?.id ?? ""
    };
    return post(url: url, body: jsonEncode(body));
  }

  Future<dynamic> updateStudentProfile(UserModel userModel) async {
    String url = AppUtils.getUrl(
        "${AppConstants.studentProfileAPIPath}/${userModel.studentId}");

    return await post(url: url, body: userModel.toJson());
  }

  Future<dynamic> getOTP(String mobileNo, String reason) async {
    String url = AppUtils.getUrl(AppConstants.otpVerificationAPIPath);
    Map<String, String> requestData = {
      'contact_number': mobileNo,
      'reason': reason
    };
    var records = await post(url: url, body: jsonEncode(requestData));
    return records["message"];
  }

  Future<dynamic> updateProfilePicture(
      String userId, String profilePicture) async {
    String url = AppUtils.getUrl(AppConstants.profilePictureUpdateAPIPath);
    Map<String, String> requestData = {'id': userId, 'body': profilePicture};
    var records = await post(url: url, body: jsonEncode(requestData));
    return records["records"]['profile_url'];
  }

  Future<dynamic> changePasword(String mobileNo, String password) async {
    String url = AppUtils.getUrl(AppConstants.changePasswordAPIPath);

    Map<String, String> requestData = {
      'username': mobileNo,
      'password': password
    };

    var records = await post(url: url, body: jsonEncode(requestData));
    return records["message"];
  }

  Future<List<dynamic>> login(String username, String password) async {
    //final result = await UserService().login(username, password);
    String url = AppUtils.getUrl(AppConstants.loginAPIPath);
    Map<String, String> requestData = {
      'username': username,
      'password': password
    };

    final result = await post(url: url, body: jsonEncode(requestData));
    final records = result["records"];
    var loginModelMap = records.map((item) => UserModel.fromMap(item)).toList();
    if (loginModelMap.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
          SharedPrefsConstants.accessTokenKey, result["access_token"]);
      await prefs.setString(
          SharedPrefsConstants.refreshTokenKey, result["refresh_token"]);
      await prefs.setString(SharedPrefsConstants.profileUrlKey,
          loginModelMap[0].profileUrl ?? "");
      await prefs.setString(
          SharedPrefsConstants.mobileNoKey, loginModelMap[0].mobileNo ?? "");
      await prefs.setString(
          SharedPrefsConstants.nameKey, loginModelMap[0].name ?? "");
      await prefs.setString(
          SharedPrefsConstants.userKey, loginModelMap[0].toJson());
      var sessionTime = DateTime.now().toString();

      await prefs.setString(SharedPrefsConstants.sessionTimeKey, sessionTime);
    }
    return loginModelMap.map((item) => UserViewModel(model: item)).toList();
  }
}
