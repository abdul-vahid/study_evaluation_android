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

    // defaultValue: 'https://studyevaluation.com/sandbox',

    // defaultValue: 'https://studyevaluation.com/uat',
    defaultValue: 'https://studyevaluation.com',
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

  static const String publicPath = '/admin/public';
  static const bool kDebugMode = true;
  static const String appUrlPath =
      'https://play.google.com/store/apps/details?id=com.study.evaluation';

  static const String categoryAPIPath = '/apis/category';
  static const String appearanceAPIPath = '/apis/appearance';
  static const String feedbackAPIPath = '/apis/feedbacks';
  static const String submitFeedbackAPIPath = '/apis/feedback';
  static const String signupAPIPath = '/apis/auth/register';
  static const String loginAPIPath = '/apis/auth/login';
  static const String packageAPIPath = '/apis/packages';
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
  static const String notificationAPIPath = '/apis/notifications';
  static const String registerFCMTokenAPIPath = '/apis/register_fcm_token';
  static const String refreshTokenAPIPath = '/apis/auth/refresh_token';
  static const String orderPaymentCreationAPIPath = '/apis/order_creation';
  static const String profilePictureUpdateAPIPath =
      '/apis/profile_picture_update';
  static const String latestNewsAPIPath = '/apis/latest_news';

  static const String freepackageAPIPath =
      '/apis/packages?category_id=&user_id=&package_type=&publish_type=Free';

  static const String followUSData =
      '{"records":[{"title":"Follow us on Facebook","image":"assets/images/facebook.png","url":"https://www.facebook.com/profile.php?id=100090658115759"},{"title":"Follow us on Instagram","image":"assets/images/instagram.png","url":"https://instagram.com/studyevaluation?igshid=ZDdkNTZiNTM="},{"title":"Follow us on Youtube","image":"assets/images/youtube.png","url":"https://www.youtube.com/@evolve-with-studyevaluation"},{"title":"Contact us","image":"assets/images/taligram.png","url":"https://t.me/studyevaluation"}, {"title":"Join us on Whatsapp","image":"assets/images/whatsapp.png","url":"https://chat.whatsapp.com/LHE2SYxzrfK1Smg0RgFRjn"}]}';
}


//https://www.youtube.com/@studysevaluation