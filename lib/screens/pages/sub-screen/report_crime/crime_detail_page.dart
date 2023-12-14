// crime_detail_page.dart

// ignore_for_file: prefer_const_constructors

import 'package:com_policing_incident_app/models/get-models/crime_report.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:flutter/material.dart';

class CrimeDetailPage extends StatelessWidget {
  final CrimeData crimeData;

  CrimeDetailPage({required this.crimeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crime Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: KprimaryColor, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: ${crimeData.category}',
                    style: TextStyle(fontSize: 18)),
                Text('Reference Number: ${crimeData.ref}',
                    style: TextStyle(fontSize: 18)),
                Text('Details: ${crimeData.details}',
                    style: TextStyle(fontSize: 18)),
                Text('Status: ${crimeData.status}',
                    style: TextStyle(fontSize: 18)),
                Text('Police Unit: ${crimeData.policeUnit}',
                    style: TextStyle(fontSize: 18)),
                Text('Created At: ${crimeData.createdAt}',
                    style: TextStyle(fontSize: 18)),
                Text('Updated At: ${crimeData.createdAt}',
                    style: TextStyle(fontSize: 18)),
                // Add more details as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}
