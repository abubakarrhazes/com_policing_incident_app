// ignore_for_file: prefer_final_fields, unused_element, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/models/get-models/crime_report.dart';
import 'package:com_policing_incident_app/models/get-models/police.dart';
import 'package:com_policing_incident_app/models/police_station.dart';
import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/blog/models/blog_post.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminProvider {
  //Create Police Station

  final requestBaseUrl = Config.AuthBaseUrl;
  bool _isLoading = false;
  String _resMessage = '';

  //Getters
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  Future<void> adminCreatePoliceStation(Data data, BuildContext context) async {
    String url = '$requestBaseUrl/station';

    final preferences = await Preferences.getInstance();
    String? token = await preferences.getAccessToken();
    print("Report JWT $token");

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final body = json.encode(data.toJson());

    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: requestHeaders, body: body);
      if (response.statusCode == 200) {
        _handleSuccessResponse(response, context);
      } else {
        _handleErrorResponse(response, context);
      }
    } on SocketException catch (_) {
      _handleError(context, "Internet Connection is not available");
    } catch (e) {
      _handleError(context, "Please Try again");
    }
  }

  //Handle Success Response

  void _handleSuccessResponse(
      http.Response response, BuildContext context) async {
    _isLoading = false;

    try {
      final responseData = await _parseResponse(response);
      _resMessage = responseData["message"];
      utils.successShowToast(context, _resMessage);

      print(_resMessage);
    } catch (e) {
      print('Error handling success response: $e');
      utils.showToast(context, 'Error handling success response');
    }
  }

  //Handle Error Response
  void _handleErrorResponse(
      http.Response response, BuildContext context) async {
    try {
      final res = await _parseResponse(response);
      _resMessage = res['message'];
      utils.showToast(context, _resMessage);

      _isLoading = false;
    } catch (e) {
      print('Error handling error response: $e');
      utils.showToast(context, 'Error handling error response');
    }
  }

  //Json Decode Convert

  Future<dynamic> _parseResponse(http.Response response) async {
    final responseBody = response.body;
    final dynamic decodedResponse = await json.decode(responseBody);
    return decodedResponse;
  }

  //Handle Error
  void _handleError(BuildContext context, String errorMessage) {
    _isLoading = false;
    _resMessage = errorMessage;
    utils.showToast(context, _resMessage);
  }

  //Get All Crime
  Future<CrimeReport> adminGetAllCrimeReported() async {
    _isLoading = true;
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

  // Create a Blog Post By Admin

  Future<void> postBlogByAdmin(DataPost dataPost, BuildContext context) async {
    String url = '$requestBaseUrl/blog/post';

    try {
      var response = await _postFormData(url, dataPost);

      if (response.statusCode == 200) {
        handleSuccessResponse(response, context);
      } else {
        handleErrorResponse(response, context);
      }
    } on SocketException catch (_) {
      _handleError(context, "Internet connection is not available");
    } catch (e) {
      _handleError(context, " $e Please try again");
      print(e);
    }
  }

  Future<http.StreamedResponse> _postFormData(
      String url, DataPost dataPost) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    final preferences = await Preferences.getInstance();
    String? token = await preferences.getAccessToken();
    print("Blog Post JWT $token");
    request.headers['Content-Type'] = 'multipart/form-data';
    request.fields['title'] = dataPost.title!;
    request.fields['description'] = dataPost.description!;
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] = 'Bearer $token';

    var image = await http.MultipartFile.fromPath('image', dataPost.image!);

    request.files.add(image);

    return await request.send();
  }

  void handleSuccessResponse(
      http.StreamedResponse response, BuildContext context) async {
    _isLoading = false;

    try {
      final responseData = await parseResponse(response);
      _resMessage = responseData["message"];
      utils.successShowToast(context, _resMessage);
      //Navigator.pushNamed(context, routes.report_success);
      print(_resMessage);
    } catch (e) {
      print('Error handling success response: $e');
      utils.showToast(context, 'Error handling success response');
    }
  }

  void handleErrorResponse(
      http.StreamedResponse response, BuildContext context) async {
    try {
      final res = await parseResponse(response);
      _resMessage = res['message'];
      print(_resMessage);
      utils.showToast(context, _resMessage);

      _isLoading = false;
    } catch (e) {
      print('Error handling error response: $e');
      utils.showToast(context, 'Error handling error response');
    }
  }

  Future<dynamic> parseResponse(http.StreamedResponse response) async {
    final String responseBody = await response.stream.bytesToString();
    final dynamic decodedResponse = json.decode(responseBody);

    print(decodedResponse);
    return decodedResponse;
  }

  void handleError(BuildContext context, String errorMessage) {
    _isLoading = false;
    _resMessage = errorMessage;
    utils.showToast(context, _resMessage);
  }
}
