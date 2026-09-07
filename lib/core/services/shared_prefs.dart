import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static bool get isInitialized => _instance != null;

  static SharedPreferences get instance => _instance!;

  static setBool(String key, bool value) => instance.setBool(key, value);

  static bool getBool(String key) => instance.getBool(key) ?? false;

  static setString(String key, String value) async =>
      await instance.setString(key, value);

  static String getString(String key) => instance.getString(key) ?? '';

  static setInt(String key, int value) => instance.setInt(key, value);
  static int getInt(String key) => instance.getInt(key) ?? 0;

  static Future<void> clear() async => await instance.clear();

  static Future<void> remove(String key) async => await instance.remove(key);
}
