import 'package:study_evaluation/utils/app_constants.dart';

void debug(message) {
  if (AppConstants.kDebugMode) {
    // ignore: avoid_print
    print(message);
  }
}

