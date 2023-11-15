// ignore_for_file: prefer_final_fields, unused_field, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/models/user.dart';
import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
import 'package:com_policing_incident_app/providers/persistance_data/user_adapter.dart';

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

  void registerUser(RegisterModel registerModel, BuildContext context) async {
    _isLoading = true;
    String url = '$requestBaseUrl/auth/signup';

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
    };

    // final body = registerModel.toJson();

    try {
      //http.Response response = await http.post(Uri.parse(url), headers: requestHeaders, body: body);
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
        registerModel.profilePicture,
      );
      request.files.add(file);
      var response = await request.send();
      if (response.statusCode == 200) {
        _isLoading = false;
        final reponseData = json.decode('${response.stream.bytesToString()}');
        _resMessage = 'Account Created $reponseData';

        print(_resMessage);
      } else {
        final res = json.decode('${response.stream.bytesToString()}');

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
        final responseData = jsonDecode(response.body);
        _isLoading = false;
        _resMessage = 'Login Successfully $responseData';

        print(_resMessage);
        User user = User.fromMap(responseData['data']['user']);

        final preferences = await Preferences.getInstance();
        preferences.setAccessToken(responseData['data']['accessToken']);
        preferences.setUserId(user.id);

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
}
