import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class CategoryModel extends BaseModel {
  String? id;
  String? name;
  String? status;
  String? orderNumber;
  String? logoUrl;
  String? createdDate;
  String? updatedDate;
  String? createdBy;
  String? updatedBy;

  CategoryModel(
      {this.id,
      this.name,
      this.status,
      this.orderNumber,
      this.logoUrl,
      this.createdDate,
      this.updatedDate,
      this.createdBy,
      this.updatedBy,
      super.appException,
      super.error});

  factory CategoryModel.fromMap(Map<String, dynamic> data) => CategoryModel(
        id: data['id'] as String?,
        name: data['name'] as String?,
        status: data['status'] as String?,
        orderNumber: data['order_number'] as String?,
        logoUrl: data['logo_url'] as String?,
        createdDate: data['created_date'] as String?,
        updatedDate: data['updated_date'] as String?,
        createdBy: data['created_by'] as String?,
        updatedBy: data['updated_by'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'status': status,
        'order_number': orderNumber,
        'logo_url': logoUrl,
        'created_date': createdDate,
        'updated_date': updatedDate,
        'created_by': createdBy,
        'updated_by': updatedBy,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Category].
  factory CategoryModel.fromJson(String data) {
    return CategoryModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Category] to a JSON string.
  String toJson() => json.encode(toMap());
}
