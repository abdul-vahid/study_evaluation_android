import 'dart:convert';

class ResultModel {
  String? id;
  String? totalMarks;
  String? studentId;
  String? resultStatus;
  String? percentage;
  String? positiveMarking;
  String? negativeMarking;
  String? averageTimeQuestion;
  String? attempt;
  String? accuracy;
  String? correctAnswers;

  ResultModel({
    this.id,
    this.totalMarks,
    this.studentId,
    this.resultStatus,
    this.percentage,
    this.positiveMarking,
    this.negativeMarking,
    this.averageTimeQuestion,
    this.attempt,
    this.accuracy,
    this.correctAnswers,
  });

  factory ResultModel.fromMap(Map<String, dynamic> data) => ResultModel(
        id: data['id'] as String?,
        totalMarks: data['total_marks'] as String?,
        studentId: data['student_id'] as String?,
        resultStatus: data['result_status'] as String?,
        percentage: data['percentage'] as String?,
        positiveMarking: data['positive_marking'] as String?,
        negativeMarking: data['negative_marking'] as String?,
        averageTimeQuestion: data['average_time_question'] as String?,
        attempt: data['attempt'] as String?,
        accuracy: data['accuracy'] as String?,
        correctAnswers: data['correct_answers'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'total_marks': totalMarks,
        'student_id': studentId,
        'result_status': resultStatus,
        'percentage': percentage,
        'positive_marking': positiveMarking,
        'negative_marking': negativeMarking,
        'average_time_question': averageTimeQuestion,
        'attempt': attempt,
        'accuracy': accuracy,
        'correct_answers': correctAnswers,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ResultModel].
  factory ResultModel.fromJson(String data) {
    return ResultModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ResultModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
