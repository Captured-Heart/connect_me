import 'dart:developer';

import 'package:connect_me/app.dart';

class SharedPreferencesHelper {
  static SharedPreferences? prefs;

  static String? theme;

//! INITIALIZE PREF
  static Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

//! CLEAR PREFS
  static Future<void> clearPrefs() async {
    await prefs?.clear();
  }

//? SAVE theme
  static void setStringPref(String key, String value) {
    prefs?.setString(key, value);
    debugPrint({'setStringkey': key, 'setStringValue': value}.toString());
  }

  static String getStringPref(String key) {
    final getStringPref = prefs?.getString(key) ?? '';
    debugPrint(
      {'getStringKey': key, 'getStringValue': getStringPref}.toString(),
    );

    return getStringPref;
  }

//! set true to check for onBoarding
  static void setBoolPref(String key, {required bool value}) {
    prefs?.setBool(key, value);
    debugPrint({'key': key, 'value': value}.toString());
  }

  static bool getBoolPref(String key) {
    final getBoolPref = prefs?.getBool(key) ?? false;
    log({'getBoolKey': key, 'getBoolValue': getBoolPref}.toString());

    return getBoolPref;
  }
}
