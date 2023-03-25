import 'dart:convert';

import '../../core/models/base_model.dart';

class FreeContentPackageModel extends BaseModel {
  String? id;
  String? categoryId;
  String? category;
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
  String? plainDescription;
  String? logoUrl;
  String? status;
  String? validityStatus;

  FreeContentPackageModel(
      {this.id,
      this.categoryId,
      this.category,
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
      this.plainDescription,
      this.logoUrl,
      this.status,
      this.validityStatus,
      super.error,
      super.appException});

  String getShortDescription(int start, {int? end}) {
    int? len = plainDescription?.length;
    if (end != null) {
      if (len! < end) {
        return plainDescription!;
      }
    } else {
      if (len! < start) {
        return plainDescription!;
      }
    }
    if (end != null) {
      return "${(plainDescription?.substring(start, end))!}...";
    } else {
      return "${(plainDescription?.substring(start))!}...";
    }
  }

  @override
  factory FreeContentPackageModel.fromMap(Map<String, dynamic> data) {
    return FreeContentPackageModel(
      id: data['id'] as String?,
      categoryId: data['category_id'] as String?,
      category: data['category'] as String?,
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
      plainDescription: data['plain_description'] as String?,
      logoUrl: data['logo_url'] as String?,
      status: data['status'] as String?,
      validityStatus: data['validity_status'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'category_id': categoryId,
        'category': category,
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
        'plain_description': plainDescription,
        'logo_url': logoUrl,
        'status': status,
        'validity_status': validityStatus,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [FreeContentPackageModel].
  @override
  factory FreeContentPackageModel.fromJson(String data) {
    return FreeContentPackageModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  @override
  BaseModel fromMap(Map<String, dynamic> data) {
    return FreeContentPackageModel.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Converts [FreeContentPackageModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
