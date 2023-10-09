// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:com_policing_incident_app/models/user.dart';
import 'package:com_policing_incident_app/providers/user_provider.dart';
import 'package:com_policing_incident_app/screens/login_screen/models/login_model.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:com_policing_incident_app/screens/register_screen/models/register_model.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:com_policing_incident_app/utilities/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Utils utils = Utils();
  http.Response? response;
  Future<void> Register(RegisterModel user, BuildContext context) async {
    try {
      response = await http
          .post(Uri.parse('$baseUrl/register'), body: user.toJson(), headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/json',
      });
      if (response!.statusCode == 200) {
        final responseData = json.decode(response!.body);
        print(' Registered successful: $responseData');
        httpErrorHandle(
            response: response!, context: context, onSuccess: () {});
      } else {
        print(response!.body);
        print(response!.statusCode);
        print(user.toJson());
        print('Server error: ${response}');
        throw Exception('Server error');
      }
    } catch (e) {}
  }

  //Login Api From The Auth Services Class
  /*

  Future<void> Login(LoginModel user, BuildContext context) async {
    try {
      http.Response response = await http
          .post(Uri.parse('$authbaseUrl/login'), body: user.toJson(), headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Login Succesfully : $responseData');
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () async {
              utils.showSnackBar(context, 'Login Succesfully');
            });
      } else {
        print(response.body);
        print(response.statusCode);
        print(user.toJson());
        print('Server error: ${response}');
        throw Exception('Server error');
      }
    } catch (e) {
      utils.viewShowDialog(context, 'Invalid Credentials', isSuccess: false);
      print(e.toString());
    }
  }
  */

  Future<void> Login(LoginModel user, BuildContext context) async {
    try {
      response = await http
          .post(Uri.parse('$baseUrl/login'), body: user.toJson(), headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/json',
      });
      if (response!.statusCode == 200) {
        final responseData = json.decode(response!.body);
        print(' Login successful: $responseData');
        //After Succesfull Request
        //Navigate to HomeWebView
        Navigator.pushNamed(context, routes.home);
      } else {
        print(response!.body);
        print(response!.statusCode);
        print(user.toJson());
        print('Server error: ${response}');
        throw Exception('Server error');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
