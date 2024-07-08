import 'package:base_flutter/src/core/data/preference.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeManager extends Cubit<ThemeMode> {
  ThemeManager() : super(ThemeMode.light);

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void changeTheme(ThemeMode mode) async {
    _themeMode = mode;
    Preference.setThemeMode(mode.name);
    emit(mode);
  }
}
