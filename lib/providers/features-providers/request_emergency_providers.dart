// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/models/emergency_contact.dart';
import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
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
      Data emergencyData, BuildContext context) async {
    _isLoading = true;
    _status = false;
    final preferences = await Preferences.getInstance();
    String? token = await preferences.getAccessToken();

    print('JWT Token $token');

    String url = '$requestBaseUrl/emergency';

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token '
    };

    final body = jsonEncode(emergencyData.toJson());

    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: requestHeaders, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _resMessage = "Contact Added Successfully";
        print(_resMessage);
        utils.successShowToast(context, _resMessage);
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

  //Get Emergency Contacts

  Future<EmergencyContact> getEmergencyContact() async {
    _isLoading = true;
    _status = true;
    final preferences = await Preferences.getInstance();
    String? token = await preferences.getAccessToken();

    print('JWT Token $token');

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token '
    };

    try {
      String url = '$requestBaseUrl/emergency';
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == 200) {
        final data = json.decode(response.body.toString());
        return EmergencyContact.fromJson(data);
      } else {
        final errorMessage = json.decode(response.body)['message'];
        throw Exception(
            'Failed to load police   ${response.statusCode} error ${errorMessage}');
      }
    } catch (error) {
      print(":::: $error");
    }
    throw Exception('Failed to load  error');
  }
}
