import 'package:shared_preferences/shared_preferences.dart';
import 'package:shining_india_survey/global/values/string_constants.dart';

class SharedPreferencesHelper {

  static Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<bool> setUserToken(String userToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(StringsConstants.USER_TOKEN, userToken);
  }

  static Future<String> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(StringsConstants.USER_TOKEN) ?? '';
  }

  static Future<bool> setUserLevel(String userRole) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(StringsConstants.USER_ROLE, userRole);
  }

  static Future<String> getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(StringsConstants.USER_ROLE) ?? '';
  }

  static Future<bool> setUserId(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(StringsConstants.USER_ID, id);
  }

  static Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(StringsConstants.USER_ID) ?? '';
  }

  static Future<bool> setUserName(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(StringsConstants.USER_NAME, name);
  }

  static Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(StringsConstants.USER_NAME) ?? '';
  }

  static Future<bool> setUserTeamId(String teamId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(StringsConstants.USER_TEAM_ID, teamId);
  }

  static Future<String> getUserTeamId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(StringsConstants.USER_TEAM_ID) ?? '';
  }
}