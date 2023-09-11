// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:com_policing_incident_app/controllers/auth_services.dart';
import 'package:com_policing_incident_app/screens/login_screen/models/login_model.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const MaterialColor black = MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Color(0xFFEEEEEE),
    100: Color(0xFFBBBBBB),
    200: Color(0xFF999999),
    300: Color(0xFF555555),
    400: Color(0xFF333333),
    500: Color(0xFF000000),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginformKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final formResult = {};
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginUser() {
    // Make Api Call From The Auth Service Class
    authService.Login(LoginModel(
        email: _emailController.text, password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 4,
            child: Image.asset('assets/images/login.png'),
          ),
          Card(
            margin: const EdgeInsets.only(left: 22, right: 22),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Theme(
              data: ThemeData(primarySwatch: black),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: KprimaryColor),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Expanded(
                            child: Divider(
                                indent: 18, endIndent: 12, thickness: 1.5)),
                        Text(
                          'via',
                          style: TextStyle(color: KprimaryColor),
                        ),
                        Expanded(
                            child: Divider(
                                indent: 12, endIndent: 18, thickness: 1.5))
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkResponse(
                            onTap: () {},
                            child: Image.asset(
                              'assets/images/google.png',
                            ),
                          ),
                          const SizedBox(width: 32),
                          InkResponse(
                            onTap: () {},
                            child: Image.asset(
                              'assets/images/twitter.png',
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Expanded(
                            child: Divider(
                                indent: 18, endIndent: 12, thickness: 1.5)),
                        Text(
                          'or',
                          style: TextStyle(color: Colors.black45),
                        ),
                        Expanded(
                            child: Divider(
                                indent: 12, endIndent: 18, thickness: 1.5))
                      ],
                    ),
                    const SizedBox(height: 18),
                    Form(
                        key: _loginformKey,
                        child: Column(
                          children: [
                            MyInputField(
                              hintText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'Password',
                              isPassword: true,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                            ),
                            const SizedBox(height: 20),
                            ButtonWidget(
                              onPress: () {
                                if (_loginformKey.currentState!.validate()) {
                                  loginUser();
                                }
                              },
                              text: 'Login',
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.only(top: 24, bottom: 16, left: 8, right: 8),
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot');
                    },
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(color: KprimaryColor),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        'Create one',
                        style: TextStyle(
                            color: KprimaryColor, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
