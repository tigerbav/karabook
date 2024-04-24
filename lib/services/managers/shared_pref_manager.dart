import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static SharedPrefManager share = SharedPrefManager._();
  SharedPrefManager._();

  Future<void> write(String key, Object value) async {
    final pref = await SharedPreferences.getInstance();
    if (value is String) {
      pref.setString(key, value);
    } //
    else if (value is bool) {
      pref.setBool(key, value);
    }
  }

  Future<Object?> get(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }
}
