/* import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class UserModel extends BaseModel {
  String? id;
  String? roleId;
  String? name;
  String? email;
  String? mobileNo;
  String? status;
  String? password;
  String? userName;

  UserModel(
      {this.id,
      this.roleId,
      this.name,
      this.email,
      this.mobileNo,
      this.status,
      this.password,
      this.userName,
      super.appException,
      super.error});

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        id: data['id'] as String?,
        roleId: data['role_id'] as String?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        userName: data['username'] as String?,
        mobileNo: data['mobile_no'] as String?,
        status: data['status'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'role_id': roleId,
        'name': name,
        'email': email,
        'username': userName,
        'mobile_no': mobileNo,
        'status': status,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory UserModel.fromJson(String data) {
    return UserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() {
    if (password == null || password!.isEmpty) {
      return json.encode(toMap());
    } else {
      var mapResult = toMap();
      mapResult['password'] = password;
      return json.encode(mapResult);
    }
  }
}
 */
