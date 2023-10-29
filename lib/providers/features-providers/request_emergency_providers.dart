// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/models/add_emergency_contacts_model.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RequestEmergecyProvider {
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

  void addEmergencyContactDetails(
      AddEmergencyContactsModel addEmergencyContactsModel,
      BuildContext context) async {
    _isLoading = true;
    _status = false;

    String url = '$requestBaseUrl/api/v1/emergency';

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTMxMDBlZmExZDI3ZmU0MTEzZWU1Y2IiLCJpYXQiOjE2OTg1ODgzOTQsImV4cCI6MTY5ODY3NDc5NH0.c4wfOwrVD4iwJXdGexwd-Cqpic2tgJCsRDW-5V-QLTg '
    };

    final body = addEmergencyContactsModel.toJson();

    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: requestHeaders, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _resMessage = "Emergency Contact Add Successfully";
        print(_resMessage);
        print(responseData);
      } else {
        final responseData = json.decode(response.body);
        _resMessage = responseData['message'];
        utils.showToast(context, _resMessage);
        print(_resMessage);
      }
    } on SocketException catch (_) {
      _resMessage = "Internet Connection is not Available";
    } catch (e) {
      print(":::: ${e.toString()}");
    }
  }
}
