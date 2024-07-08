import 'dart:io';

import 'package:base_flutter/src/core/data/constants.dart';
import 'package:base_flutter/src/core/data/hive_constants.dart';
import 'package:base_flutter/src/core/models/address_model.dart';
import 'package:base_flutter/src/core/models/company_model.dart';
import 'package:base_flutter/src/core/models/geo_model.dart';
import 'package:base_flutter/src/core/models/user_model.dart';
import 'package:base_flutter/src/my_app.dart';
import 'package:base_flutter/src/ui/styles/theme_manager/theme_manager.dart';
import 'package:base_flutter/src/utils/app_helper.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' as service;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setupFlavor();
  await _initHive();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await _initLocalNotification();
  SystemChrome.setPreferredOrientations([
    service.DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
      EasyLocalization(
        supportedLocales: [
          const Locale('id', 'ID'),
          const Locale('en', 'US'),
        ],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('id', 'ID'),
        child: DevicePreview(
          enabled: isInDebugMode,
          builder: (context) => BlocProvider(
            create: (context) => ThemeManager(),
            child: MyApp(),
          ),
        ),
      ),
    );
  });
}

Future<void> _setupFlavor() async {
  final flavor = await flavorConfig();
  logDebug('Main # $flavor');
  Constants.displayName = flavor.displayName;
  Constants.baseUrl = flavor.baseUrl;
}

Future<void> _initHive() async {
  final Directory appDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  Hive.registerAdapter(CompanyModelAdapter());
  Hive.registerAdapter(GeoModelAdapter());
  Hive.registerAdapter(AddressModelAdapter());
  Hive.registerAdapter(UserModelAdapter());

  Hive.openBox<UserModel>(DB_USER);
}

Future<void> _initLocalNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) {}

void onDidReceiveNotificationResponse(NotificationResponse details) {}
