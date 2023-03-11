import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/services/login_service.dart';
import 'package:study_evaluation/services/user_service.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view_models/user_view_model/user_vm.dart';

class UserListViewModel extends BaseListViewModel {
  var viewModels = [];

  String? name;

  Future<dynamic> signup(UserModel userModel) async {
    print("signup lis");
    return await UserService().signup(userModel);
  }

  Future<dynamic> updateStudentProfile(UserModel userModel) async {
    String url = AppUtils.getUrl(
        "${AppConstants.studentProfileAPIPath}/${userModel.studentId}");

    return await post(url: url, body: userModel.toJson());
  }

  Future<dynamic> getOTP(String mobileNo, String reason) async {
    var records = await UserService().getOTP(mobileNo, reason);
    return records["message"];
  }

  Future<dynamic> ChangePasword(String mobileNo, String password) async {
    var records = await UserService().changePassword(mobileNo, password);
    return records["message"];
  }

  Future<List<dynamic>> login(String username, String password) async {
    final result = await UserService().login(username, password);
    if (AppConstants.kDebugMode) {
      print(result["records"]);
    }

    final records = result["records"];
    var loginModelMap = records.map((item) => UserModel.fromMap(item)).toList();
    if (loginModelMap.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      print("Access Token@@@ = ${result["access_token"]}");
      await prefs.setString("access_token", result["access_token"]);
      await prefs.setString(
          SharedPrefsConstants.profileUrl, loginModelMap[0].profileUrl);
      await prefs.setString(
          SharedPrefsConstants.mobileNo, loginModelMap[0].mobileNo);
      await prefs.setString(SharedPrefsConstants.name, loginModelMap[0].name);
      await prefs.setString("user", loginModelMap[0].toJson());
    }
    return loginModelMap.map((item) => UserViewModel(model: item)).toList();
  }
}
