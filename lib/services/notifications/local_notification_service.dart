import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/services/api_service.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/enum.dart';
import 'package:study_evaluation/utils/function_lib.dart';
import 'package:study_evaluation/utils/notification_utils.dart';
import 'package:study_evaluation/view/views/notifications_view.dart';
import 'package:study_evaluation/view_models/notifications_list_vm.dart';

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
        AppUtils.launchTab(NotificationUtil.context!,
            selectedIndex: HomeTabsOptions.notifications.index);
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
