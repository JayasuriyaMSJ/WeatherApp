import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static final AppPreference _instance = AppPreference._interval();
  static SharedPreferences? _preferences;

  AppPreference._interval();

  factory AppPreference() {
    return _instance;
  }

  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  String? getString(String key) {
    return _preferences?.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }
}
