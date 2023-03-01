import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/services/login_service.dart';
import 'package:study_evaluation/services/user_service.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/view_models/user_view_model/user_vm.dart';

class UserListViewModel {
  var viewModels = [];

  String? name;

  Future<dynamic> signup(UserModel userModel) async {
    print("signup lis");
    return await UserService().signup(userModel);
  }

  Future<List<dynamic>> login(String username, String password) async {
    print("loggin called");
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
