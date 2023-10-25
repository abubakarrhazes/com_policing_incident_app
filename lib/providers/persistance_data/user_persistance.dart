// ignore_for_file: prefer_final_fields, unused_field, use_build_context_synchronously

import 'package:com_policing_incident_app/models/user.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPersistance extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _accessToken = '';

  String _id = '';

  String get accessToken => _accessToken;

  String get id => _id;

  void saveToken(String accessToken) async {
    SharedPreferences value = await _pref;

    value.setString('accessToken', accessToken);
  }

  void saveUserId(String id) async {
    SharedPreferences value = await _pref;

    value.setString('_id', id);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('accessToken')) {
      String data = value.getString('accessToken')!;
      _accessToken = data;
      notifyListeners();
      return data;
    } else {
      _accessToken = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserId() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('_id')) {
      String data = value.getString('_id')!;
      _id = data;
      notifyListeners();
      return data;
    } else {
      _id = '';
      notifyListeners();
      return '';
    }
  }

  void logOut(BuildContext context) async {
    final value = await _pref;

    Navigator.push(context, routes.login as Route<Object?>);

    value.clear();
  }
}
