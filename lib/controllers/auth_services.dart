// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:com_policing_incident_app/models/user.dart';
import 'package:com_policing_incident_app/screens/login_screen/models/login_model.dart';
import 'package:com_policing_incident_app/screens/register_screen/models/register_model.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:com_policing_incident_app/utilities/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final Utils utils = Utils();
  Future<void> Register(RegisterModel user, BuildContext context) async {
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
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              utils.viewShowDialog(
                  context, 'Account Created Succesfully Proceed to Login',
                  isSuccess: true);
            });
      } else {
        print(response.body);
        print(response.statusCode);
        print(user.toJson());
        print('Server error: ${response}');
        throw Exception('Server error');
      }
    } catch (e) {
      utils.viewShowDialog(context, 'User with this email Already Exist',
          isSuccess: false);
    }
  }

  //Login Api From The Auth Services Class

  late http.Response response;

  Future<void> Login(LoginModel user, BuildContext context) async {
    try {
      response = await http.post(Uri.parse('$authbaseUrl/login'),
          body: jsonEncode(user.toJson()),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Login Succesfully : $responseData');
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              utils.showSnackBar(context, 'Login Succesfull');
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
    }
  }
}
