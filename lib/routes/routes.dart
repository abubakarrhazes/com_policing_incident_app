// ignore_for_file: constant_identifier_names, prefer_const_constructors

import 'package:com_policing_incident_app/screens/forgot_password_screen/forgot_password.dart';
import 'package:com_policing_incident_app/screens/login_screen/login.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:com_policing_incident_app/screens/pages/home_page.dart';
import 'package:com_policing_incident_app/screens/register_screen/register.dart';
import 'package:com_policing_incident_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

// Routes name

// ignore: constant_identifier_names

class Routes {
  String onboard = '/';
  String welcome = '/welcome';
  String login = '/login';
  String register = '/register';
  String forgot = '/forgot';
  String home = '/home';
  Route<dynamic> controller(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Onboard());
      case '/welcome':
        return MaterialPageRoute(builder: (context) => WelcomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (context) => Register());
      case '/forgot':
        return MaterialPageRoute(builder: (context) => ForgotPassword());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomePage());
      default:
        throw ("Undefined Routes");
    }
  }
}
