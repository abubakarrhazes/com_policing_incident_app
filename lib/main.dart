// ignore_for_file: prefer_const_constructors

import 'package:com_policing_incident_app/admin/features/admin.dart';
import 'package:com_policing_incident_app/providers/auth_provider.dart';
import 'package:com_policing_incident_app/providers/persistance_data/user_persistance.dart';
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
    ChangeNotifierProvider(create: ((context) => UserPersistance())),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Routes routes = Routes();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
