// ignore_for_file: prefer_const_constructors

import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _oldPassWordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final _change_password_formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _oldPassWordController.dispose();
    _newPasswordController.dispose();

    super.dispose();
  }

  void changeUserPassword() {
    //
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
                hintText: 'Old Password',
                controller: _oldPassWordController,
              ),
              SizedBox(
                height: 15,
              ),
              MyInputField(
                hintText: 'New Password',
                controller: _newPasswordController,
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
