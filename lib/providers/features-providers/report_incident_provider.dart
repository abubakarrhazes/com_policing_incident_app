// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/models/report_incident_model.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportIncidentProvider {
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

// Report Incident Route
  void reportIncident(
      ReportIncidentModel reportIncidentModel, BuildContext context) async {
    _isLoading = true;
    _status = true;

    String url = '$requestBaseUrl/api/v1/incident';

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTMxMDBlZmExZDI3ZmU0MTEzZWU1Y2IiLCJpYXQiOjE2OTg1ODgzOTQsImV4cCI6MTY5ODY3NDc5NH0.c4wfOwrVD4iwJXdGexwd-Cqpic2tgJCsRDW-5V-QLTg '
    };

    final body = reportIncidentModel.toJson();

    /*{
      "category": "Homocide",
      "details": "I Was Assaulted on my way to school",
      "location": {"latitude": "5726323772837", "logitude": "5726323772837"},
      "policeUnit": "zaria police station"
    };
    */

    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: requestHeaders, body: body);

      if (response.statusCode == 200) {
        final responseData = response.body;
        _resMessage = "Incident  Reported Succesfully";
        print(requestHeaders);
        print(responseData);
        _status = false;
      } else {
        final res = json.decode(response.body);

        _resMessage = res['message'];

        utils.showToast(context, _resMessage);

        print(res);
        _isLoading = false;
      }
    } on SocketException catch (_) {
      _resMessage = "Internet connection is not available`";
    } catch (e) {
      print(":::: ${e.toString()}");
    }
  }

  // Get Incident Users Incident by Id

  void getreportIncident(
      ReportIncidentModel reportIncidentModel, BuildContext context) async {
    _isLoading = true;
    _status = true;

    String url = '$requestBaseUrl/api/v1/incident';

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer  '
    };
    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      final res = response.body;
      print(requestHeaders);
      print(res);
      _status = false;

      _response = json.decode(res)['message'];
    }
  }

  // Get Single Incident Reported

  void getreportIcident(
      ReportIncidentModel reportIncidentModel, BuildContext context) async {
    _isLoading = true;
    _status = true;

    String url = '$requestBaseUrl/api/v1/incident';

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer  '
    };
    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      final res = response.body;
      print(requestHeaders);
      print(res);
      _status = false;

      _response = json.decode(res)['message'];
    }
  }
}
