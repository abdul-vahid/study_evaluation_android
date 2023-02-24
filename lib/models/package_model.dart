import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class PackageModel extends BaseModel {
  String? categoriesId;
  String? id;
  String? categoryId;
  String? title;
  String? publishType;
  String? packageType;
  String? fullLineTests;
  String? topicWiseTests;
  String? totalPdfs;
  String? totalVideos;
  String? totalQuestions;
  String? listPrice;
  String? originalPrice;
  String? validity;
  String? description;
  String? logoUrl;
  String? createdDate;
  String? updatedDate;
  String? createdBy;
  String? updatedBy;
  String? status;

  PackageModel(
      {this.categoriesId,
      this.id,
      this.categoryId,
      this.title,
      this.publishType,
      this.packageType,
      this.fullLineTests,
      this.topicWiseTests,
      this.totalPdfs,
      this.totalVideos,
      this.totalQuestions,
      this.listPrice,
      this.originalPrice,
      this.validity,
      this.description,
      this.logoUrl,
      this.createdDate,
      this.updatedDate,
      this.createdBy,
      this.updatedBy,
      this.status,
      super.error,
      super.appException});

  factory PackageModel.fromMap(Map<String, dynamic> data) => PackageModel(
        categoriesId: data['categoriesId'] as String?,
        id: data['id'] as String?,
        categoryId: data['category_id'] as String?,
        title: data['title'] as String?,
        publishType: data['publish_type'] as String?,
        packageType: data['package_type'] as String?,
        fullLineTests: data['full_line_tests'] as String?,
        topicWiseTests: data['topic_wise_tests'] as String?,
        totalPdfs: data['total_pdfs'] as String?,
        totalVideos: data['total_videos'] as String?,
        totalQuestions: data['total_questions'] as String?,
        listPrice: data['list_price'] as String?,
        originalPrice: data['original_price'] as String?,
        validity: data['validity'] as String?,
        description: data['description'] as String?,
        logoUrl: data['logo_url'] as String?,
        createdDate: data['created_date'] as String?,
        updatedDate: data['updated_date'] as String?,
        createdBy: data['created_by'] as String?,
        updatedBy: data['updated_by'] as String?,
        status: data['status'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'categoriesId': categoriesId,
        'id': id,
        'category_id': categoryId,
        'title': title,
        'publish_type': publishType,
        'package_type': packageType,
        'full_line_tests': fullLineTests,
        'topic_wise_tests': topicWiseTests,
        'total_pdfs': totalPdfs,
        'total_videos': totalVideos,
        'total_questions': totalQuestions,
        'list_price': listPrice,
        'original_price': originalPrice,
        'validity': validity,
        'description': description,
        'logo_url': logoUrl,
        'created_date': createdDate,
        'updated_date': updatedDate,
        'created_by': createdBy,
        'updated_by': updatedBy,
        'status': status,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PackageModel].
  factory PackageModel.fromJson(String data) {
    return PackageModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PackageModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
