import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:study_evaluation/services/notifications/local_notification_service.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view_models/user_view_model/user_list_vm.dart';

class NotificationUtil {
  static FirebaseMessaging? _firebaseMessaging;
  static BuildContext? context;
  static void initialize(context) {
    NotificationUtil.context = context;
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging?.requestPermission();
    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method
    _firebaseMessaging?.getInitialMessage().then(
      (RemoteMessage? remoteMessage) {
        onMessageReceived(remoteMessage);
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage? remoteMessage) {
        onMessageReceived(remoteMessage);
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage? remoteMessage) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        onMessageReceived(remoteMessage!);
      },
    );

    registerToken();
  }

  static Future<void> onMessageReceived(RemoteMessage? remoteMessage) {
    if (remoteMessage != null) {
      LocalNotificationService.displayNotification(remoteMessage);
    }

    return Future.value();
  }

  static void registerToken() async {
    _firebaseMessaging!.getToken().then((token) {
      //TokenService tokenService = TokenService();

      AppUtils.printDebug("FCM Token = $token");
      UserListViewModel().registerFCMToken(token!).then((value) {},
          onError: (error) {
        //AppUtils.onError(AppUtils.currentContext!, error);
      });
    });
  }

  void onTextReceived(String? page) {
    /* if (page != null) {
      try {
        Navigator.pushNamed(context!, '/$page');
      } catch (_) {}
    } */
  }
}
