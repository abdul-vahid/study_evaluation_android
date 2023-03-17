import 'dart:convert';

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
  String? profileUrl;
  String? studentId;

  String? firstName;
  String? lastName;
  String? dob;
  String? gender;

  String? city;
  String? state;
  String? role;

  UserModel(
      {this.id,
      this.roleId,
      this.name,
      this.email,
      this.mobileNo,
      this.status,
      this.password,
      this.userName,
      this.profileUrl,
      this.studentId,
      this.firstName,
      this.lastName,
      this.dob,
      this.gender,
      this.city,
      this.state,
      this.role,
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
        profileUrl: data['profile_url'] as String?,
        studentId: data['student_id'] as String?,
        firstName: data['first_name'] as String?,
        lastName: data['last_name'] as String?,
        dob: data['dob'] as String?,
        gender: data['gender'] as String?,
        city: data['city'] as String?,
        state: data['state'] as String?,
        role: data['role'] as String?,
      );
  String get fullName {
    if (firstName != null && lastName != null) {
      return "$firstName $lastName";
    } else {
      return name!;
    }
  }

  @override
  BaseModel fromMap(Map<String, dynamic> data) {
    return UserModel.fromMap(data);
  }

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'role_id': roleId,
        'name': name,
        'email': email,
        'username': userName,
        'mobile_no': mobileNo,
        'status': status,
        'profile_url': profileUrl,
        'student_id': studentId,
        'first_name': firstName,
        'last_name': lastName,
        'dob': dob,
        'gender': gender,
        'city': city,
        'state': state,
        'role': role,
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
