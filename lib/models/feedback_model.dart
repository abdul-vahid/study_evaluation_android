import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class FeedbackModel extends BaseModel {
  String? studentFirstname;
  String? studentLastname;
  String? fullName;
  String? contactNo;
  String? id;
  String? studentId;
  String? reason;
  String? comment;
  String? status;
  String? createdDate;
  String? updatedDate;
  String? createdBy;
  String? updatedBy;

  FeedbackModel(
      {this.studentFirstname,
      this.studentLastname,
      this.fullName,
      this.contactNo,
      this.id,
      this.studentId,
      this.reason,
      this.comment,
      this.status,
      this.createdDate,
      this.updatedDate,
      this.createdBy,
      this.updatedBy,
      super.appException,
      super.error});

  factory FeedbackModel.fromMap(Map<String, dynamic> data) => FeedbackModel(
        studentFirstname: data['student_firstname'] as String?,
        studentLastname: data['student_lastname'] as String?,
        fullName: data['full_name'] as String?,
        contactNo: data['contact_no'] as String?,
        id: data['id'] as String?,
        studentId: data['student_id'] as String?,
        reason: data['reason'] as String?,
        comment: data['comment'] as String?,
        status: data['status'] as String?,
        createdDate: data['created_date'] as String?,
        updatedDate: data['updated_date'] as String?,
        createdBy: data['created_by'] as String?,
        updatedBy: data['updated_by'] as String?,
      );

  @override
  Map<String, dynamic> toMap() => {
        'student_firstname': studentFirstname,
        'student_lastname': studentLastname,
        'full_name': fullName,
        'contact_no': contactNo,
        'id': id,
        'student_id': studentId,
        'reason': reason,
        'comment': comment,
        'status': status,
        'created_date': createdDate,
        'updated_date': updatedDate,
        'created_by': createdBy,
        'updated_by': updatedBy,
      };

  @override
  BaseModel fromMap(Map<String, dynamic> data) {
    return FeedbackModel.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Feedback].
  ///

  @override
  factory FeedbackModel.fromJson(String data) {
    return FeedbackModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Feedback] to a JSON string.
  String toJson() => json.encode(toMap());
}
