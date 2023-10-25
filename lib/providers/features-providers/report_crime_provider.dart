import 'dart:convert';

import 'package:com_policing_incident_app/models/report_crime_model.dart';
import 'package:com_policing_incident_app/providers/persistance_data/user_persistance.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportCrimeProvider extends ChangeNotifier {
  final requestBaseUrl = Config.AuthBaseUrl;
  final UserPersistance userPersistance = UserPersistance();

  bool _isLoading = false;
  String _resMessage = '';

  bool _status = false;

  String _response = '';

  bool get getStatus => _status;

  String get getResponse => _response;

  //Getters
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void reportCrime() async {
    _isLoading = true;
    _status = true;

    final id = userPersistance.getUserId();
    final accessToken = userPersistance.getToken();

    notifyListeners();
    String url = '$requestBaseUrl/api/v1/crime';

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
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

      notifyListeners();
    }
  }
}
