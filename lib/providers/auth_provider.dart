// ignore_for_file: prefer_final_fields, unused_field, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/models/user.dart';
import 'package:com_policing_incident_app/providers/persistance_data/user_persistance.dart';

import 'package:com_policing_incident_app/screens/login_screen/models/login_model.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:com_policing_incident_app/screens/register_screen/models/register_model.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider {
  final requestBaseUrl = Config.AuthBaseUrl;

  bool _isLoading = false;
  String _resMessage = '';

  //Getters
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void registerUser(RegisterModel registerModel, BuildContext context) async {
    _isLoading = true;
    String url = '$requestBaseUrl/auth/signup';

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
    };

    final body = registerModel.toJson();

    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: requestHeaders, body: body);

      if (response.statusCode == 200) {
        _isLoading = false;
        final reponseData = json.decode(response.body);
        _resMessage = 'Account Created $reponseData';

        print(_resMessage);
      } else {
        final res = json.decode(response.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";

      print(":::: $e");
    }
  }

  //Login
  void loginUser(LoginModel loginModel, BuildContext context) async {
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
        final responseData = json.decode(response.body.toString());
        _isLoading = false;
        _resMessage = 'Login Successfully $responseData';

        final String accessToken = responseData['data']['accessToken'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        Provider.of<UserPersistance>(context, listen: false)
            .setUser(responseData.toString());

        await prefs.setString('accessToken', accessToken);

        //Navigator.pushNamed(context, routes.home);

        print(_resMessage);

        print(accessToken);

        print(responseData);
      } else {
        final res = json.decode(response.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
    } catch (e) {
      print(":::: ${e.toString()}");
    }
  }
}
