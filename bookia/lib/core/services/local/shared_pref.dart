import 'dart:convert';

import 'package:bookia/feature/auth/data/models/auth_response/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences sharedPreferences;

  static const String kToken = 'token';
  static const String kUserInfo = 'user';

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void setToken(String? token) {
    if (token == null) return;
    setString(kToken, token);
  }

  static String getToken() => getString(kToken);

  static void setUserInfo(User? user) {
    if (user == null) return;
    // obj ==> json ==> string (encode)
    var json = user.toJson();
    var userString = jsonEncode(json);
    setString(kUserInfo, userString);
  }

  static User? getUserInfo() {
    var userString = getString(kUserInfo);
    if (userString.isEmpty) return null;
    // string(decode) ==> json ==> obj
    var json = jsonDecode(userString);
    return User.fromJson(json);
  }

  static Future<void> setString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  static String getString(String key) {
    return sharedPreferences.getString(key) ?? '';
  }

  static Future<void> setBool(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  static bool getBool(String key) {
    return sharedPreferences.getBool(key) ?? false;
  }

  static Future<void> remove(String key) async {
    await sharedPreferences.remove(key);
  }

  static Future<void> clear() async {
    await sharedPreferences.clear();
  }
}
