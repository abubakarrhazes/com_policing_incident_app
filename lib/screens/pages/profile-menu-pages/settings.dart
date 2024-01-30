// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _newPasswordController = TextEditingController();
  final _change_password_formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final requestBaseUrl = Config.AuthBaseUrl;

  @override
  void dispose() {
    _newPasswordController.dispose();

    super.dispose();
  }

  Future<void> changePasword(BuildContext context) async {
    // Confirm deletion
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm You want Change Password"),
          content: Text("Are you sure you want to delete this report?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Change Password"),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      final preferences = await Preferences.getInstance();
      String? token = await preferences.getAccessToken();
      String? userId = await preferences.getUserId();

      String url = '$requestBaseUrl/user/$userId';

      final requestHeaders = {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      try {
        http.Response response =
            await http.patch(Uri.parse(url), headers: requestHeaders);

        if (response.statusCode == 200) {
          // Successful deletion
          final responseData = json.decode(response.body)['message'];
          utils.successShowToast(context, responseData);
        } else {
          // Handle errors
          final responseData = json.decode(response.body)['message'];
          utils.showToast(context, responseData);
        }
      } catch (error) {
        print('Error during DELETE request: $error');
        utils.showToast(context, '$error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _change_password_formKey,
            child: Column(children: [
              MyInputField(
                isPassword: true,
                hintText: 'New Password',
                controller: _newPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required Field';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              ButtonWidget(
                text: _isLoading
                    ? 'Resetting Please Wait ...'
                    : 'Change Password',
                onPress: () {
                  if (!_isLoading &&
                      _change_password_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true; // Set loading state to true
                    });

                    // Call the function to reset the password
                    changePasword(context);

                    // You may remove the Future.delayed block if forgotUserPassword is synchronous.
                    // This block is here to simulate an asynchronous operation.
                    Future.delayed(Duration(seconds: 3), () {
                      // After the simulated operation is complete, reset the loading state
                      setState(() {
                        _isLoading = false;
                      });
                    });
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
