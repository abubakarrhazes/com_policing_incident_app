// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_field, prefer_final_fields, await_only_futures

import 'package:com_policing_incident_app/providers/auth_provider.dart';
import 'package:com_policing_incident_app/screens/forgot_password_screen/model/forgot_password_model.dart';
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
  final AuthProvider authProvider = AuthProvider();
  bool _isLoading = false;

  @override
  void dispose() {
    _forgotPasswordController.dispose();

    super.dispose();
  }

  void forgotUserPassword() {
    // Make Api Call From Auth Services Class
    authProvider.forgotPassword(
        ForgotPasswordModel(email: _forgotPasswordController.text), context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
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
                    // Add this variable to track loading state
                    ButtonWidget(
                      text: _isLoading
                          ? 'Resetting Please Wait ...'
                          : 'Reset Now',
                      onPress: () {
                        if (!_isLoading &&
                            _forgot_password_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true; // Set loading state to true
                          });

                          forgotUserPassword(); // Call the function to reset the password

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

                    SizedBox(
                      height: 15,
                    ),
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
