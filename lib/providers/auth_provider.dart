// ignore_for_file: prefer_final_fields, unused_field, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/models/user.dart';
import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
import 'package:com_policing_incident_app/providers/persistance_data/user_adapter.dart';
import 'package:com_policing_incident_app/screens/forgot_password_screen/forgot_password.dart';
import 'package:com_policing_incident_app/screens/forgot_password_screen/model/forgot_password_model.dart';

import 'package:com_policing_incident_app/screens/login_screen/models/login_model.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:com_policing_incident_app/screens/register_screen/models/register_model.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final requestBaseUrl = Config.AuthBaseUrl;

  bool _isLoading = false;
  String _resMessage = '';

  //Getters
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  //Register New User

  Future<void> registerUser(
      RegisterModel registerModel, BuildContext context) async {
    String url = '$requestBaseUrl/auth/signup';
    try {
      var response = await _postFormData(url, registerModel);

      if (response.statusCode == 200) {
        _handleSuccessResponse(response, context);
      } else {
        _handleErrorResponse(response, context);
      }
    } on SocketException catch (_) {
      _handleError(context, "Internet connection is not available");
    } catch (e) {
      _handleError(context, "Please try again");
    }
  }

  Future<http.StreamedResponse> _postFormData(
      String url, RegisterModel registerModel) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Content-Type'] = 'multipart/form-data';
    request.fields['firstName'] = registerModel.firstName;
    request.fields['lastName'] = registerModel.lastName;
    request.fields['otherName'] = registerModel.otherName;
    request.fields['email'] = registerModel.email;
    request.fields['phoneNumber'] = registerModel.phoneNumber;
    request.fields['DOB'] = registerModel.DOB;
    request.fields['state'] = registerModel.state;
    request.fields['occupation'] = registerModel.occupation;
    request.fields['address'] = registerModel.address;
    request.fields['password'] = registerModel.password;

    var file = await http.MultipartFile.fromPath(
      'profilePicture',
      registerModel.profilePicture!,
    );
    request.files.add(file);

    return await request.send();
  }

  void _handleSuccessResponse(
      http.StreamedResponse response, BuildContext context) async {
    _isLoading = false;

    try {
      final responseData = await _parseResponse(response);
      _resMessage = responseData["message"];
      utils.successShowToast(context, _resMessage);
      Navigator.pushNamedAndRemoveUntil(
          context, routes.login, (route) => false);
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
    return decodedResponse;
  }

  void _handleError(BuildContext context, String errorMessage) {
    _isLoading = false;
    _resMessage = errorMessage;
    utils.showToast(context, _resMessage);
  }

  //Login
  Future<User?> loginUser(LoginModel loginModel, BuildContext context) async {
    _isLoading = true;

    String url = '$requestBaseUrl/auth/login';

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
    };

    final body = loginModel.toJson();

    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: requestHeaders, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _isLoading = false;

        print("Login Succes : $responseData");

        _resMessage = responseData['message'];

        utils.successShowToast(context, _resMessage);

        print(_resMessage);
        User user =
            User.fromMap(responseData['data']['user'] as Map<String, dynamic>);

        final preferences = await Preferences.getInstance();
        preferences.setAccessToken(responseData['data']['accessToken']);
        preferences.setUserId(user.id);

        print(user.email);
        print(user.profilePicture);

        return user;
      } else {
        final res = json.decode(response.body);

        _resMessage = res['message'];

        utils.showToast(context, _resMessage);

        print(res);
        _isLoading = false;
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      utils.showToast(context, _resMessage);
    } catch (e) {
      print(":::: ${e.toString()}");
    }
    return null;
  }

  //Forgot Password Link

  void forgotPassword(
      ForgotPasswordModel forgotPasswordModel, BuildContext context) async {
    _isLoading = true;

    String url = '$requestBaseUrl/auth/forget/password';

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
    };

    final body = forgotPasswordModel.toJson();

    try {
      http.Response response =
          await http.post(Uri.parse(url), body: body, headers: requestHeaders);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _resMessage = responseData['message'];
        print('Password Reset : $responseData');
        utils.successShowToast(context, _resMessage);
      } else {
        final res = json.decode(response.body);

        _resMessage = res['message'];

        utils.showToast(context, _resMessage);

        print(res);
        _isLoading = false;
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      utils.showToast(context, _resMessage);
    } catch (e) {
      print(":::: ${e.toString()}");
    }
  }
}
