// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:com_policing_incident_app/models/user.dart';
import 'package:com_policing_incident_app/screens/login_screen/models/login_model.dart';
import 'package:com_policing_incident_app/screens/register_screen/models/register_model.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<void> Register(RegisterModel user) async {
    try {
      http.Response response = await http.post(
          Uri.parse('$authbaseUrl/register'),
          body: jsonEncode(user.toJson()),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(' Registered successful: $responseData');
      } else {
        print(response.body);
        print(response.statusCode);
        print(user.toJson());
        print('Server error: ${response}');
        throw Exception('Server error');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Login Api From The Auth Services Class

  Future<void> Login(LoginModel user) async {
    try {
      http.Response response = await http.post(Uri.parse('$authbaseUrl/login'),
          body: jsonEncode(user.toJson()),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Login Succesfully : $responseData');
      } else {
        print(response.body);
        print(response.statusCode);
        print(user.toJson());
        print('Server error: ${response}');
        throw Exception('Server error');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
