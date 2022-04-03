import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  Future<SharedPreferences> _getInstance() async => await SharedPreferences.getInstance();

  Future<bool> setString({required String key, required String value}) async {
    final SharedPreferences _prefs = await this._getInstance();
    return await _prefs.setString(key, value);
  }

  Future<String?> getString({required String key}) async {
    final SharedPreferences _prefs = await this._getInstance();
    return _prefs.getString(key);
  }
}