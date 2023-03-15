import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class Package extends BaseModel {
  String? id;
  String? categoryId;
  String? category;
  String? title;
  String? publishType;
  String? packageType;
  dynamic fullLineTests;
  dynamic topicWiseTests;
  String? totalPdfs;
  String? totalVideos;
  String? totalQuestions;
  String? listPrice;
  String? originalPrice;
  String? validity;
  String? description;
  String? logoUrl;
  String? status;
  String? validityStatus;

  Package(
      {this.id,
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
      this.status,
      super.error,
      super.appException,
      this.validityStatus,
      this.category});

  String getShortDescription(int start, {int? end}) {
    int? len = description?.length;
    if (end != null) {
      if (len! < end) {
        return description!;
      }
    } else {
      if (len! < start) {
        return description!;
      }
    }
    if (end != null) {
      return "${(description?.substring(start, end))!}...";
    } else {
      return "${(description?.substring(start))!}...";
    }
  }

  factory Package.fromMap(Map<String, dynamic> data) => Package(
        id: data['id'] as String?,
        categoryId: data['category_id'] as String?,
        category: data['category'] as String?,
        title: data['title'] as String?,
        publishType: data['publish_type'] as String?,
        packageType: data['package_type'] as String?,
        fullLineTests: data['full_line_tests'] as dynamic,
        topicWiseTests: data['topic_wise_tests'] as dynamic,
        totalPdfs: data['total_pdfs'] as String?,
        totalVideos: data['total_videos'] as String?,
        totalQuestions: data['total_questions'] as String?,
        listPrice: data['list_price'] as String?,
        originalPrice: data['original_price'] as String?,
        validity: data['validity'] as String?,
        description: data['description'] as String?,
        logoUrl: data['logo_url'] as String?,
        status: data['status'] as String?,
        validityStatus: data['validityStatus'] as String?,
      );

  @override
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
        'logo_url': logoUrl,
        'status': status,
        'validityStatus': validityStatus
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Package].
  @override
  factory Package.fromJson(String data) {
    return Package.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  @override
  BaseModel fromMap(Map<String, dynamic> data) {
    return Package.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Converts [Package] to a JSON string.

  String toJson() => json.encode(toMap());
}
