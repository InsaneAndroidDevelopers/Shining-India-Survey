import 'package:shared_preferences/shared_preferences.dart';
import 'package:shining_india_survey/utils/string_constants.dart';

class SharedPreferencesHelper {

  static Future<bool> setUserToken(String userToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(Strings.USER_TOKEN, userToken);
  }

  static Future<String> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Strings.USER_TOKEN) ?? '';
  }

  static Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<bool> setUserLevel(String userRole) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(Strings.USER_ROLE, userRole);
  }

  static Future<String> getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Strings.USER_ROLE) ?? '';
  }
}