import 'dart:convert';

import 'package:com_policing_incident_app/screens/login_screen/models/login_model.dart';
import 'package:com_policing_incident_app/screens/register_screen/models/register_model.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static final client = https.Client();
  final Config config = Config();

  Future<bool> login(LoginModel loginModel, BuildContext context) async {
    Map<String, String> requestHeader = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
    };
    final url = Uri.https(config.baseUrl, config.loginUrl);
    final response = await client.post(url,
        headers: requestHeader, body: jsonEncode(loginModel));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String token = responseData['token'];
      await preferences.setString('token', token);
      await preferences.setBool('loggedIn', true);

      print("Login Successfully $responseData");
      return true;
    } else {
      final errorResponse = json.decode(response.body)['message'];
      return errorResponse;
    }
  }

  Future<bool> register(RegisterModel registerModel) async {
    Map<String, String> requestHeader = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
    };
    final url = Uri.https(config.baseUrl, config.signUpUrl);
    final response = await client.post(url,
        headers: requestHeader, body: jsonEncode(registerModel));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      print("Login Successfully $responseData");
      return true;
    } else {
      final errorResponse = json.decode(response.body)['message'];
      return errorResponse;
    }
  }
}
