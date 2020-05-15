import 'dart:async';

import 'package:vshopping/Prefs/preference_base.dart';

class Prefs {
  static Future<String> get id => PreferencesHelper.getString(Const.ID);

  static Future setId(String value) => PreferencesHelper.setString(Const.ID, value);

  static Future<bool> get authenticated => PreferencesHelper.getBool(Const.AUTHENTICATED);

  static Future setAuthenticated(bool value) => PreferencesHelper.setBool(Const.AUTHENTICATED, value);

  static Future<String> get password => PreferencesHelper.getString(Const.PASSWORD);

  static Future setPassword(String value) => PreferencesHelper.setString(Const.PASSWORD, value);

  static Future<void> clear() async {
    await Future.wait(<Future>[
      setAuthenticated(false),
      setId(''),
      setPassword(''),
    ]);
  }
}

class Const {
  static const String ID = 'ID';

  // Default preferences
  static const String AUTHENTICATED = 'AUTHENTICATED';
  static const String PASSWORD = 'PASSWORD';
  static const String FINGERPRINT_ENABLED = 'FINGERPRINT_ENABLED';
}
