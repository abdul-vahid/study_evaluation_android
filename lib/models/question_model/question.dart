import 'dart:convert';

class Question {
  String? id;
  String? subjectId;
  String? questionEnglish;
  String? questionHindi;
  String? answer;
  String? answerEnglish;
  String? answerHindi;
  String? solutionHindi;
  String? status;
  String? optionAHindi;
  String? optionBHindi;
  String? optionCHindi;
  String? optionDHindi;
  dynamic optionEHindi;
  String? optionAEnglish;
  String? optionBEnglish;
  String? optionCEnglish;
  String? optionDEnglish;
  dynamic optionEEnglish;
  String? solutionEnglish;
  String? createdDate;
  String? updatedDate;
  String? createdBy;
  String? updatedBy;
  String? subjectName;

  Question({
    this.id,
    this.subjectId,
    this.questionEnglish,
    this.questionHindi,
    this.answer,
    this.answerEnglish,
    this.answerHindi,
    this.solutionHindi,
    this.status,
    this.optionAHindi,
    this.optionBHindi,
    this.optionCHindi,
    this.optionDHindi,
    this.optionEHindi,
    this.optionAEnglish,
    this.optionBEnglish,
    this.optionCEnglish,
    this.optionDEnglish,
    this.optionEEnglish,
    this.solutionEnglish,
    this.createdDate,
    this.updatedDate,
    this.createdBy,
    this.updatedBy,
    this.subjectName,
  });

  factory Question.fromMap(Map<String, dynamic> data) => Question(
        id: data['id'] as String?,
        subjectId: data['subject_id'] as String?,
        questionEnglish: data['question_english'] as String?,
        questionHindi: data['question_hindi'] as String?,
        answer: data['answer'] as String?,
        answerEnglish: data['answer_english'] as String?,
        answerHindi: data['answer_hindi'] as String?,
        solutionHindi: data['solution_hindi'] as String?,
        status: data['status'] as String?,
        optionAHindi: data['option_a_hindi'] as String?,
        optionBHindi: data['option_b_hindi'] as String?,
        optionCHindi: data['option_c_hindi'] as String?,
        optionDHindi: data['option_d_hindi'] as String?,
        optionEHindi: data['option_e_hindi'] as dynamic,
        optionAEnglish: data['option_a_english'] as String?,
        optionBEnglish: data['option_b_english'] as String?,
        optionCEnglish: data['option_c_english'] as String?,
        optionDEnglish: data['option_d_english'] as String?,
        optionEEnglish: data['option_e_english'] as dynamic,
        solutionEnglish: data['solution_english'] as String?,
        createdDate: data['created_date'] as String?,
        updatedDate: data['updated_date'] as String?,
        createdBy: data['created_by'] as String?,
        updatedBy: data['updated_by'] as String?,
        subjectName: data['subject_name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'subject_id': subjectId,
        'question_english': questionEnglish,
        'question_hindi': questionHindi,
        'answer': answer,
        'answer_english': answerEnglish,
        'answer_hindi': answerHindi,
        'solution_hindi': solutionHindi,
        'status': status,
        'option_a_hindi': optionAHindi,
        'option_b_hindi': optionBHindi,
        'option_c_hindi': optionCHindi,
        'option_d_hindi': optionDHindi,
        'option_e_hindi': optionEHindi,
        'option_a_english': optionAEnglish,
        'option_b_english': optionBEnglish,
        'option_c_english': optionCEnglish,
        'option_d_english': optionDEnglish,
        'option_e_english': optionEEnglish,
        'solution_english': solutionEnglish,
        'created_date': createdDate,
        'updated_date': updatedDate,
        'created_by': createdBy,
        'updated_by': updatedBy,
        'subject_name': subjectName,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Question].
  factory Question.fromJson(String data) {
    return Question.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Question] to a JSON string.
  String toJson() => json.encode(toMap());
}
