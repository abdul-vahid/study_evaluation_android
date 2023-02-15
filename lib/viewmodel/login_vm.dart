import 'package:study_evaluation/models/login_model/login_model.dart';

class LoginViewModel {
  final LoginModel loginModel;

  LoginViewModel({required this.loginModel});

  LoginModel get loginViewModel {
    return loginModel;
  }
}
