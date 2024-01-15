// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:com_policing_incident_app/models/get-models/crime_report.dart';
import 'package:com_policing_incident_app/providers/auth_provider.dart';
import 'package:com_policing_incident_app/providers/features-providers/report_crime_provider.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/model/onboard_model.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/report_crime/crime_detail_page.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:flutter/material.dart';

class GetCases extends StatefulWidget {
  const GetCases({super.key});

  @override
  State<GetCases> createState() => _GetCasesState();
}

final ReportCrimeProvider reportCrimeProvider = ReportCrimeProvider();

class _GetCasesState extends State<GetCases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CrimeReport>(
        future: reportCrimeProvider.getreportCrimeByUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.data!.isEmpty) {
            return Center(
              child: Image.network(
                  'https://dmarcly.com/blog/user/pages/01.home/how-to-fix-no-dmarc-record-found/feature.png'),
            );
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
                          color: KprimaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CrimeDetailPage(
                                  crimeData: snapshot.data!.data![index]),
                            ),
                          );
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
