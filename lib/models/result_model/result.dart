import 'dart:convert';

class Result {
  String? examId;
  String? studentId;
  String? status;
  String? examTime;
  int? id;

  Result({
    this.examId,
    this.studentId,
    this.status,
    this.examTime,
    this.id,
  });

  factory Result.fromMap(Map<String, dynamic> data) => Result(
        examId: data['exam_id'] as String?,
        studentId: data['student_id'] as String?,
        status: data['status'] as String?,
        examTime: data['exam_time'] as String?,
        id: data['id'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'exam_id': examId,
        'student_id': studentId,
        'status': status,
        'exam_time': examTime,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Result].
  factory Result.fromJson(String data) {
    return Result.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Result] to a JSON string.
  String toJson() => json.encode(toMap());
}