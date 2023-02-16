import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';
import 'package.dart';
import 'test_model.dart';
import 'document_model.dart';

class PackageModel extends BaseModel {
  Package? package;
  List<TestModel>? testSeries;
  List<DocumentModel>? documents;

  PackageModel({this.package, this.testSeries, this.documents});

  factory PackageModel.fromMap(Map<String, dynamic> data) => PackageModel(
        package: data['package'] == null
            ? null
            : Package.fromMap(data['package'] as Map<String, dynamic>),
        testSeries: (data['test_series'] as List<dynamic>?)
            ?.map((e) => TestModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        documents: (data['documents'] as List<dynamic>?)
            ?.map((e) => DocumentModel.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'package': package?.toMap(),
        'test_series': testSeries?.map((e) => e.toMap()).toList(),
        'documents': documents?.map((e) => e.toMap()).toList(),
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
