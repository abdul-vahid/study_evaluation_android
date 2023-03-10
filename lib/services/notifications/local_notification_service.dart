import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:study_evaluation/services/api_service.dart';
import 'package:study_evaluation/utils/app_constants.dart';

import '../../utils/app_utils.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print("Notification Recevied");
        print("$details");

        print("${details.payload}");
      },
    );
  }

  static void displayNotification(RemoteMessage message) async {
    print("Display Notification Called");
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            AppConstants.channelId, AppConstants.channelName,
            channelDescription: AppConstants.channelDescription,
            playSound: true,
            priority: Priority.high,
            importance: Importance.max,
            channelShowBadge: true,
            visibility: NotificationVisibility.public),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['id'],
      );
      print("after show");
    } on Exception catch (e) {
      print(e);
    }
  }

  static final APIService _apiService = APIService();
  Future<dynamic> fetch({String userId = "152"}) async {
    //Map<String, String> requestData = {'email': username, 'password': password};
    String url = AppConstants.baseUrl + AppConstants.notificationAPIPath;
    if (userId.isNotEmpty) {
      url += "/$userId";
    }
    //print("URL: ${url.toString()}");
    var token = await AppUtils.getToken();
    final responseJsonData = await _apiService.getResponse(url, token!);
    String accessToken = responseJsonData['access_token'];
    if (AppConstants.kDebugMode) {
      print("responseJsonData: order $responseJsonData");
    }
    print("Access Token: $responseJsonData");
    return responseJsonData;
  }
}
