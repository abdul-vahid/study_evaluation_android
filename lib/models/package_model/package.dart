import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class Package extends BaseModel {
  String? id;
  String? categoryId;
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

  Package({
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
    this.status,
  });

  factory Package.fromMap(Map<String, dynamic> data) => Package(
        id: data['id'] as String?,
        categoryId: data['category_id'] as String?,
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
      );

  Map<String, dynamic> toMap() => {
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
        'status': status,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Package].
  factory Package.fromJson(String data) {
    return Package.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Package] to a JSON string.
  String toJson() => json.encode(toMap());
}
