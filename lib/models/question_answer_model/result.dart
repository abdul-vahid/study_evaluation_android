import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class Result extends BaseModel {
  String? id;
  String? examId;
  String? studentId;
  String? status;
  String? isPrimary;
  String? percentage;
  String? totalMarks;
  String? positiveMarking;
  String? negativeMarking;
  String? remainingExamTime;
  String? averageTimeQuestion;
  String? attempt;
  String? accuracy;
  String? correctAnswers;
  String? ranks;
  String? totalEarnedMarks;
  String? correctQuestionCount;
  String? incorrectQuestionCount;

  Result(
      {this.id,
      this.examId,
      this.studentId,
      this.status,
      this.isPrimary,
      this.percentage,
      this.totalMarks,
      this.positiveMarking,
      this.negativeMarking,
      this.remainingExamTime,
      this.averageTimeQuestion,
      this.attempt,
      this.accuracy,
      this.ranks,
      this.correctAnswers,
      this.totalEarnedMarks,
      this.correctQuestionCount,
      this.incorrectQuestionCount,
      super.appException,
      super.error});

  factory Result.fromMap(Map<String, dynamic> data) => Result(
        id: data['id'] as String?,
        examId: data['exam_id'] as String?,
        studentId: data['student_id'] as String?,
        status: data['status'] as String?,
        isPrimary: data['is_primary'] as String?,
        percentage: data['percentage'] as String?,
        totalMarks: data['total_marks'] as String?,
        positiveMarking: data['positive_marking'] as String?,
        negativeMarking: data['negative_marking'] as String?,
        remainingExamTime: data['remaining_exam_time'] as String?,
        averageTimeQuestion: data['average_time_question'] as String?,
        attempt: data['attempt'] as String?,
        accuracy: data['accuracy'] as String?,
        correctAnswers: data['correct_answers'] as String?,
        ranks: data['ranks'] as String?,
        totalEarnedMarks: data['total_earned_marks'] as String?,
        correctQuestionCount: data['correct_question_count'] as String?,
        incorrectQuestionCount: data['incorrect_question_count'] as String?,
      );

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'exam_id': examId,
        'student_id': studentId,
        'status': status,
        'is_primary': isPrimary,
        'percentage': percentage,
        'total_marks': totalMarks,
        'positive_marking': positiveMarking,
        'negative_marking': negativeMarking,
        'remaining_exam_time': remainingExamTime,
        'average_time_question': averageTimeQuestion,
        'attempt': attempt,
        'accuracy': accuracy,
        'correct_answers': correctAnswers,
        'ranks': ranks,
        'total_earned_marks': totalEarnedMarks,
        'correct_question_count': correctQuestionCount,
        'incorrect_question_count': incorrectQuestionCount,
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
