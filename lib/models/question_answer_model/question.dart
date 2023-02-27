import 'dart:convert';

class Question {
  String? id;
  String? subjectId;
  String? subjectName;
  String? questionHindi;
  String? answer;
  String? optionAHindi;
  String? optionBHindi;
  String? optionCHindi;
  String? optionDHindi;
  String? questionEnglish;
  dynamic optionAEnglish;
  dynamic optionBEnglish;
  dynamic optionCEnglish;
  dynamic optionDEnglish;
  String? status;
  dynamic resultId;
  dynamic resultLineItemId;
  dynamic submittedAnswer;
  dynamic favourite;
  int index = 0;
  bool? isSelected = false;
  
  Question(
      {this.id,
      this.subjectId,
      this.subjectName,
      this.questionHindi,
      this.answer,
      this.optionAHindi,
      this.optionBHindi,
      this.optionCHindi,
      this.optionDHindi,
      this.questionEnglish,
      this.optionAEnglish,
      this.optionBEnglish,
      this.optionCEnglish,
      this.optionDEnglish,
      this.status,
      this.resultId,
      this.resultLineItemId,
      this.submittedAnswer,
      this.favourite});

  factory Question.fromMap(Map<String, dynamic> data) => Question(
        id: data['id'] as String?,
        subjectId: data['subject_id'] as String?,
        subjectName: data['subject_name'] as String?,
        questionHindi: data['question_hindi'] as String?,
        answer: data['answer'] as String?,
        optionAHindi: data['option_a_hindi'] as String?,
        optionBHindi: data['option_b_hindi'] as String?,
        optionCHindi: data['option_c_hindi'] as String?,
        optionDHindi: data['option_d_hindi'] as String?,
        questionEnglish: data['question_english'] as String?,
        optionAEnglish: data['option_a_english'] as dynamic,
        optionBEnglish: data['option_b_english'] as dynamic,
        optionCEnglish: data['option_c_english'] as dynamic,
        optionDEnglish: data['option_d_english'] as dynamic,
        status: data['status'] as String?,
        resultId: data['result_id'] as dynamic,
        resultLineItemId: data['result_line_item_id'] as dynamic,
        submittedAnswer: data['submitted_answer'] as dynamic,
        favourite: data['favourite'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'subject_id': subjectId,
        'subject_name': subjectName,
        'question_hindi': questionHindi,
        'answer': answer,
        'option_a_hindi': optionAHindi,
        'option_b_hindi': optionBHindi,
        'option_c_hindi': optionCHindi,
        'option_d_hindi': optionDHindi,
        'question_english': questionEnglish,
        'option_a_english': optionAEnglish,
        'option_b_english': optionBEnglish,
        'option_c_english': optionCEnglish,
        'option_d_english': optionDEnglish,
        'status': status,
        'result_id': resultId,
        'result_line_item_id': resultLineItemId,
        'submitted_answer': submittedAnswer,
        'favourite': favourite,
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
