// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_field

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
  final _forgot_password_formKey = GlobalKey<FormState>();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
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
            SizedBox(
              height: 10,
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
            Text(
              'Kindly Provide Your Email for Reset Password Link',
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 2,
                  color: KprimaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _forgot_password_formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    MyInputField(
                      controller: _forgotPasswordController,
                      hintText: 'Enter Your email Here',
                      icon: Icon(
                        Icons.email_outlined,
                        color: KprimaryColor,
                      ),
                      validator: (value) {
                        RegExp emailRegExp = RegExp(
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

                        if (value == null || value.isEmpty) {
                          return 'Email can\'t be empty';
                        } else if (!emailRegExp.hasMatch(value)) {
                          return 'Enter a correct email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ButtonWidget(
                        text: 'Reset Now',
                        onPress: () async {
                          if (_forgot_password_formKey.currentState!
                              .validate()) {
                            forgotUserPassword();
                          }
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
