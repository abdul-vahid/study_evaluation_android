import 'dart:convert';

class Exam {
  String? id;
  String? title;
  String? announcementDate;
  String? scheduledDate;
  String? duration;
  String? attemptLimit;
  String? status;
  String? remainingExamTime;
  String? resultId;

  Exam(
      {this.id,
      this.title,
      this.announcementDate,
      this.scheduledDate,
      this.duration,
      this.attemptLimit,
      this.status,
      this.remainingExamTime,
      this.resultId});

  factory Exam.fromMap(Map<String, dynamic> data) => Exam(
        id: data['id'] as String?,
        title: data['title'] as String?,
        announcementDate: data['announcement_date'] as String?,
        scheduledDate: data['scheduled_date'] as String?,
        duration: data['duration'] as String?,
        attemptLimit: data['attempt_limit'] as String?,
        status: data['status'] as String?,
        remainingExamTime: data['remaining_exam_time'] as String?,
        resultId: data['result_id'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'announcement_date': announcementDate,
        'scheduled_date': scheduledDate,
        'duration': duration,
        'attempt_limit': attemptLimit,
        'status': status,
        'remaining_exam_time': remainingExamTime,
        'result_id': resultId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Exam].
  factory Exam.fromJson(String data) {
    return Exam.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Exam] to a JSON string.
  String toJson() => json.encode(toMap());
}
