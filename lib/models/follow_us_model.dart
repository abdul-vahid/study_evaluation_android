import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class FollowUsModel extends BaseModel {
  String? title;
  String? image;
  String? url;

  FollowUsModel(
      {this.title, this.image, this.url, super.appException, super.error});

  factory FollowUsModel.fromMap(Map<String, dynamic> data) => FollowUsModel(
        title: data['title'] as String?,
        image: data['image'] as String?,
        url: data['url'] as String?,
      );

  @override
  Map<String, dynamic> toMap() => {
        'title': title,
        'image': image,
        'url': url,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [FollowUsModel].
  factory FollowUsModel.fromJson(String data) {
    return FollowUsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [FollowUsModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
