// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/models/get-models/crime_report.dart';
import 'package:com_policing_incident_app/models/report_incident_model.dart';
import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/report_crime/model/report_crime_model.dart';
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

  Future<void> reportIncident(CrimeData crimeData, BuildContext context) async {
    String url = '$requestBaseUrl/incident';

    try {
      var response = await _postFormData(url, crimeData);

      if (response.statusCode == 200) {
        _handleSuccessResponse(response, context);
      } else {
        _handleErrorResponse(response, context);
      }
    } on SocketException catch (_) {
      _handleError(context, "Internet connection is not available");
    } catch (e) {
      _handleError(context, " $e Please try again");
      print(e);
    }
  }

  Future<http.StreamedResponse> _postFormData(
      String url, CrimeData crimeData) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    final preferences = await Preferences.getInstance();
    String? token = await preferences.getAccessToken();
    print("Report JWT $token");
    request.headers['Content-Type'] = 'multipart/form-data';
    request.fields['category'] = crimeData.category!;
    request.fields['details'] = crimeData.details!;
    request.fields['location[latitude]'] =
        jsonEncode(crimeData.location!.latitude);
    request.fields['location[logitude]'] =
        jsonEncode(crimeData.location!.logitude);

    print(crimeData.location!.latitude);
    request.fields['policeUnit'] = crimeData.policeUnit!;
    request.fields['address'] = crimeData.address!;
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] = 'Bearer $token';

    var image = await http.MultipartFile.fromPath('image', crimeData.image!);

    request.files.add(image);

    return await request.send();
  }

  void _handleSuccessResponse(
      http.StreamedResponse response, BuildContext context) async {
    _isLoading = false;

    try {
      final responseData = await _parseResponse(response);
      final _resMessageData = responseData["data"]["_id"];
      _resMessage = responseData["message"];
      print(" ID : $_resMessageData");
      utils.successShowToast(context, _resMessage);
      Navigator.pushNamed(context, routes.report_success);
      print(_resMessage);
    } catch (e) {
      print('Error handling success response: $e');
      utils.showToast(context, 'Error handling success response');
    }
  }

  void _handleErrorResponse(
      http.StreamedResponse response, BuildContext context) async {
    try {
      final res = await _parseResponse(response);
      _resMessage = res['message'];
      print(_resMessage);
      utils.showToast(context, _resMessage);

      _isLoading = false;
    } catch (e) {
      print('Error handling error response: $e');
      utils.showToast(context, 'Error handling error response');
    }
  }

  Future<dynamic> _parseResponse(http.StreamedResponse response) async {
    final String responseBody = await response.stream.bytesToString();
    final dynamic decodedResponse = json.decode(responseBody);

    print(decodedResponse);
    return decodedResponse;
  }

  void _handleError(BuildContext context, String errorMessage) {
    _isLoading = false;
    _resMessage = errorMessage;
    utils.showToast(context, _resMessage);
  }

  // Get Incident Users Incident by Id

  Future<CrimeReport> getreportIncidentByUserId() async {
    _isLoading = true;
    _status = true;
    final preferences = await Preferences.getInstance();
    String? token = await preferences.getAccessToken();
    String? userId = await preferences.getUserId();

    print('JWT Token $token');
    print('User Id $userId');

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token '
    };

    try {
      String url = '$requestBaseUrl/incident/$userId/my_incidents';
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == 200) {
        final data = json.decode(response.body.toString());
        return CrimeReport.fromJson(data);
      } else {
        final errorMessage = json.decode(response.body)['message'];
        throw Exception(
            'Failed to load police   ${response.statusCode} error $errorMessage');
      }
    } catch (error) {
      print(":::: $error");
    }
    throw Exception('Failed to load  error');
  }

  // Get Si
}
