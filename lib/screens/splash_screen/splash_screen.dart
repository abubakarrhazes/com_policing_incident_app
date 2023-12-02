// ignore_for_file: prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/police.png',
            width: 150,
            height: 150,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      nextScreen: Text(routes.login),
      splashIconSize: 200,
      splashTransition: SplashTransition.fadeTransition,
      duration: 8000,
      pageTransitionType: PageTransitionType.topToBottom,
      animationDuration: Duration(seconds: 2),
    );
  }
}
