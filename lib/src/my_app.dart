import 'package:base_flutter/src/core/data/preference.dart';
import 'package:base_flutter/src/core/routes/app_route.dart';
import 'package:base_flutter/src/ui/styles/theme_manager/app_theme.dart';
import 'package:base_flutter/src/ui/styles/theme_manager/theme_manager.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final analytics = FirebaseAnalytics.instance;
  static final observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  _initThemeMode() async {
    final themeMode = await Preference.getThemeMode();
    final theme = context.read<ThemeManager>();
    if (themeMode == AppTheme.light.name) {
      theme.changeTheme(ThemeMode.light);
    } else if (themeMode == AppTheme.dark.name) {
      theme.changeTheme(ThemeMode.dark);
    } else if (themeMode == AppTheme.system.name) {
      theme.changeTheme(ThemeMode.system);
    }
  }

  @override
  void initState() {
    super.initState();
    _initThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return BlocBuilder<ThemeManager, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Base',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          builder: DevicePreview.appBuilder,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state,
          onGenerateRoute: AppRoute.routes,
          navigatorObservers: <NavigatorObserver>[
            observer,
          ],
        );
      },
    );
  }
}
