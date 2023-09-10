// ignore_for_file: prefer_const_constructors

import 'package:com_policing_incident_app/controllers/auth_services.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final formResult = {};
  final TextEditingController _forgotPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _forgotPasswordController.dispose();

    super.dispose();
  }

  void forgotUserPassword() {
    // Make Api Call From Auth Services Class
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: KprimaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Image.asset(
            'assets/images/pass.png',
            height: 150,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Reset Password',
            style: TextStyle(
                color: KprimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  MyInputField(
                    controller: _forgotPasswordController,
                    hintText: 'Enter Your email Here',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ButtonWidget(text: 'Reset Now', onPress: () async {})
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
