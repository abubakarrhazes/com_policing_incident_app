// ignore_for_file: prefer_const_constructors

import 'package:com_policing_incident_app/models/get-models/report_model.dart';

import 'package:com_policing_incident_app/providers/features-providers/report_crime_provider.dart';
import 'package:flutter/material.dart';

class UserReports extends StatefulWidget {
  const UserReports({super.key});

  @override
  State<UserReports> createState() => _UserReportsState();
}

class _UserReportsState extends State<UserReports> {
  List<ReportModels>? crimeReports;

  final ReportCrimeProvider reportCrimeProvider = ReportCrimeProvider();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Call your function to get crime reports
    final reports = await reportCrimeProvider.getreportCrime();
    setState(() {
      crimeReports = reports;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: crimeReports?.length,
      itemBuilder: (context, index) {
        final report = crimeReports![index];
        // Use the report data to build your list item
        return ListTile(
          title: Text(report.data.user),
          subtitle: Text(report.data.details),
          onTap: () {
            // Navigate to detail screen when tapped
          },
        );
      },
    );
  }
}
