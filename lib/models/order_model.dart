import 'dart:convert';

class OrderModel {
  String? packagesTitle;
  String? logoUrl;
  String? name;
  String? packageId;
  String? studentId;
  String? status;
  String? createdDate;
  String? expiryDate;

  OrderModel({
    this.packagesTitle,
    this.logoUrl,
    this.name,
    this.packageId,
    this.studentId,
    this.status,
    this.createdDate,
    this.expiryDate,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data) => OrderModel(
        packagesTitle: data['packages_title'] as String?,
        logoUrl: data['logo_url'] as String?,
        name: data['name'] as String?,
        packageId: data['package_id'] as String?,
        studentId: data['student_id'] as String?,
        status: data['status'] as String?,
        createdDate: data['created_date'] as String?,
        expiryDate: data['expiry_date'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'packages_title': packagesTitle,
        'logo_url': logoUrl,
        'name': name,
        'package_id': packageId,
        'student_id': studentId,
        'status': status,
        'created_date': createdDate,
        'expiry_date': expiryDate,
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
  String toJson() => json.encode(toMap());
}
