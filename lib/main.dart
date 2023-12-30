// ignore_for_file: prefer_const_constructors

import 'package:com_policing_incident_app/admin/features/controllers/MenuAppController.dart';
import 'package:com_policing_incident_app/models/report_incident_model.dart';
import 'package:com_policing_incident_app/providers/auth_provider.dart';
import 'package:com_policing_incident_app/providers/persistance_data/user_adapter.dart';
import 'package:com_policing_incident_app/routes/routes.dart';
import 'package:com_policing_incident_app/screens/forgot_password_screen/forgot_password.dart';
import 'package:com_policing_incident_app/screens/login_screen/login.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:com_policing_incident_app/screens/pages/home_page.dart';
import 'package:com_policing_incident_app/screens/pages/main_page.dart';
import 'package:com_policing_incident_app/screens/pages/profile-menu-pages/user_profile.dart';
import 'package:com_policing_incident_app/screens/pages/report.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/report_incident/report_incident.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/report_success.dart';
import 'package:com_policing_incident_app/screens/register_screen/register.dart';
import 'package:com_policing_incident_app/screens/welcome_screen.dart';

//flimport 'package:com_policing_incident_app/screens/screen_selector.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isViewed = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  isViewed = preferences.getBool('isViewed') ?? false;
  await preferences.setBool('isViewed', true);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => MenuAppController())),
    ChangeNotifierProvider(create: ((context) => UserAdapter())),
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
    _requestLocationPermission();
  }

  void _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted
    } else if (status.isPermanentlyDenied) {
      // Open settings to grant permission
      openAppSettings();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Policing and Incident Repoting app  ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      onGenerateRoute: routes.controller,
      initialRoute: isViewed == false ? routes.splash : routes.login,
    );
  }
}
