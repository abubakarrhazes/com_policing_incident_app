// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:flutter/material.dart';

class MoreAbout extends StatefulWidget {
  const MoreAbout({super.key});

  @override
  State<MoreAbout> createState() => _MoreAboutState();
}

class _MoreAboutState extends State<MoreAbout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Image.asset('assets/images/police.png'),
            Text(
              "More Info About Polcop",
              style: TextStyle(
                  color: KprimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      'Insecurity is a significant issue in the world especially in Nigeria With crimes like armed robbery, kidnapping, terrorism, abuses, rape and ritual killing on the rise, this system is set out to address the following problems AIMS',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
