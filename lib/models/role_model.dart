import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class RoleModel extends BaseModel {
  String? id;
  String? role;
  String? status;

  RoleModel({this.id, this.role, this.status, super.appException, super.error});

  factory RoleModel.fromMap(Map<String, dynamic> data) => RoleModel(
        id: data['id'] as String?,
        role: data['role'] as String?,
        status: data['status'] as String?,
      );

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'role': role,
        'status': status,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RoleModel].
  factory RoleModel.fromJson(String data) {
    return RoleModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RoleModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
