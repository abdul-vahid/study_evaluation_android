import 'dart:convert';

import '../core/models/base_model.dart';

class LatestNewsModel extends BaseModel {
  String? id;
  String? title;
  String? status;
  String? pdfUrl;
  String? imageUrl;
  String? videoUrl;
  String? createdDate;
  String? updatedDate;
  String? createdBy;
  String? updateBy;

  LatestNewsModel(
      {this.id,
      this.title,
      this.status,
      this.pdfUrl,
      this.imageUrl,
      this.videoUrl,
      this.createdDate,
      this.updatedDate,
      this.createdBy,
      this.updateBy,
      super.error,
      super.appException});

  factory LatestNewsModel.fromMap(Map<String, dynamic> data) {
    return LatestNewsModel(
      id: data['id'] as String?,
      title: data['title'] as String?,
      status: data['status'] as String?,
      pdfUrl: data['pdf_url'] as String?,
      imageUrl: data['image_url'] as String?,
      videoUrl: data['video_url'] as String?,
      createdDate: data['created_date'] as String?,
      updatedDate: data['updated_date'] as String?,
      createdBy: data['created_by'] as String?,
      updateBy: data['update_by'] as String?,
    );
  }

  @override
  BaseModel fromMap(Map<String, dynamic> data) {
    return LatestNewsModel.fromMap(data);
  }

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'status': status,
        'pdf_url': pdfUrl,
        'image_url': imageUrl,
        'video_url': videoUrl,
        'created_date': createdDate,
        'updated_date': updatedDate,
        'created_by': createdBy,
        'update_by': updateBy,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LatestNewsModel].
  @override
  factory LatestNewsModel.fromJson(String data) {
    return LatestNewsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LatestNewsModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
