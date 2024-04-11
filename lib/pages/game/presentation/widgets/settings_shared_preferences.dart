import 'package:shared_preferences/shared_preferences.dart';

class SettingsPreferences {
  Future<bool> saveSwitchState(bool value, String prefsName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefsName, value);
    print('Switch Value saved $value');
    print('prefsNameved $prefsName');
    return prefs.setBool(prefsName, value);
  }

  Future<bool> getSwitchState(bool switched, String prefsName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switched = prefs.getBool(prefsName) ?? true;
    print(switched);

    return switched;
  }

  Future<bool?> getSwitchValue(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(prefName);
  }
}