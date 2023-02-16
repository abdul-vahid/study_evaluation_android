/// Environment variables and shared app constants.
class SharedPrefsConstants {
  static const String prefsAccessTokenKey = "access_token";
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

  static const bool kDebugMode = true;

  static const String categoryAPIPath = '/apis/category';
  static const String appearanceAPIPath = '/apis/appearance';
  static const String feedbackAPIPath = '/apis/feedback';
  static const String signupAPIPath = '/apis/auth/register';
  static const String loginAPIPath = '/apis/auth/login';
  static const String imagePath = '/study_evolution/public';
  static const String packageAPIPath = '/apis/web/category_by_package';
  static const String currentAffairsAPIPath = '/apis/web/category_by_package';
  static const String quotesAPIPath = '/apis/web/category_by_package';
  static const String packageLineItemsAPIPath = '/apis/web/category_by_package';
}
