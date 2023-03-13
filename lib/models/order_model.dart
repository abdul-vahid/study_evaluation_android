import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class OrderModel extends BaseModel {
  String? packagesTitle;
  String? logoUrl;
  String? name;
  String? packageId;
  String? studentId;
  String? status;
  String? createdDate;
  String? expiryDate;
  String? amount;
  String? currentStatus;
  String? validity;
  String? orderNumber;
  String? paymentType;
  String? paymentStatus;

  OrderModel(
      {this.packagesTitle,
      this.logoUrl,
      this.name,
      this.packageId,
      this.studentId,
      this.status,
      this.createdDate,
      this.expiryDate,
      this.amount,
      this.currentStatus,
      this.validity,
      this.orderNumber,
      this.paymentType,
      this.paymentStatus,
      super.appException,
      super.error});

  factory OrderModel.fromMap(Map<String, dynamic> data) => OrderModel(
        packagesTitle: data['packages_title'] as String?,
        logoUrl: data['logo_url'] as String?,
        name: data['name'] as String?,
        packageId: data['package_id'] as String?,
        studentId: data['student_id'] as String?,
        status: data['status'] as String?,
        createdDate: data['created_date'] as String?,
        expiryDate: data['expiry_date'] as String?,
        amount: data['amount'] as String?,
        currentStatus: data['current_status'] as String?,
        validity: data['validity'] as String?,
        orderNumber: data['order_number'] as String?,
        paymentType: data['payment_type'] as String?,
        paymentStatus: data['payment_status'] as String?,
      );

  @override
  BaseModel fromMap(Map<String, dynamic> data) {
    return OrderModel.fromMap(data);
  }

  @override
  Map<String, dynamic> toMap() => {
        'packages_title': packagesTitle,
        'logo_url': logoUrl,
        'name': name,
        'package_id': packageId,
        'student_id': studentId,
        'status': status,
        'created_date': createdDate,
        'expiry_date': expiryDate,
        'amount': amount,
        'current_status': currentStatus,
        'validity': validity,
        'order_number': orderNumber,
        'payment_type': paymentType,
        'payment_status': paymentStatus,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderModel].
  factory OrderModel.fromJson(String data) {
    return OrderModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderModel] to a JSON string.
  ///

  String toJson() => json.encode(toMap());
}
