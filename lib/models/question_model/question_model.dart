import 'dart:convert';

import 'exam.dart';
import 'question.dart';

class QuestionModel {
  Exam? exam;
  List<Question>? questions;

  QuestionModel({this.exam, this.questions});

  factory QuestionModel.fromMap(Map<String, dynamic> data) => QuestionModel(
        exam: data['exam'] == null
            ? null
            : Exam.fromMap(data['exam'] as Map<String, dynamic>),
        questions: (data['questions'] as List<dynamic>?)
            ?.map((e) => Question.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'exam': exam?.toMap(),
        'questions': questions?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QuestionModel].
  factory QuestionModel.fromJson(String data) {
    return QuestionModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [QuestionModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
