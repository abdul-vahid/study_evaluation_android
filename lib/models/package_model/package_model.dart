import 'dart:convert';

import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_model.dart';

import 'document.dart';
import 'package.dart';
import 'test_series.dart';

class PackageModel extends BaseModel {
  Package? package;
  List<Document>? documents;
  List<TestSeries>? testSeries;
  PackageModel(
      {this.package,
      this.documents,
      this.testSeries,
      super.error,
      super.appException});
  bool get isError {
    return error != null || appException != null;
  }

  factory PackageModel.fromMap(Map<String, dynamic> data) => PackageModel(
        package: data['package'] == null
            ? null
            : Package.fromMap(data['package'] as Map<String, dynamic>),
        documents: (data['documents'] as List<dynamic>?)
            ?.map((e) => Document.fromMap(e as Map<String, dynamic>))
            .toList(),
        testSeries: (data['test_series'] as List<dynamic>?)
            ?.map((e) => TestSeries.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'package': package?.toMap(),
        'documents': documents?.map((e) => e.toMap()).toList(),
        'test_series': testSeries?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PackageModel].
  factory PackageModel.fromJson(String data) {
    return PackageModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PackageModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
