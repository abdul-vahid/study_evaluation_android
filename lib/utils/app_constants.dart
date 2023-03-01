/// Environment variables and shared app constants.
abstract class SharedPrefsConstants {
  static const String prefsAccessTokenKey = "access_token";
  static const String profileUrl = "profile_url";
  static const String mobileNo = "mobile_no";
  static const String name = "name";
  static const String userKey = "user";
}

abstract class ResultStatus {
  static const String completed = "Completed";
  static const String inProgress = "In Progress";
}

//
abstract class AppConstants {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://studyevaluation.com/sandbox',
  );

  static const String clientId = String.fromEnvironment(
    'CLIENT_ID',
    defaultValue: '',
  );

  static const String clientSecret = String.fromEnvironment(
    'CLIENT_SECRET',
    defaultValue: '',
  );

  static const String userName = String.fromEnvironment(
    'USERNAME',
    defaultValue: '',
  );

  static const String password = String.fromEnvironment(
    'PASSWORD',
    defaultValue: '',
  );
  static const String homeAPIPath = String.fromEnvironment(
    'HOME_API_PATH',
    defaultValue: '',
  );

  static const String apiVersion = String.fromEnvironment(
    'API_VERSION',
    defaultValue: '',
  );
  static const String imagePath = '/study_evaluation/public';
  static const bool kDebugMode = true;

  static const String categoryAPIPath = '/apis/category';
  static const String appearanceAPIPath = '/apis/appearance';
  static const String feedbackAPIPath = '/apis/feedback';
  static const String signupAPIPath = '/apis/auth/register';
  static const String loginAPIPath = '/apis/auth/login';
  static const String packageAPIPath = '/apis/category_by_package';
  static const String currentAffairsAPIPath = '/apis/current_affairs';
  static const String quotesAPIPath = '/apis/quote';
  static const String packageLineItemsAPIPath = '/apis/fetch_package_entries';
  static const String roleAPIPath = '/apis/role';
  static const String questionAnswerAPIPath = '/apis/exam_questions';
  static const String submitExamAPIPath = '/apis/submit_result';
}
