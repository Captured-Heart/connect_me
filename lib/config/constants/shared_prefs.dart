import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

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

//! SAVE STRING
  static void setStringPref(String key, String value) {
    prefs?.setString(key, value);
    log({'setStringkey': key, 'setStringValue': value}.toString());
  }

//! GET STRING
  static String getStringPref(String key) {
    final getStringPref = prefs?.getString(key) ?? 'null';
    // log(
    //   {'getStringKey': key, 'getStringValue': getStringPref}.toString(),
    // );

    return getStringPref;
  }

//! REMOVE PREF
  static void removePref(String key) {
    log('key: $key');
    prefs?.remove(key);
  }

//! SET BOOL
  static void setBoolPref(String key, {required bool value}) {
    prefs?.setBool(key, value);
    log({'key': key, 'value': value}.toString());
  }

//! BOOL PREF
  static bool getBoolPref(String key) {
    final getBoolPref = prefs?.getBool(key) ?? true;
    log({'getBoolKey': key, 'getBoolValue': getBoolPref}.toString());
    return getBoolPref;
  }
}
