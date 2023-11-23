import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final String prefsKey;

  SharedPreferencesHelper(this.prefsKey);
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<int> getInt() async {
    final prefs = await _getPrefs();
    return prefs.getInt(prefsKey) ?? 0;
  }

  Future<void> setInt(int value) async {
    final prefs = await _getPrefs();
    await prefs.setInt(prefsKey, value);
  }

  Future<double> getDouble() async {
    final prefs = await _getPrefs();
    return prefs.getDouble(prefsKey) ?? 0;
  }

  Future<void> setDouble(double value) async {
    final prefs = await _getPrefs();
    await prefs.setDouble(prefsKey, value);
  }

  Future<String> getString() async {
    final prefs = await _getPrefs();
    return prefs.getString(prefsKey) ?? "";
  }

  Future<void> setString(String value) async {
    final prefs = await _getPrefs();
    await prefs.setString(prefsKey, value);
  }

  Future<List<String>> getStringList() async {
    final prefs = await _getPrefs();
    return prefs.getStringList(prefsKey) ?? [];
  }

  Future<void> setStringList(List<String> value) async {
    final prefs = await _getPrefs();
    await prefs.setStringList(prefsKey, value);
  }

  Future<bool> getBool() async {
    final prefs = await _getPrefs();
    return prefs.getBool(prefsKey) ?? false;
  }

  Future<void> setBool(bool value) async {
    final prefs = await _getPrefs();
    await prefs.setBool(prefsKey, value);
  }
}