// ignore_for_file: prefer_const_constructors

import 'package:com_policing_incident_app/models/get-models/crime_report.dart';
import 'package:com_policing_incident_app/providers/features-providers/report_incident_provider.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/report_crime/crime_detail_page.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/report_incident/incident_details_page.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/widgets/get_cases.dart';
import 'package:flutter/material.dart';

class GetIncidentCases extends StatefulWidget {
  const GetIncidentCases({super.key});

  @override
  State<GetIncidentCases> createState() => _GetIncidentCasesState();
}

class _GetIncidentCasesState extends State<GetIncidentCases> {
  final ReportIncidentProvider reportIncidentProvider =
      ReportIncidentProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CrimeReport>(
        future: reportIncidentProvider.getreportIncidentByUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IncidentDetailsPage(
                                      crimeData: snapshot.data!.data![index])));
                        },
                        title: Text(
                          'Category: ${snapshot.data!.data![index].category} ',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        subtitle: Text(
                          'Reference Number: ${snapshot.data!.data![index].ref}',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        // Add more UI components as needed
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
