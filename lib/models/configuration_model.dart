import 'dart:convert';

import '../core/models/base_model.dart';

class ConfigurationModel extends BaseModel {
  String? id;
  String? helpLineNumber;

  ConfigurationModel(
      {this.id, this.helpLineNumber, super.appException, super.error});

  factory ConfigurationModel.fromMap(Map<String, dynamic> data) {
    return ConfigurationModel(
      id: data['id'] as String?,
      helpLineNumber: data['help_line_number'] as String?,
    );
  }
  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'help_line_number': helpLineNumber,
      };

  @override
  BaseModel fromMap(Map<String, dynamic> data) {
    return ConfigurationModel.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ConfigurationModel].
  factory ConfigurationModel.fromJson(String data) {
    return ConfigurationModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ConfigurationModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
