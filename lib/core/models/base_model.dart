import 'package:study_evaluation/core/apis/app_exception.dart';

class BaseModel {
  Exception? error;
  AppException? appException;

  BaseModel({required this.error, required this.appException});

  bool get isError => error != null || appException != null;

  factory BaseModel.fromMap(Map<String, dynamic> data) {
    return BaseModel(error: null, appException: null);
  }

  Map<String, dynamic> toMap() => {};

  factory BaseModel.fromJson(String data) {
    return BaseModel(error: null, appException: null);
  }
  BaseModel fromMap(Map<String, dynamic> data) {
    return BaseModel.fromMap(data);
  }
}
