// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/models/get-models/crime_report.dart';
import 'package:com_policing_incident_app/models/get-models/police.dart';
import 'package:com_policing_incident_app/models/get-models/report_model.dart';
import 'package:com_policing_incident_app/models/police_station.dart';
import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
import 'package:com_policing_incident_app/providers/persistance_data/user_adapter.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
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

  void reportCrimeWithFile(CrimeData crimeReport, BuildContext context) async {
    _isLoading = true;

    String url = '$requestBaseUrl/crime';
    final preferences = await Preferences.getInstance();

    String? token = await preferences.getAccessToken();

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.fields['category'] = json.encode(crimeReport.category);
      request.fields['details'] = json.encode(crimeReport.details);
      request.fields['location'] = json.encode(crimeReport.location);
      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = 'Bearer $token';

      var response = await request.send();
      if (response.statusCode == 200) {
        _isLoading = false;
        final reponseData = json.decode('${response.stream.bytesToString()}');
        _resMessage = 'Crime Reported Successfully $reponseData';

        print(_resMessage);
      } else {
        final res = json.decode('${response.stream.bytesToString()}');

        _resMessage = res['message'];
        utils.successShowToast(context, _resMessage);

        print(res);
        _isLoading = false;
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      utils.showToast(context, _resMessage);
    } catch (e) {
      _isLoading = false;
      _resMessage = "PLease Try Again";
      print('::::: $e');
    }
  }

  //Fetch Police

  Future<Police> getStation() async {
    final preferences = await Preferences.getInstance();
    String? token = await preferences.getAccessToken();

    print('JWT Token $token');

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      String url = '$requestBaseUrl/station';
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == 200) {
        final data = json.decode(response.body.toString());
        return Police.fromJson(data);
      } else {
        final errorMessage = json.decode(response.body)['message'];
        throw Exception(
            'Failed to load police stations  ${response.statusCode} error ${errorMessage}');
      }
    } catch (error) {
      print(error);
    }
    throw Exception('Failed to load  error');

    // ignore: dead_code
  }

  //Get All - Reports

  Future<List<ReportModels>?> getreportCrime() async {
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
      String url = '$requestBaseUrl/crime';
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        print(data);
        //return data.map((json) => PoliceStation.fromJson(json)).toList();
        data.map((json) => ReportData.fromJson(json)).toList();
      } else {
        final errorMessage = json.decode(response.body)['message'];
        throw Exception(
            'Failed to load police stations  ${response.statusCode} error ${errorMessage}');
      }
    } catch (error) {
      print(error);
    }
    return null;
  }

  //Get Report By User ID

  Future<CrimeReport> getreportCrimeByUserId() async {
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
      String url = '$requestBaseUrl/crime/?userId=$userId/my_crimes';
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == 200) {
        final data = json.decode(response.body.toString());
        return CrimeReport.fromJson(data);
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
