import 'dart:convert';

class QuestionModel {
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
  String? optionAEnglish;
  String? optionBEnglish;
  String? optionCEnglish;
  String? optionDEnglish;
  String? status;
  String? resultId;
  String? resultLineItemId;
  String? submittedAnswer;
  String? favourite;
  int index = 0;
  bool? isSelected = false;
  String? descriptionHindi;
  String? descriptionEnglish;

  QuestionModel(
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
      this.favourite,
      this.descriptionEnglish,
      this.descriptionHindi});

  bool get isFavourite {
    return favourite != null && favourite.toString().toLowerCase() == "true";
  }

  bool get isCorrect {
    return answer == submittedAnswer;
  }

  bool get isWrong {
    return answer != submittedAnswer;
  }

  bool get isSkipped {
    return submittedAnswer == null || submittedAnswer!.isEmpty;
  }

  bool get hasSubmittedAnswer {
    return submittedAnswer != null && submittedAnswer.toString().isNotEmpty;
  }

  factory QuestionModel.fromMap(Map<String, dynamic> data) => QuestionModel(
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
        optionAEnglish: data['option_a_english'] as String?,
        optionBEnglish: data['option_b_english'] as String?,
        optionCEnglish: data['option_c_english'] as String?,
        optionDEnglish: data['option_d_english'] as String?,
        status: data['status'] as String?,
        resultId: data['result_id'] as String?,
        resultLineItemId: data['result_line_item_id'] as String?,
        submittedAnswer: data['submitted_answer'] as String?,
        favourite: data['favourite'] as String?,
        descriptionHindi: data['description_hindi'] as String?,
        descriptionEnglish: data['description_english'] as String?,
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
        'description_hindi': descriptionHindi,
        'description_english': descriptionEnglish,
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
