import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/base/models/notification_model.dart';
import 'components/config/app_const.dart';
import 'components/config/app_route.dart';
import 'components/config/app_style.dart';
import 'components/services/app_service.dart';
import 'components/util/storage_util.dart';
import 'firebase_options.dart';
import 'notification_services.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Inisialisasi Firebase untuk background handler
  print(
      "Handling a background message: ${message.notification?.title} && ${message.data['id']}");
}

class FirebaseObject {
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
      print("message data : ${message.data}");
      // print("Messege receive on background : ${message.message}");
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
    await FirebaseMessaging.instance
        .subscribeToTopic(idTeam ?? "")
        .then((onValue) => print("Subscribe topic for id : $idTeam"));
  }

  void unsubscribeTopic(String? idTeam) async {
    await FirebaseMessaging.instance
        .unsubscribeFromTopic(idTeam ?? "")
        .then((onValue) => print("Unsubscribe Topic : $idTeam"));
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _dependencyInjection();
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

  runApp(const MyApp());
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
    FirebaseObject().notificationService.initNotification();
    FirebaseObject().callListenerOnMessageForeground();
    FirebaseObject().callListenerOnMessageBackground();
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
