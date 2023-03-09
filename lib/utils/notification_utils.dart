import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class NotificationUtil {
  FirebaseMessaging? _firebaseMessaging;
  final BuildContext? context;

  NotificationUtil(this.context) {
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging!.requestPermission();
    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      onMessageReceived(remoteMessage);
    });

    //20/04/2022
    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      print('onMessageOpenedApp');
      onMessageReceived(remoteMessage);
    });

    /*
    _firebaseMessaging!.configure(
      onMessage: (Map<String, dynamic> message) async {},
      onResume: onMessageReceived,
      onLaunch: onMessageReceived,
    );*/
    registerToken();
  }
  // 20/04/2022
  void onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(onMessageReceived);
  }

  Future<void> onMessageReceived(RemoteMessage? remoteMessage) {
    print(remoteMessage?.data);
    /* if (remoteMessage?.data['type'] == 'image') {
      onImageReceived(remoteMessage!.data['url'].toString());
    } else if (remoteMessage?.data['type'] == 'video') {
      onVideoReceived(remoteMessage!.data['url'].toString());
    } else if (remoteMessage?.data['type'] == 'text') {
      onTextReceived(remoteMessage!.data['url'].toString());
    } */
    onTextReceived(remoteMessage!.data.toString());
    return Future.value();
  }

  void registerToken() async {
    /* _firebaseMessaging!.getToken().then((token) {
      TokenService tokenService = TokenService();
      try {
        tokenService.updateToken(patient!.sfId!, token!);
      } catch (err) {
        print(err);
      }
    }); */
  }

  /* Future<dynamic> onMessageReceived(Map<String, dynamic> message) async {
    if (message['type'].toString() == 'image')
      onImageReceived(message['url'].toString());
    else if (message['type'].toString() == 'video')
      onVideoReceived(message['url'].toString());
    else if (message['type'].toString() == 'text')
      onTextReceived(message['url'].toString());
  } */

  void onTextReceived(String? page) {
    /* if (page != null) {
      try {
        Navigator.pushNamed(context!, '/$page');
      } catch (_) {}
    } */
  }
}
