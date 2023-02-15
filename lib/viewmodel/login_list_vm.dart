import 'package:flutter/material.dart';
import 'package:study_evaluation/models/login_model/login_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/viewmodel/login_vm.dart';
import 'package:study_evaluation/services/login_service.dart';

class LoginListViewModel {
  List<LoginViewModel> loginViewModels = [];

  Future<void> login(String username, String password) async {
    print("loggin called");
    final result = await LoginService().login(username, password);

    if (AppConstants.kDebugMode) {
      print(result["records"]);
    }
    final records = result["records"];
    var loginModelMap =
        records.map((item) => LoginModel.fromMap(item)).toList();
    loginModelMap = loginModelMap.cast<LoginModel>();
    //var loginModelMap = LoginModel.fromJson(results["user"]);
    //print(loginModelMap);
    var lvm =
        loginModelMap.map((item) => LoginViewModel(loginModel: item)).toList();
    loginViewModels = lvm.cast<LoginViewModel>();

    //notifyListeners();
  }
}
