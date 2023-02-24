import 'dart:convert';

import 'package:study_evaluation/core/models/base_model.dart';

import '../core/apis/app_exception.dart';

class QuoteModel extends BaseModel {
  String? id;
  String? quote;
  String? date;
  String? documentName;
  String? documentUrl;
  dynamic videoUrl;
  dynamic pdfUrl;
  String? status;
  String? createdDate;
  String? updatedDate;
  String? createdBy;
  String? updatedBy;

  QuoteModel(
      {this.id,
      this.quote,
      this.date,
      this.documentName,
      this.documentUrl,
      this.videoUrl,
      this.pdfUrl,
      this.status,
      this.createdDate,
      this.updatedDate,
      this.createdBy,
      this.updatedBy,
      super.error,
      super.appException});
  bool get isError {
    return error != null || appException != null;
  }

  factory QuoteModel.fromMap(Map<String, dynamic> data) => QuoteModel(
        id: data['id'] as String?,
        quote: data['quote'] as String?,
        date: data['date'] as String?,
        documentName: data['document_name'] as String?,
        documentUrl: data['document_url'] as String?,
        videoUrl: data['video_url'] as dynamic,
        pdfUrl: data['pdf_url'] as dynamic,
        status: data['status'] as String?,
        createdDate: data['created_date'] as String?,
        updatedDate: data['updated_date'] as String?,
        createdBy: data['created_by'] as String?,
        updatedBy: data['updated_by'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'quote': quote,
        'date': date,
        'document_name': documentName,
        'document_url': documentUrl,
        'video_url': videoUrl,
        'pdf_url': pdfUrl,
        'status': status,
        'created_date': createdDate,
        'updated_date': updatedDate,
        'created_by': createdBy,
        'updated_by': updatedBy,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QuoteModel].
  factory QuoteModel.fromJson(String data) {
    return QuoteModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [QuoteModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
