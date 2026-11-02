import 'package:shared_preferences/shared_preferences.dart';

class Localhelper {
  static late SharedPreferences pref;
  static String kUserEmail = 'user_email';
  static String kUserIsLogin = 'user_isLogin';


  static init() async {
    pref = await SharedPreferences.getInstance();
  }
  //Set
  static Future<bool> setString(String key, String value) {
    return pref.setString(key, value);
  }

  static Future<bool> setBool(String key, bool value) {
    return pref.setBool(key, value);
  }

  static Future<bool> setDouble(String key, double value) {
    return pref.setDouble(key, value);
  }

  static Future<bool> setInt(String key, int value) {
    return pref.setInt(key, value);
  }

  static Future<bool> setListString(String key, List<String> value) {
    return pref.setStringList(key, value);
  }

  //Get
  static String? getString(String key) {
    return pref.getString(key);
  }

  static bool? getBool(String key) {
    return pref.getBool(key);
  }

  static double? getDouble(String key) {
    return pref.getDouble(key);
  }

  static int? getInt(String key) {
    return pref.getInt(key);
  }

  static List<String>? getListString(String key) {
    return pref.getStringList(key);
  }

  //remove and clear
  static Future<bool> remove(String key) {
    return pref.remove(key);
  }

  static Future<bool> clear() {
    return pref.clear();
  }
}
