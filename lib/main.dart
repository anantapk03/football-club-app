import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'components/config/app_const.dart';
import 'components/config/app_route.dart';
import 'components/config/app_style.dart';
import 'components/services/app_service.dart';
import 'components/util/deep_link_util.dart';
import 'components/util/firebase_notification_util.dart';
import 'components/util/storage_util.dart';
import 'firebase_options.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _dependencyInjection();
  await _notificationConfiguration();
  runApp(const MyApp());
}

Future<void> _notificationConfiguration() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Izin notifikasi diberikan');
  } else {
    print('Izin notifikasi ditolak');
  }
  messaging.getToken().then((String? token) {
    if (token != null) {
      print('FCM Token: $token');
    }
  });
}

/// ====== Dependency Injection Section =====
Future<void> _dependencyInjection() async {
  final storage = StorageUtil(SecureStorage());
  Get.lazyPut(() => storage, fenix: true);
  Get.put(AppService(storage));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseNotificationUtil().notificationService.initNotification();
    FirebaseNotificationUtil().callListenerOnMessageForeground();
    FirebaseNotificationUtil().callListenerOnMessageBackground();
    DeepLinkUtil().initialDeepLinking();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    DeepLinkUtil().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConst.appName,
      theme: ThemeData(
        primarySwatch: AppStyle.appTheme,
      ),
      initialRoute: AppRoute.defaultRoute,
      unknownRoute: GetPage(
        name: AppRoute.notFound,
        page: () => const UnknownRoutePage(),
      ),
      getPages: AppRoute.pages,
    );
  }
}

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('No route defined for this page')),
    );
  }
}
