import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class OrderResponseModel extends BaseModel {
  String? id;
  String? studentId;
  String? packageId;
  String? orderNumber;
  String? transactionId;
  String? orderDate;
  String? paymentStatus;
  String? paymentType;
  String? amount;
  String? orderExpiryDate;

  OrderResponseModel(
      {this.id,
      this.studentId,
      this.packageId,
      this.orderNumber,
      this.transactionId,
      this.orderDate,
      this.paymentStatus,
      this.paymentType,
      this.amount,
      this.orderExpiryDate,
      super.appException,
      super.error});

  factory OrderResponseModel.fromMap(Map<String, dynamic> data) {
    return OrderResponseModel(
      id: data['id'] as String?,
      studentId: data['student_id'] as String?,
      packageId: data['package_id'] as String?,
      orderNumber: data['order_number'] as String?,
      transactionId: data['transaction_id'] as String?,
      orderDate: data['order_date'] as String?,
      paymentStatus: data['payment_status'] as String?,
      paymentType: data['payment_type'] as String?,
      amount: data['amount'] as String?,
      orderExpiryDate: data['order_expiry_date'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'student_id': studentId,
        'package_id': packageId,
        'order_number': orderNumber,
        'transaction_id': transactionId,
        'order_date': orderDate,
        'payment_status': paymentStatus,
        'payment_type': paymentType,
        'amount': amount,
        'order_expiry_date': orderExpiryDate,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderResponseModel].
  factory OrderResponseModel.fromJson(String data) {
    return OrderResponseModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderResponseModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
