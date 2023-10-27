import 'dart:convert';

import 'package:com_policing_incident_app/models/report_crime_model.dart';
import 'package:com_policing_incident_app/providers/persistance_data/user_persistance.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportCrimeProvider {
  final requestBaseUrl = Config.AuthBaseUrl;

  bool _isLoading = false;
  String _resMessage = '';

  bool _status = false;

  String _response = '';

  bool get getStatus => _status;

  String get getResponse => _response;

  //Getters
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void reportCrime(
      ReportCrimeModel reportCrimeModel, BuildContext context) async {
    _isLoading = true;
    _status = true;

    final userProvider = Provider.of<UserPersistance>(context, listen: false);
    String url = '$requestBaseUrl/api/v1/crime';

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer  ${userProvider.user.accessToken}'
    };

    final body = {
      "category": "Homocide",
      "details": "I Was Assaulted on my way to school",
      "location": {"latitude": "5726323772837", "logitude": "5726323772837"},
      "policeUnit": "zaria police station"
    };

    final response =
        await http.post(Uri.parse(url), headers: requestHeaders, body: body);

    if (response.statusCode == 200) {
      final res = response.body;
      print(requestHeaders);
      print(res);
      _status = false;

      _response = json.decode(res)['message'];
    }
  }

  void getreportCrime(
      ReportCrimeModel reportCrimeModel, BuildContext context) async {
    _isLoading = true;
    _status = true;

    final userProvider = Provider.of<UserPersistance>(context, listen: false);
    String url = '$requestBaseUrl/api/v1/crime';

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer  ${userProvider.user.accessToken}'
    };

    final body = {
      "category": "Homocide",
      "details": "I Was Assaulted on my way to school",
      "location": {"latitude": "5726323772837", "logitude": "5726323772837"},
      "policeUnit": "zaria police station"
    };

    final response =
        await http.post(Uri.parse(url), headers: requestHeaders, body: body);

    if (response.statusCode == 200) {
      final res = response.body;
      print(requestHeaders);
      print(res);
      _status = false;

      _response = json.decode(res)['message'];
    }
  }
}
