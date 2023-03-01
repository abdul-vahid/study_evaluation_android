import 'package:flutter/foundation.dart';
import 'package:study_evaluation/core/apis/app_exception.dart';

class BaseModel {
  Exception? error;
  AppException? appException;

  BaseModel({this.error, this.appException});

  bool get isError => error != null || appException != null;
}
