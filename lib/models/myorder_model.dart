/*import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class MyorderModel extends BaseModel {
  String? id;
  String? studentFirstName;
  String? studentLastName;
  String? studentId;
  String? packageId;
  String? orderNumber;
  String? orderDate;
  String? orderExpiryDate;
  String? amount;
  String? paymentStatus;
  String? paymentType;
  String? createdDate;
  String? updatedDate;
  String? createdBy;
  String? updatedBy;
  String? packageTitle;

  MyorderModel({
    this.id,
    this.studentFirstName,
    this.studentLastName,
    this.studentId,
    this.packageId,
    this.orderNumber,
    this.orderDate,
    this.orderExpiryDate,
    this.amount,
    this.paymentStatus,
    this.paymentType,
    this.createdDate,
    this.updatedDate,
    this.createdBy,
    this.updatedBy,
    this.packageTitle,
  });

  factory MyorderModel.fromMap(Map<String, dynamic> data) => MyorderModel(
        id: data['id'] as String?,
        studentFirstName: data['name'] as String?,
        studentLastName: data['status'] as String?,
        studentId: data['order_number'] as String?,
        packageId: data['logo_url'] as String?,
        orderNumber: data['created_date'] as String?,
        orderDate: data['updated_date'] as String?,
        orderExpiryDate: data['created_by'] as String?,
        amount: data['updated_by'] as String?,
        paymentStatus: data['updated_by'] as String?,
        paymentType: data['updated_by'] as String?,
        createdDate: data['updated_by'] as String?,
        updatedDate: data['updated_by'] as String?,
        createdBy: data['updated_by'] as String?,
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
} */
