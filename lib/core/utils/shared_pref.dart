import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  // Keys
  static const String _keyFirebaseToken = 'firebase_token';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserId = 'user_id';
  static const String _keyUserName = 'user_name';

  // Initialize SharedPreferences once
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Setters
  static Future<void> setFirebaseToken(String token) async {
    await _prefs?.setString(_keyFirebaseToken, token);
  }

  static Future<void> setIsLoggedIn(bool value) async {
    await _prefs?.setBool(_keyIsLoggedIn, value);
  }

  static Future<void> setUserId(String userId) async {
    await _prefs?.setString(_keyUserId, userId);
  }

  static Future<void> setUserName(String name) async {
    await _prefs?.setString(_keyUserName, name);
  }

  // Getters
  static String? getFirebaseToken() => _prefs?.getString(_keyFirebaseToken);
  static bool getIsLoggedIn() => _prefs?.getBool(_keyIsLoggedIn) ?? false;
  static String? getUserId() => _prefs?.getString(_keyUserId);
  static String? getUserName() => _prefs?.getString(_keyUserName);

  // Clear all (on logout)
  static Future<void> clearAll() async {
    await _prefs?.clear();
  }

  // Remove individual keys
  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }
}
