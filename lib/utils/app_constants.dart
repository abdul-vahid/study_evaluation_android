/// Environment variables and shared app constants.
abstract class SharedPrefsConstants {
  static const String accessTokenKey = "access_token";
  static const String refreshTokenKey = "refresh_token";
  static const String sessionTimeKey = "session_time";
  static const String profileUrlKey = "profile_url";
  static const String mobileNoKey = "mobile_no";
  static const String nameKey = "name";
  static const String userKey = "user";
}

abstract class ResultStatus {
  static const String completed = "Completed";
  static const String inProgress = "In Progress";
}

enum HomeTabsOptions { home, testSeries, myOrder, notifications, profile }

abstract class ProfileConstants {
  static const String firstNameLabel = "First Name";
  static const String lastNameLabel = "Last Name";
  static const String mobileLabel = "Mobile Number";
  static const String dobLabel = "Date of Birth";
  static const String genderLabel = "Gender";
  static const String stateLabel = "State";
  static const String cityLabel = "City";

  static const String firstNameHint = "Enter First Name";
  static const String lastNameHint = "Enter Last Name";
  static const String mobileHint = "Enter Mobile Number";
  static const String dobHint = "MM-DD-YYYY";
  static const String genderHint = "Gender";
  static const String stateHint = "State";
  static const String cityHint = "City";
}

//
abstract class AppConstants {
  static const String channelId = "study_evaluation";
  static const String channelName = "Study Evaluation";
  static const String channelDescription = "Study Evaluation";
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
  static const String studentProfileAPIPath = '/apis/student';
  static const String otpVerificationAPIPath = '/apis/verification';
  static const String resultAPIPath = '/apis/result';
  static const String changePasswordAPIPath = '/apis/auth/forget_password';
  static const String orderAPIPath = '/apis/orders';
  static const String leaderboardAPIPath = '/apis/leaderboard';
  static const String configurationAPIPath = '/apis/configuration';
  static const String notificationAPIPath = '/apis/notified_user';
  static const String registerFCMTokenAPIPath = '/apis/register_fcm_token';
  static const String refreshTokenAPIPath = '/apis/auth/refresh_token';

  static const String followUSData =
      '{"records":[{"title":"Follow Us on Facebook","image":"assets/images/facebook.png","url":"https://www.facebook.com/profile.php?id=100090658115759"},{"title":"Follow Us on Instagram","image":"assets/images/instagram.png","url":"https://instagram.com/studyevaluation?igshid=ZDdkNTZiNTM="},{"title":"Follow Us on Youtube","image":"assets/images/youtube.png","url":"https://www.youtube.com/@studysevaluation"},{"title":"Contact Us","image":"assets/images/taligram.png","url":"https://t.me/studyevaluation"}]}';
}
