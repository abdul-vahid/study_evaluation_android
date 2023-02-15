import 'dart:convert';

import 'user.dart';

class LoginModel {
  String? message;
  User? user;
  String? accessToken;

  LoginModel({this.message, this.user, this.accessToken});

  factory LoginModel.fromMap(Map<String, dynamic> data) => LoginModel(
        message: data['message'] as String?,
        user: data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
        accessToken: data['access_token'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'user': user?.toMap(),
        'access_token': accessToken,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginModel].
  factory LoginModel.fromJson(String data) {
    return LoginModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
