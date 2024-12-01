import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

import '../../notification_services.dart';
import '../base/models/notification_model.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Inisialisasi Firebase untuk background handler
  Logger().i(
      "Handling a background message: ${message.notification?.title} && ${message.data['id']}");
}

class FirebaseNotificationUtil {
  final NotificationService notificationService = NotificationService();

  void callToShowNotif(RemoteMessage message) {
    notificationService.showNotification(
      title: message.notification!.title,
      body: message.notification!.body,
      payload: message.data.toString(),
    );
  }

  void callListenerOnMessageForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        callToShowNotif(message);
      }
    });
  }

  void callListenerOnMessageBackground() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        NotificationModel notificationModel =
            NotificationModel.fromJson(jsonDecode(message.data.toString()));
        notificationService.actionNotification(notificationModel);
      }
    });
  }

  void subscribeTopic(String? idTeam) async {
    await FirebaseMessaging.instance.subscribeToTopic(idTeam ?? "");
  }

  void unsubscribeTopic(String? idTeam) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(idTeam ?? "");
  }
}
