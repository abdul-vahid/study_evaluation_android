import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/services/login_service.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/viewmodel/user_view_model/user_list_vm.dart';

class UserController {
  var context;
  UserController(this.context);

  Future<dynamic> signUp(UserModel userModel) async {
    var result = await UserListViewModel().signup(userModel);
    print(result);
    return result;
  }

  Future<List<dynamic>> login(String username, String password) async {
    print("loggin called");
    return await UserListViewModel().login(username, password);
  }
}
