import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  // Create instance of SharedPreferences
  Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  // Method to set value
  Future<bool> setValue(String keys, String values) async {
    final prefs = await _prefs;
    return prefs.setString(keys, values);
  }

  // Method to read value
  Future<String?> readValue(String keys) async {
    final prefs = await _prefs;
    return prefs.getString(keys);
  }

  // Method to clear value
  Future<bool> clearValue(String key) async {
    final prefs = await _prefs;
    return prefs.remove(key);
  }
}
