import 'dart:convert';

import '../core/models/base_model.dart';

class NotificationModel extends BaseModel {
  String? id;
  String? userId;
  String? notificationId;
  String? message;
  String? title;
  String? status;

  NotificationModel(
      {this.id,
      this.userId,
      this.notificationId,
      this.message,
      this.title,
      super.appException,
      super.error,
      this.status});

  factory NotificationModel.fromMap(Map<String, dynamic> data) {
    return NotificationModel(
      id: data['id'] as String?,
      userId: data['user_id'] as String?,
      notificationId: data['notification_id'] as String?,
      message: data['message'] as String?,
      title: data['title'] as String?,
      status: data['status'] as String?,
    );
  }

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'notification_id': notificationId,
        'message': message,
        'title': title,
        'status': status,
      };

  @override
  BaseModel fromMap(Map<String, dynamic> data) {
    return NotificationModel.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NotificationModel].
  factory NotificationModel.fromJson(String data) {
    return NotificationModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NotificationModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
