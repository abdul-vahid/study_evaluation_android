import 'dart:convert';

class ResultLineItem {
  String? id;
  String? questionId;
  String? answer;
  String? favourite;

  ResultLineItem({this.id, this.questionId, this.answer, this.favourite});

  factory ResultLineItem.fromMap(Map<String, dynamic> data) {
    return ResultLineItem(
      id: data['id'] as String?,
      questionId: data['question_id'] as String?,
      answer: data['answer'] as String?,
      favourite: data['favourite'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'question_id': questionId,
        'answer': answer,
        'favourite': favourite,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ResultLineItem].
  factory ResultLineItem.fromJson(String data) {
    return ResultLineItem.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ResultLineItem] to a JSON string.
  String toJson() => json.encode(toMap());
}
