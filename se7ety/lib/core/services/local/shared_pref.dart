import 'dart:convert';

import 'package:se7ety/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences pref;

  static final String kUserData = 'user_data';

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static void setUserData(UserModel model) {
    var jsonToString = json.encode(model.toJson());
    setData(kUserData, jsonToString);
  }

  static UserModel? getUserData() {
    var data = getData(kUserData);
    if (data != null) {
      return UserModel.fromJson(json.decode(data));
    }
    return null;
  }

  static void setData(String key, dynamic value) {
    if (value is int) {
      pref.setInt(key, value);
    } else if (value is bool) {
      pref.setBool(key, value);
    } else if (value is String) {
      pref.setString(key, value);
    } else if (value is double) {
      pref.setDouble(key, value);
    } else if (value is List<String>) {
      pref.setStringList(key, value);
    }
  }

  static dynamic getData(String key) {
    return pref.get(key);
  }

  static Future<bool> clear() {
    return pref.clear();
  }

  static Future<bool> remove(String key) {
    return pref.remove(key);
  }
}
