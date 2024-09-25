import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'components/config/app_route.dart';
import 'features/detailclub/presentation/detail_club_controller.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationAndroidSettings =
        AndroidInitializationSettings("@mipmap/launcher_icon");

    final DarwinInitializationSettings initializationSettingIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      defaultPresentSound: true,
      defaultPresentAlert: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        print('Received local notification: $id, $title, $body, $payload');
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationAndroidSettings,
      iOS: initializationSettingIOS,
    );

    await notificationPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            backgroundNotificationResponseHandler,
        onDidReceiveNotificationResponse:
            backgroundNotificationResponseHandler);
  }

  void backgroundNotificationResponseHandler(
      NotificationResponse notification) async {
    print('Received background notification response: $notification');
    var currentRoute = Get.currentRoute;
    if (currentRoute == AppRoute.detail) {
      print("Onclick when user is already on the detail page");
      // Ambil controller dari halaman detail
      // Get.offAndToNamed(AppRoute.detail, arguments: notification.payload);
      DetailClubController controller = Get.find<DetailClubController>();
      // // Panggil ulang fungsi untuk memuat data baru dari notifikasi
      controller.loadDetailClub(notification.payload.toString());
      print("Data updated with new notification payload");
    } else {
      Get.toNamed(AppRoute.detail, arguments: notification.payload);
    }
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    print('Showing notification: $id, $title, $body, $payload');
    await notificationPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
      payload: payload,
    );
  }

  Future<NotificationDetails> notificationDetails() async {
    return const NotificationDetails(
      iOS: DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }
}
