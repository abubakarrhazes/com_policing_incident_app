// ignore_for_file: prefer_const_constructors

import 'package:com_policing_incident_app/admin/features/admin.dart';
import 'package:com_policing_incident_app/providers/user_provider.dart';
import 'package:com_policing_incident_app/routes/routes.dart';
import 'package:com_policing_incident_app/screens/forgot_password_screen/forgot_password.dart';
import 'package:com_policing_incident_app/screens/login_screen/login.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:com_policing_incident_app/screens/pages/home_page.dart';
import 'package:com_policing_incident_app/screens/pages/main_page.dart';
import 'package:com_policing_incident_app/screens/pages/report.dart';

import 'package:com_policing_incident_app/screens/pages/sub-screen/report_crime.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/report_success.dart';
import 'package:com_policing_incident_app/screens/register_screen/register.dart';
import 'package:com_policing_incident_app/screens/welcome_screen.dart';
//flimport 'package:com_policing_incident_app/screens/screen_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isViewed = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  isViewed = preferences.getBool('isViewed') ?? false;
  await preferences.setBool('isViewed', true);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Routes routes = Routes();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Policing and Incident Repoting app  ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: routes.controller,
      initialRoute: isViewed == false ? routes.onboard : routes.welcome,
    );
  }
}
