import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  print("Handling a background message: ${message.notification?.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inisialisasi NotificationService
  final NotificationService notificationService = NotificationService();
  await notificationService.initNotification();

  // Inisialisasi Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inisialisasi dependency injection
  await _dependencyInjection();

  // Minta izin notifikasi
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // Periksa apakah izin diberikan
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Izin notifikasi diberikan');
  } else {
    print('Izin notifikasi ditolak');
  }

  // Dapatkan token FCM untuk perangkat ini dan cetak di log
  messaging.getToken().then((String? token) {
    if (token != null) {
      print('FCM Token: $token');
    }
  });

  // Handler pesan saat aplikasi di foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Pesan diterima saat di foreground: ${message.notification?.title}');
    if (message.notification != null) {
      print('Notifikasi: ${message.notification?.title}');

      // Tampilkan notifikasi menggunakan flutter_local_notifications
      notificationService.showNotification(
        title: message.notification!.title,
        body: message.notification!.body,
      );
    }
  });

  // Register handler untuk background message
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
