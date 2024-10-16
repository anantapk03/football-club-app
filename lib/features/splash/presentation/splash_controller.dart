import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../components/base/models/notification_model.dart';
import '../../../components/config/app_const.dart';
import '../../../components/config/app_route.dart';
import '../../../components/util/deep_link_util.dart';

class SplashController extends GetxController {
  final _logger = Logger();
  @override
  void onInit() async {
    await _firebaseHandlerOnTerminated();
    final data = await DeepLinkUtil().handleInitialLinkOnTerminated();
    FlutterNativeSplash.remove();
    super.onInit();
    String? argumentsWillSend = data;
    _delay(argumentsWillSend);
  }

  Future<void> _firebaseHandlerOnTerminated() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null && initialMessage.notification != null) {
      NotificationModel notificationModel = NotificationModel.fromJson(
          jsonDecode(initialMessage.data.toString()));

      if (notificationModel.type == AppConst.notificationToListFavorites) {
        _delay("1");
      } else if (notificationModel.type == AppConst.notificationToDetail) {
        _delay(notificationModel.id);
      } else if (notificationModel.type == AppConst.notificationFirebaseTopic) {
        _delay(notificationModel.topic);
      }
    }
  }

  void _delay(String? arguments) {
    _logger.i("SPLASH");
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Get.offNamed(AppRoute.home, arguments: arguments));
  }
}
