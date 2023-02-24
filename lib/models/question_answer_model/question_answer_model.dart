import 'dart:convert';

import 'exam.dart';
import 'question.dart';

class QuestionAnswerModel {
  Exam? exam;
  List<Question>? questions;

  QuestionAnswerModel({this.exam, this.questions});

  factory QuestionAnswerModel.fromMap(Map<String, dynamic> data) {
    return QuestionAnswerModel(
      exam: data['exam'] == null
          ? null
          : Exam.fromMap(data['exam'] as Map<String, dynamic>),
      questions: (data['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'exam': exam?.toMap(),
        'questions': questions?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QuestionAnswerModel].
  factory QuestionAnswerModel.fromJson(String data) {
    return QuestionAnswerModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [QuestionAnswerModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
