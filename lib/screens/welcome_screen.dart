// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/com_4.png'),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Column(
                children: [
                  Text(
                    'Welcome To PolCop',
                    style: TextStyle(
                        color: KprimaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Get Access To Unlimited Security Features  With Your Mobile App On a Go ',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: KprimaryColor, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    onPress: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    text: 'Login',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    onPress: () {},
                    text: 'Register',
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