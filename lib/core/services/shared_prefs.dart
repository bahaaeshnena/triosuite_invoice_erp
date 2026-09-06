import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance => _instance;

  static setBool(String key, bool value) => _instance.setBool(key, value);

  static bool getBool(String key) => _instance.getBool(key) ?? false;

  static setString(String key, String value) async =>
      await _instance.setString(key, value);

  static String getString(String key) => _instance.getString(key) ?? '';

  static setInt(String key, int value) => _instance.setInt(key, value);
  static int getInt(String key) => _instance.getInt(key) ?? 0;

  static Future<void> clear() async => await _instance.clear();

  static Future<void> remove(String key) async => await _instance.remove(key);
}
