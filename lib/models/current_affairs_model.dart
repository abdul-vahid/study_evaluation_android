import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class CurrentAffairsModel extends BaseModel {
  String? id;
  String? title;
  String? type;
  String? status;
  String? documentName;
  String? documentUrl;
  String? videoUrl;
  String? createdDate;
  String? updatedDate;
  String? createdBy;
  String? updatesBy;

  CurrentAffairsModel({
    this.id,
    this.title,
    this.type,
    this.status,
    this.documentName,
    this.documentUrl,
    this.videoUrl,
    this.createdDate,
    this.updatedDate,
    this.createdBy,
    this.updatesBy,
  });

  factory CurrentAffairsModel.fromMap(Map<String, dynamic> data) {
    return CurrentAffairsModel(
      id: data['id'] as String?,
      title: data['title'] as String?,
      type: data['type'] as String?,
      status: data['status'] as String?,
      documentName: data['document_name'] as String?,
      documentUrl: data['document_url'] as String?,
      videoUrl: data['video_url'] as String?,
      createdDate: data['created_date'] as String?,
      updatedDate: data['updated_date'] as String?,
      createdBy: data['created_by'] as String?,
      updatesBy: data['updates_by'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'type': type,
        'status': status,
        'document_name': documentName,
        'document_url': documentUrl,
        'video_url': videoUrl,
        'created_date': createdDate,
        'updated_date': updatedDate,
        'created_by': createdBy,
        'updates_by': updatesBy,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CurrentAffairsModel].
  factory CurrentAffairsModel.fromJson(String data) {
    return CurrentAffairsModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CurrentAffairsModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
