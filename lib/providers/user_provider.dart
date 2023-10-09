// ignore_for_file: unused_field, prefer_final_fields

import 'package:com_policing_incident_app/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      firstName: '',
      lastName: '',
      otherName: '',
      dateOfBirth: '',
      email: '',
      address: '',
      ninNumber: '',
      phoneNumber: '',
      occupation: '',
      password: '',
      state: '',
      userRole: '',
      token: '');

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
  }
}
