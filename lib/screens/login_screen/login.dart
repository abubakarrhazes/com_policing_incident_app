// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, use_build_context_synchronously, prefer_final_fields

import 'package:com_policing_incident_app/models/user.dart';
import 'package:com_policing_incident_app/providers/auth_provider.dart';
import 'package:com_policing_incident_app/screens/login_screen/models/login_model.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/utilities/utils.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/persistance_data/user_adapter.dart';

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

  final formResult = {};
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Utils utils = Utils();
  bool _isLoading = false;

  final AuthProvider authProvider = AuthProvider();

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

  Future<User?> loginUser() {
    return authProvider.loginUser(
        LoginModel(
            email: _emailController.text, password: _passwordController.text),
        context);
  }

  @override
  Widget build(BuildContext context) {
    final userAdapter = Provider.of<UserAdapter>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              child: Image.asset('assets/images/login.png'),
            ),
            SizedBox(
              height: 20,
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
                      const SizedBox(height: 18),
                      Form(
                          key: _loginformKey,
                          child: Column(
                            children: [
                              MyInputField(
                                  hintText: 'Email',
                                  
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  validator: (value) {
                                    RegExp emailRegExp = RegExp(
                                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

                                    if (value == null || value.isEmpty) {
                                      return 'Email can\'t be empty';
                                    } else if (!emailRegExp.hasMatch(value)) {
                                      return 'Enter a correct email';
                                    }
                                    return null;
                                  }),
                              const SizedBox(height: 15),
                              MyInputField(
                                hintText: 'Password',
                                isPassword: true,
                                keyboardType: TextInputType.visiblePassword,
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password Required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              ButtonWidget(
                                onPress: () async {
                                  if (_loginformKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    User? loggedInUser = await loginUser();
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    if (loggedInUser != null) {
                                      userAdapter.user = loggedInUser;

                                      print(
                                          'Logged in user role: ${loggedInUser.roles}');

                                      if (loggedInUser.roles == 'admin' ||
                                          loggedInUser.roles ==
                                              'policeStation') {
                                        // User is an admin, navigate to the admin dashboard
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            routes.admin,
                                            (route) => false);
                                      } else {
                                        // User is a regular user, navigate to the user dashboard
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            routes.home,
                                            (route) => false);
                                      }
                                    }
                                  }
                                },
                                text: 'Login',
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              if (_isLoading)
                                CircularProgressIndicator(
                                  color: KprimaryColor,
                                ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10, bottom: 16, left: 8, right: 8),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, routes.forgot);
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
                          Navigator.pushNamed(context, routes.register);
                        },
                        child: Text(
                          'Create one',
                          style: TextStyle(
                              color: KprimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
