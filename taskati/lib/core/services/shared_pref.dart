// import 'package:shared_preferences/shared_preferences.dart';

// abstract class SharedPref {
//   static late SharedPreferences _prefs;
//   static String nameKey = 'name';
//   static String imageKey = 'image';
//   static String isUploadedKey = 'isUploaded';

//   static Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   static Future<void> setUserData(String name, String image) async {
//     await setString(nameKey, name);
//     await setString(imageKey, image);
//   }

//   static Future<void> setString(String key, String value) async {
//     await _prefs.setString(key, value);
//   }

//   static String getString(String key) {
//     return _prefs.getString(key) ?? '';
//   }

//   static Future<void> setBool(String key, bool value) async {
//     await _prefs.setBool(key, value);
//   }

//   static bool getBool(String key) {
//     return _prefs.getBool(key) ?? false;
//   }
// }
