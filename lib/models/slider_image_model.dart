import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class SliderImageModel extends BaseModel {
  String? id;
  String? title;
  String? description;
  String? type;
  String? redirectUrl;
  String? sliderUrl;
  String? status;
  dynamic orderNumber;
  String? createdDate;
  String? updatedDate;
  String? createdBy;
  String? updatedBy;

  SliderImageModel(
      {this.id,
      this.title,
      this.description,
      this.type,
      this.redirectUrl,
      this.sliderUrl,
      this.status,
      this.orderNumber,
      this.createdDate,
      this.updatedDate,
      this.createdBy,
      this.updatedBy,
      super.appException,
      super.error});

  factory SliderImageModel.fromMap(Map<String, dynamic> data) =>
      SliderImageModel(
        id: data['id'] as String?,
        title: data['title'] as String?,
        description: data['description'] as String?,
        type: data['type'] as String?,
        redirectUrl: data['redirect_url'] as String?,
        sliderUrl: data['slider_url'] as String?,
        status: data['status'] as String?,
        orderNumber: data['order_number'] as dynamic,
        createdDate: data['created_date'] as String?,
        updatedDate: data['updated_date'] as String?,
        createdBy: data['created_by'] as String?,
        updatedBy: data['updated_by'] as String?,
      );
  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'type': type,
        'redirect_url': redirectUrl,
        'slider_url': sliderUrl,
        'status': status,
        'order_number': orderNumber,
        'created_date': createdDate,
        'updated_date': updatedDate,
        'created_by': createdBy,
        'updated_by': updatedBy,
      };

  @override
  BaseModel fromMap(Map<String, dynamic> data) {
    return SliderImageModel.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Record].
  @override
  factory SliderImageModel.fromJson(String data) {
    return SliderImageModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Record] to a JSON string.
  String toJson() => json.encode(toMap());
}
