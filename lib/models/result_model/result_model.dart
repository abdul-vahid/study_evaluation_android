import 'dart:convert';

import 'result.dart';
import 'result_line_item.dart';

class ResultModel {
  Result? result;
  List<ResultLineItem>? resultLineItems;

  ResultModel({this.result, this.resultLineItems});

  factory ResultModel.fromMap(Map<String, dynamic> data) => ResultModel(
        result: data['result'] == null
            ? null
            : Result.fromMap(data['result'] as Map<String, dynamic>),
        resultLineItems: (data['result_line_items'] as List<dynamic>?)
            ?.map((e) => ResultLineItem.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'result': result?.toMap(),
        'result_line_items': resultLineItems?.map((e) => e.toMap()).toList(),
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
