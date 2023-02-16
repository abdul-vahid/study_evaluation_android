import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

class DocumentModel extends BaseModel {
  String? id;
  String? packageId;
  String? type;
  String? documentName;
  String? documentUrl;

  DocumentModel({
    this.id,
    this.packageId,
    this.type,
    this.documentName,
    this.documentUrl,
  });

  factory DocumentModel.fromMap(Map<String, dynamic> data) => DocumentModel(
        id: data['id'] as String?,
        packageId: data['package_id'] as String?,
        type: data['type'] as String?,
        documentName: data['document_name'] as String?,
        documentUrl: data['document_url'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'package_id': packageId,
        'type': type,
        'document_name': documentName,
        'document_url': documentUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DocumentModel].
  factory DocumentModel.fromJson(String data) {
    return DocumentModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DocumentModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
