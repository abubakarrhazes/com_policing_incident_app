// ignore_for_file: prefer_final_fields, unused_field, use_build_context_synchronously

import 'dart:convert';

import 'package:com_policing_incident_app/models/user.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPersistance extends ChangeNotifier {
  User _user = User(
      id: '',
      firstName: '',
      lastName: '',
      otherName: '',
      profilePicture: '',
      DOB: '',
      email: '',
      officeAddress: '',
      phoneNumber: '',
      occupation: '',
      password: '',
      state: '',
      role: '',
      accessToken: '');

  User get user => _user;

  void setUser(String userData) {
    try {
      final Map<String, dynamic> userMap = json.decode(userData);
      _user = User.fromMap(userMap);
      notifyListeners();
    } catch (e) {
      print('Error setting user: $e');
    }
  }

  void setUserFromModel(Map<String, dynamic> userData) {
    try {
      _user = User.fromMap(userData);
      notifyListeners();
    } catch (e) {
      print('Error setting user from model: $e');
    }
  }
  /*

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
  */
}
