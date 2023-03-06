import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

import 'exam.dart';
import 'question_model.dart';

class ExamModel extends BaseModel {
  Exam? exam;
  List<QuestionModel>? questionModels;

  ExamModel({this.exam, this.questionModels, super.appException, super.error});

  @override
  factory ExamModel.fromMap(Map<String, dynamic> data) {
    return ExamModel(
      exam: data['exam'] == null
          ? null
          : Exam.fromMap(data['exam'] as Map<String, dynamic>),
      questionModels: (data['questions'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  BaseModel fromMap(Map<String, dynamic> data) {
    return ExamModel.fromMap(data);
  }

  @override
  Map<String, dynamic> toMap() => {
        'exam': exam?.toMap(),
        'questions': questionModels?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ExamModel].

  @override
  factory ExamModel.fromJson(String data) {
    return ExamModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ExamModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
