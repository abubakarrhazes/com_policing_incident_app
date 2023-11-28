// ignore_for_file: prefer_final_fields, unused_field, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/models/user.dart';
import 'package:com_policing_incident_app/providers/persistance_data/user_persistance.dart';

import 'package:com_policing_incident_app/screens/login_screen/models/login_model.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:com_policing_incident_app/screens/register_screen/models/register_model.dart';
import 'package:com_policing_incident_app/screens/test.dart';
import 'package:com_policing_incident_app/services/config.dart';
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

  void registerUser(RegisterModel registerModel, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

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
        _resMessage = 'Account Created';
        notifyListeners();
      } else {
        final res = json.decode(response.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  //Login
  void loginUser(LoginModel loginModel, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

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
        final res = json.decode(response.body);
        _isLoading = false;
        _resMessage = 'Login Successfully';

        notifyListeners();
        //
        final accessToken = res['data']['accessToken'];
        final id = res['data']['user']['_id'];
        UserPersistance().saveToken(accessToken);
        UserPersistance().saveUserId(id);
        Navigator.pushNamed(context, routes.home);
        notifyListeners();
        print(accessToken);
        print('Id $id');
      } else {
        final res = json.decode(response.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      print(":::: ${e.toString()}");
    }
  }
}
