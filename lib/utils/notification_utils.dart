import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:study_evaluation/services/notifications/local_notification_service.dart';

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
        /* print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.displayNotification(message);
        } */

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
    print("onMessageReceived");
    print(remoteMessage?.data);
    /* if (remoteMessage?.data['type'] == 'image') {
      onImageReceived(remoteMessage!.data['url'].toString());
    } else if (remoteMessage?.data['type'] == 'video') {
      onVideoReceived(remoteMessage!.data['url'].toString());
    } else if (remoteMessage?.data['type'] == 'text') {
      onTextReceived(remoteMessage!.data['url'].toString());
    } */
    //onTextReceived(remoteMessage!.data.toString());
    if (remoteMessage != null) {
      LocalNotificationService.displayNotification(remoteMessage);
    }

    return Future.value();
  }

  static void registerToken() async {
    _firebaseMessaging!.getToken().then((token) {
      //TokenService tokenService = TokenService();
      try {
        print("FCM Token = $token");
        //tokenService.updateToken(patient!.sfId!, token!);
      } catch (err) {
        print(err);
      }
    });
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

/* void _notificationHandler() {
  // 1. This method call when app in terminated state and you get a notification
  // when you click on notification app open from terminated state and you can get notification data in this method
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  firebaseMessaging.requestPermission();
  //firebaseMessaging.requestPermission();
  firebaseMessaging.getInitialMessage().then(
    (message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        print("New Notification: ${message.data}");
        // if (message.data['_id'] != null) {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => DemoScreen(
        //         id: message.data['_id'],
        //       ),
        //     ),
        //   );
        // }
      }
    },
  );

  // 3. This method only call when App in background and not terminated(not closed)
  FirebaseMessaging.onMessageOpenedApp.listen(
    (message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        //LocalNotificationService.displayNotification(message);
        print("hello");
        /*  print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}"); */
      }
    },
  );
} */
