import 'dart:convert';

class Document {
  String? id;
  String? type;
  String? documentName;
  String? documentUrl;
  String? downloadedDocumentUrl;
  String? contentType;

  Document(
      {this.id,
      this.type,
      this.documentName,
      this.documentUrl,
      this.contentType});

  factory Document.fromMap(Map<String, dynamic> data) => Document(
        id: data['id'] as String?,
        type: data['type'] as String?,
        documentName: data['document_name'] as String?,
        documentUrl: data['document_url'] as String?,
        contentType: data['content_type'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'document_name': documentName,
        'document_url': documentUrl,
        'content_type': contentType,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Document].
  factory Document.fromJson(String data) {
    return Document.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Document] to a JSON string.
  String toJson() => json.encode(toMap());
}
