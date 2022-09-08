import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(String key, dynamic value) async {
    if (value is double) return await sharedPreferences!.setDouble(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is int)
      return await sharedPreferences!.setInt(key, value);
    else
      return await sharedPreferences!.setString(key, value);
  }

  static getData(String key) {
    return sharedPreferences!.get(key);
  }
}
