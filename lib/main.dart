import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'components/config/app_const.dart';
import 'components/config/app_route.dart';
import 'components/config/app_style.dart';
import 'components/services/app_service.dart';
import 'components/services/database/app_database.dart';
import 'components/util/storage_util.dart';
import 'components/widget/localization_inherited_widget.dart';
import 'firebase_options.dart';

Future<void> _handleLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Handle jika izin tetap ditolak atau ditolak secara permanen
      Logger().e("Izin lokasi ditolak.");
      return;
    }
  }

  if (permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always) {
    // Izin telah diberikan, lakukan tindakan yang memerlukan lokasi di sini

    Logger().i("Izin lokasi diberikan.");
  }
}

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _dependencyInjection();
  await _handleLocationPermission();
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
    Logger().i("Izin Notifikasi diberikan");
  } else {
    Logger().i('Izin notifikasi ditolak');
  }
  messaging.getToken().then((String? token) {
    if (token != null) {
      Logger().i('FCM Token: $token');
    }
  });
}

/// ====== Dependency Injection Section =====
Future<void> _dependencyInjection() async {
  final storage = StorageUtil(SecureStorage());
  Get.lazyPut(() => storage, fenix: true);
  // Jadikan AppDatabase singleton dengan `Get.put` dan `permanent: true`.
  Get.put(AppDatabase(), permanent: true);
  Get.put(AppService(storage));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('id');

  @override
  void initState() {
    super.initState();
    _fetchLocale();
  }

  Future<void> _fetchLocale() async {
    // Ambil data bahasa yang tersimpan (default ke 'id')
    String? storedLanguageCode =
        await StorageUtil(SecureStorage()).getLanguage();
    if (storedLanguageCode != null) {
      setState(() {
        _locale = Locale(storedLanguageCode.split('-').first);
      });
    }
  }

  void _updateLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });

    // Simpan perubahan bahasa
    StorageUtil(SecureStorage()).setLanguage(newLocale.toString());
  }

  @override
  Widget build(BuildContext context) {
    return LocalizationInheritedWidget(
      locale: _locale,
      updateLocale: _updateLocale,
      child: GetMaterialApp(
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
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('id')],
        locale: _locale,
        localeResolutionCallback: (_, __) {
          return _locale;
        },
      ),
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
