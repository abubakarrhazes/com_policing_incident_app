// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/widgets/get_cases.dart';
import 'package:flutter/material.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Reported Cases',
            style: TextStyle(color: KprimaryColor, fontSize: 20),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.file_copy),
                text: 'Reported Cases',
              ),
              Tab(
                icon: Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 30,
                ),
                text: 'Approved Cases',
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
            GetCases(),
            
          ]),
        ),
      ),
    );
  }
}
