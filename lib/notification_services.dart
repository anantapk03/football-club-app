import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'components/base/models/notification_model.dart';
import 'components/config/app_const.dart';
import 'components/config/app_route.dart';
import 'features/detailclub/presentation/detail_club_controller.dart';
import 'features/favorite/presentation/favorite_controller.dart';
import 'features/navigation/presentation/bottom_navigation_controller.dart';

// Top Level
void notificationHandlerAction(NotificationResponse notification) async {
  try {
    NotificationModel notificationPayload =
        NotificationModel.fromJson(jsonDecode(notification.payload!));
    NotificationService().actionNotification(notificationPayload);
  } catch (e) {
    Logger().e('Error parsing notification payload: $e');
  }
}

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationAndroidSettings =
        AndroidInitializationSettings("launcher_icon");

    final DarwinInitializationSettings initializationSettingIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      defaultPresentSound: true,
      defaultPresentAlert: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        Logger().i('Received local notification: $id, $title, $body, $payload');
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationAndroidSettings,
      iOS: initializationSettingIOS,
    );

    await notificationPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: notificationHandlerAction,
        onDidReceiveNotificationResponse: notificationHandlerAction);
  }

  void actionNotification(NotificationModel notificationModel) {
    switch (notificationModel.type) {
      case AppConst.notificationToDetail:
        actionToDetailTeam(notificationModel.id.toString());
        break;
      case AppConst.notificationToListFavorites:
        actionToListFavorites();
        break;
      case AppConst.notificationFirebaseTopic:
        actionFirebaseTopic(notificationModel.topic.toString());
        break;
      default:
        Logger().e("Unhandled norification type: ${notificationModel.type}");
    }
  }

  void actionToDetailTeam(String idPayload) {
    var currentRoute = Get.currentRoute;
    if (currentRoute == AppRoute.detail) {
      DetailClubController controller = Get.find<DetailClubController>();
      controller.loadDetailClub(idPayload);
    } else {
      Get.toNamed(AppRoute.detail, arguments: idPayload);
    }
  }

  void actionFirebaseTopic(String idPayload) {
    var currentRoute = Get.currentRoute;
    if (currentRoute == AppRoute.detail) {
      DetailClubController controller = Get.find<DetailClubController>();
      controller.loadDetailClub(idPayload);
    } else {
      Get.toNamed(AppRoute.detail, arguments: idPayload);
    }
  }

  void actionToListFavorites() {
    var currentRoute = Get.currentRoute;
    if (currentRoute == AppRoute.home) {
      _updateBottomNavigationController();
    }
    if (Get.currentRoute == AppRoute.detail) {
      Get.back();
      _updateBottomNavigationController();
    }
  }

  void _updateBottomNavigationController() {
    BottomNavigationController2 bottomNavigationController =
        Get.find<BottomNavigationController2>();
    bottomNavigationController.onItemTapped(1);
    FavoriteController controller = Get.find<FavoriteController>();
    controller.loadAllClubFavorite();
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    Logger().i('Showing notification: $id, $title, $body, $payload');
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
