import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/view_models/user_view_model/user_list_vm.dart';

class UserController {
  var context;
  UserController(this.context);

  Future<dynamic> signUp(UserModel userModel) async {
    var result = await UserListViewModel().signup(userModel);
    print(result);
    return result;
  }

  Future<List<dynamic>> login(String username, String password) async {
    return await UserListViewModel().login(username, password);
  }
}
