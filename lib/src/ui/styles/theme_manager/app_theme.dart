import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:flutter/material.dart';

enum AppTheme { dark, light, system }

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: appPink,
  scaffoldBackgroundColor: backgroundColor,
  appBarTheme: AppBarTheme(backgroundColor: backgroundColor),
  primaryColor: Colors.amber,
  bottomNavigationBarTheme:
      BottomNavigationBarThemeData(backgroundColor: appDark[100]),
  fontFamily: 'Montserrat',
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: appDark,
  scaffoldBackgroundColor: backgroundColor2,
  appBarTheme: AppBarTheme(backgroundColor: backgroundColor2),
  primaryColor: red500,
  bottomNavigationBarTheme:
      BottomNavigationBarThemeData(backgroundColor: appDark[700]),
  fontFamily: 'Montserrat',
);
