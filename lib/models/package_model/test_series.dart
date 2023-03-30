import 'dart:convert';
import 'result_model.dart';

class TestSeries {
  String? id;
  String? type;
  String? examId;
  String? title;
  String? announcementDate;
  String? scheduledDate;
  String? duration;
  String? attemptLimit;
  String? status;
  String? totalQuestions;
  String? totalMarks;
  String? reattemptCount;
  ResultModel? result;

  TestSeries(
      {this.id,
      this.type,
      this.examId,
      this.title,
      this.announcementDate,
      this.scheduledDate,
      this.duration,
      this.attemptLimit,
      this.status,
      this.totalMarks,
      this.totalQuestions,
      this.result,
      this.reattemptCount});

  bool get showReattemptButton {
    return int.tryParse(attemptLimit ?? "0")! >
        int.tryParse(reattemptCount ?? "0")!;
  }

  factory TestSeries.fromMap(Map<String, dynamic> data) => TestSeries(
        id: data['id'] as String?,
        type: data['type'] as String?,
        examId: data['exam_id'] as String?,
        title: data['title'] as String?,
        announcementDate: data['announcement_date'] as String?,
        scheduledDate: data['scheduled_date'] as String?,
        duration: data['duration'] as String?,
        attemptLimit: data['attempt_limit'] as String?,
        status: data['status'] as String?,
        totalQuestions: data['total_questions'] as String?,
        totalMarks: data['total_marks'] as String,
        reattemptCount: data['reattempt_count'] as String,
        result: data['result'] != null
            ? ResultModel.fromMap(data['result'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'exam_id': examId,
        'title': title,
        'announcement_date': announcementDate,
        'scheduled_date': scheduledDate,
        'duration': duration,
        'attempt_limit': attemptLimit,
        'status': status,
        'total_questions': totalQuestions,
        'total_marks': totalMarks,
        'reattempt_count': reattemptCount,
        'result': result?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TestSeries].
  factory TestSeries.fromJson(String data) {
    return TestSeries.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TestSeries] to a JSON string.
  String toJson() => json.encode(toMap());
}
