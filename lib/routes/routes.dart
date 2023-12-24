// ignore_for_file: constant_identifier_names, prefer_const_constructors, duplicate_ignore, non_constant_identifier_names

import 'package:com_policing_incident_app/admin/features/screens/sub-screen/add_police_station.dart';
import 'package:com_policing_incident_app/admin/features/screens/sub-screen/admin_blog_post.dart';
import 'package:com_policing_incident_app/admin/features/screens/sub-screen/admin_emergency_request.dart';
import 'package:com_policing_incident_app/main.dart';
import 'package:com_policing_incident_app/screens/forgot_password_screen/forgot_password.dart';
import 'package:com_policing_incident_app/screens/login_screen/login.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:com_policing_incident_app/screens/pages/home_page.dart';
import 'package:com_policing_incident_app/screens/pages/profile-menu-pages/help_desk.dart';
import 'package:com_policing_incident_app/screens/pages/profile-menu-pages/more_about.dart';
import 'package:com_policing_incident_app/screens/pages/profile-menu-pages/notifications.dart';
import 'package:com_policing_incident_app/screens/pages/profile-menu-pages/settings.dart';
import 'package:com_policing_incident_app/screens/pages/profile-menu-pages/user_profile.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/blog/blogs.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/emergency_request.dart';

import 'package:com_policing_incident_app/screens/pages/sub-screen/report_crime/report_crime.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/report_incident.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/report_success.dart';

import 'package:com_policing_incident_app/screens/register_screen/register.dart';
import 'package:com_policing_incident_app/screens/splash_screen/splash_screen.dart';

import 'package:com_policing_incident_app/screens/welcome_screen.dart';
import 'package:com_policing_incident_app/admin/features/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

// Routes name

// ignore: constant_identifier_names

class Routes {
  String onboard = '/';
  String splash = '/splash';
  String welcome = '/welcome';
  String login = '/login';
  String register = '/register';
  String forgot = '/forgot';
  String home = '/home';
  String report_crime = '/report-crime';
  String report_incident = '/report-incident';
  String emergency_request = '/emergency-request';
  String blog = '/blog';
  String user_profile = '/user';
  String notifications = '/notifications';
  String more_about = '/more-about';
  String settings = '/settings';
  String help_desk = '/help-desk';
  String report_success = '/success';
  String sign_out = '/sign-out';
  String test = '/test';
  String report_list = '/crime-report-list';
  String admin = '/admin';
  String addPoliceStations = '/add-police-station';
  String dashboard = '/dashboard';

  Route<dynamic> controller(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Onboard());
      case '/splash':
        return MaterialPageRoute(builder: (context) => SplashScreen());
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
      case '/report-crime':
        return MaterialPageRoute(builder: (context) => ReportCrime());
      case '/report-incident':
        return MaterialPageRoute(builder: (context) => MyWidget());

      case '/blog':
        return MaterialPageRoute(builder: (context) => Blogs());
      case '/user':
        return MaterialPageRoute(builder: (context) => UserProfile());
      case '/notifications':
        return MaterialPageRoute(builder: (context) => Notifications());
      case '/more-about':
        return MaterialPageRoute(builder: (context) => MoreAbout());
      case '/settings':
        return MaterialPageRoute(builder: (context) => Settings());
      case '/help-desk':
        return MaterialPageRoute(builder: (context) => HelpDesk());
      case '/success':
        return MaterialPageRoute(builder: (context) => ReportSuccess());

      case '/emergency-request':
        return MaterialPageRoute(builder: (context) => EmergencyRequest());

      //Admin Routes

      case '/admin':
        return MaterialPageRoute(builder: (context) => MainScreen());
      case '/add-police-station':
        return MaterialPageRoute(builder: (context) => AddPoliceStation());
      case '/admin-blog':
        return MaterialPageRoute(builder: (context) => AdminBlogPost());
      case '/admin-emergency':
        return MaterialPageRoute(builder: (context) => AdminEmergencyRequest());

      default:
        throw ("Undefined Routes");
    }
  }
}
