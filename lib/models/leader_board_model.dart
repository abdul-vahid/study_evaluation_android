import 'dart:convert';

import '../core/models/base_model.dart';

class LeaderBoardModel extends BaseModel {
  String? firstName;
  String? lastName;
  String? profileUrl;
  String? percentage;
  String? totalMarks;

  LeaderBoardModel(
      {this.firstName,
      this.lastName,
      this.profileUrl,
      this.percentage,
      this.totalMarks,
      super.appException,
      super.error});

  factory LeaderBoardModel.fromMap(Map<String, dynamic> data) {
    return LeaderBoardModel(
      firstName: data['first_name'] as String?,
      lastName: data['last_name'] as String?,
      profileUrl: data['profile_url'] as String?,
      percentage: data['percentage'] as String?,
      totalMarks: data['total_marks'] as String?,
    );
  }
  @override
  Map<String, dynamic> toMap() => {
        'first_name': firstName,
        'last_name': lastName,
        'profile_url': profileUrl,
        'percentage': percentage,
        'total_marks': totalMarks,
      };

  @override
  BaseModel fromMap(Map<String, dynamic> data) {
    return LeaderBoardModel.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LeaderBoardModel].
  factory LeaderBoardModel.fromJson(String data) {
    return LeaderBoardModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LeaderBoardModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
