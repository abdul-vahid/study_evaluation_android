import 'dart:convert';

class User {
  String? id;
  String? roleId;
  String? name;
  String? email;
  String? mobileNo;
  String? status;

  User({
    this.id,
    this.roleId,
    this.name,
    this.email,
    this.mobileNo,
    this.status,
  });

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'] as String?,
        roleId: data['role_id'] as String?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        mobileNo: data['mobile_no'] as String?,
        status: data['status'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'role_id': roleId,
        'name': name,
        'email': email,
        'mobile_no': mobileNo,
        'status': status,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
