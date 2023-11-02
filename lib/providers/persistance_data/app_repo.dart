// ignore_for_file: prefer_final_fields, unused_field, use_build_context_synchronously

import 'dart:convert';

import 'package:com_policing_incident_app/models/user.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRepo extends ChangeNotifier {
  String? _token;
  String? _id;
  User? _user;

  User? get user => _user;
  set user(User? user){
    _user = user;
    notifyListeners();
  }
}
