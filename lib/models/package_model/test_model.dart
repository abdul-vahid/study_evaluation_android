import 'dart:convert';

class TestModel {
  String? id;
  String? packageId;
  String? type;
  String? examId;
  String? title;
  String? announcementDate;
  String? scheduledDate;
  String? duration;
  String? attemptLimit;
  String? status;

  TestModel({
    this.id,
    this.packageId,
    this.type,
    this.examId,
    this.title,
    this.announcementDate,
    this.scheduledDate,
    this.duration,
    this.attemptLimit,
    this.status,
  });

  factory TestModel.fromMap(Map<String, dynamic> data) => TestModel(
        id: data['id'] as String?,
        packageId: data['package_id'] as String?,
        type: data['type'] as String?,
        examId: data['exam_id'] as String?,
        title: data['title'] as String?,
        announcementDate: data['announcement_date'] as String?,
        scheduledDate: data['scheduled_date'] as String?,
        duration: data['duration'] as String?,
        attemptLimit: data['attempt_limit'] as String?,
        status: data['status'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'package_id': packageId,
        'type': type,
        'exam_id': examId,
        'title': title,
        'announcement_date': announcementDate,
        'scheduled_date': scheduledDate,
        'duration': duration,
        'attempt_limit': attemptLimit,
        'status': status,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TestModel].
  factory TestModel.fromJson(String data) {
    return TestModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TestModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
