import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/enum.dart';
import 'package:study_evaluation/utils/function_lib.dart';

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
        debug("onDidReceiveNotificationResponse");
        BuildContext? context = AppUtils.currentContext;
        if (context != null) {
          AppUtils.launchTab(context,
              selectedIndex: HomeTabsOptions.notifications.index);
        } else {
          debug("Current Context is null");
        }
      },
    );
  }

  static void displayNotification(RemoteMessage message) async {
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
    } on Exception {}
  }
}
