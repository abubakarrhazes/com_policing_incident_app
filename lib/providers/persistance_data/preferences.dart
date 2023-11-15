// ignore_for_file: use_build_context_synchronously

import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  late SharedPreferences _sharedPreferences;
  static Preferences? _instance;

  Preferences._(); // Makes default constructor private

  static Future<Preferences> getInstance() async {
    if (_instance == null) {
      _instance = Preferences._();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<String?> getAccessToken() async {
    return _sharedPreferences.getString('accessToken');
  }

  Future<bool> setAccessToken(String value) {
    return _sharedPreferences.setString("accessToken", value);
  }

  Future<String?> getUserId() async {
    return _sharedPreferences.getString('userId');
  }

  Future<bool> setUserId(String id) {
    return _sharedPreferences.setString("userId", id);
  }

  Future<void> logOutUser(BuildContext context) async {
    final value = await _sharedPreferences;

    value.clear();
    Navigator.pushAndRemoveUntil(
        context, routes.login as Route<Object?>, (route) => false);
  }
}
