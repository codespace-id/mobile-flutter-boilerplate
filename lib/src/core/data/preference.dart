import 'package:base_flutter/src/utils/prefecence_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static const _themeModeKey = 'themeMode';

  static Future<void> setThemeMode(String themeMode) async {
    final SharedPreferences prefs = await PreferenceUtils.instance;
    prefs.setString(_themeModeKey, themeMode);
  }

  static Future<String> getThemeMode() async {
    final SharedPreferences prefs = await PreferenceUtils.instance;
    final themeMode = prefs.getString(_themeModeKey);
    return themeMode ?? '';
  }
}
